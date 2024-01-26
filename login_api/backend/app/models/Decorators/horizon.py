from app import app
import requests
from functools import wraps
import json
import xmltodict

from app.others.pfx_load import pfx_to_pem

def horizon_login(function):
    @wraps(function)
    def wrapper(*args, **kwargs):
        lgn = login_horizon()
        if not lgn[0]: 
            return lgn[1],400
        print("Finishing Token")
        
        print("Starting Login")
        sgn = sign_on_horizon(lgn[1]['access_token'])
        print("Finishing Login")

        return function(*args, **kwargs,auth_hrzn=sgn[1])
        
    return wrapper



def is_json(myjson):
    try:
        json.loads(myjson)
    except ValueError as e:
        return False
    return True


def login_horizon():
    HORIZON_TOKEN = app.config['HORIZON_TOKEN']
    
    url = 'https://api-gw1-prod1.fisglobal.com/token'
    payload='grant_type=client_credentials'
    headers = {
            "Host":             "api-gw1-prod1.fisglobal.com",
            "Connection":       "keep-alive",
            "Content-Length":   "29",
            "Content-Type":     "application/x-www-form-urlencoded",
            "Authorization":    f'Basic {HORIZON_TOKEN}'
            }
    
    response = request_cert("POST",url,headers,payload)
    
    return response


def sign_on_horizon(token:str):

    ORGANIZATION_ID  = app.config['ORGANIZATION_ID']
    UUID             = app.config['UUID']
    USER_HORIZON     = app.config['USER_HORIZON']
    PASSWORD_HORIZON = app.config['PASSWORD_HORIZON']

    url = "https://api-gw1-prod1.fisglobal.com/api/horizon/information-security/v1/signonrq"
    payload = f"<?xml version='1.0'?><SignonRq><VENDORID/><SEQUENCE>87654321</SEQUENCE><UserID>{USER_HORIZON}</UserID><PassWord>{PASSWORD_HORIZON}</PassWord><Release>2020_01</Release></SignonRq>"
    headers = {
      'accept': '*/*',
      'organization-id': ORGANIZATION_ID,
      'uuid': UUID,
      'Content-Type': 'text/plain',
      'Authorization': f'Bearer {token}'
    }
    
    response = request_cert("POST",url,headers,payload,"xmltojson")

    print(f'rsp->{response}')
    obj = response[1]
    
    if response[0]:
        if not 'SignonTKN' in obj['SignonRs']['ResponseData']:
            return (False,obj['SignonRs']['ResponseData'])
        cred = {
          'SignonTKN':          obj['SignonRs']['ResponseData']['SignonTKN'],
          'organization-id':    ORGANIZATION_ID,
          'uuid':               UUID,
          'Authorization':      f'Bearer {token}'
        }
        return (True, cred)
    else:
        return response

def request_cert(method,url,headers,payload,Encrypt='json'):
    
    #print(requests.get("https://api.ipify.org/?format=json").json())
    CERT_FILE_NAME = app.config['CERT_FILE_NAME']
    CERT_TOKEN     = app.config['CERT_TOKEN']
    with pfx_to_pem(CERT_FILE_NAME, CERT_TOKEN) as cert:
        response = requests.request(method, url,cert=cert, headers=headers, data=payload)
    
    data = None
    
    if is_json(response.text):
        data = response.json()
        
    
    if 'fault' in (data if data else []):
        err = data['fault']['message'] + " " + data['fault']['description']
        return (False,"ERROR: " + err)
    
    #try:
    if Encrypt == "json":
        data = response.json()
    elif Encrypt == "xmltojson":
        try:
            data = xmltodict.parse(response.text.replace("&","&amp;").replace(chr(25),""))
        except Exception as e:
            return (False, response.text)
    else:
        data = response.text
    
    keys = list(data.keys())
    if data.keys():
        if "ERROR" in data[keys[0]]: return (False,data[keys[0]]["ERROR"]["ERRORMSG"])
    
    #except:
    #    data = response.text
    
    
    return (True, data)