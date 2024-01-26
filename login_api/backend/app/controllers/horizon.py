from flask import jsonify
from app import app
from app.models.Decorators.auth import token_required
from app.models.Decorators.fields import *
from app.models.Decorators.horizon import horizon_login, request_cert
from app.models.Horizon.functions import custacctdetrq, custaddrinqrq, depaccttrninqrq
from dateUts import *

from app.others import to_list

@app.route('/api/get_portfolio')
@token_required
@horizon_login
def get_portfolio(current_user,auth_hrzn):

    params = f"<CUSTKEY>{current_user.cust_key}</CUSTKEY><VWUNDPREL>Y</VWUNDPREL><NBRRECTORT>999</NBRRECTORT><SRCHCSTTKN></SRCHCSTTKN>"
    url = "https://api-gw1-prod1.fisglobal.com/api/horizon/customer/v1/custportinqrq"
    payload = f"<?xml version='1.0'?><CustPortInqRq><SgnonToKeN>{auth_hrzn['SignonTKN']}</SgnonToKeN><VENDORID/><SEQUENCE>12345678</SEQUENCE>{params}</CustPortInqRq>"
    auth_hrzn["Content-Type"]="text/plain"
    #print(payload)
    
    resp = request_cert("POST",url,auth_hrzn,payload,"xmltojson")
    if not resp[0]:return "Error getting accounts",400
    response = resp[1]["CustPortInqRs"]["ResponseData"]

    depAccts = response["DEPACCOUNT"] if "DEPACCOUNT" in response else []
    depAccts = depAccts if isinstance(depAccts,list) else [depAccts]
    depAccts = [{k:v for k,v in val.items() if k in ["ACTNBR","AVAILBAL","SHORTNAME","PRODUCT","OFFICER"]} for val in depAccts if val["ACTSTATUS"] != '9']
    
    timeAccts = response["TIMEACCOUNT"] if "TIMEACCOUNT" in response else []
    timeAccts = timeAccts if isinstance(timeAccts,list) else [timeAccts]
    timeAccts = [{k:v for k,v in val.items() if k in ["ACTNBR","AVAILBAL","SHORTNAME","PRODUCT","OFFICER"]} for val in timeAccts if val["ACTSTATUS"] != '9']

    return jsonify([*depAccts,*timeAccts])

@app.route('/api/get_transactions',methods=["POST"])
@fields_get()
@fields_required({"actnbr":str})
@token_required
@horizon_login
def get_transactions(current_user,auth_hrzn,fields):

    transactions = depaccttrninqrq(auth_hrzn,fields["actnbr"],sqlToDate("2023-01-01"),today())
    if not transactions[0]: return transactions[1],400
    transactions = transactions[1]
    trans = [{k:v if not k in["CURRBAL","TRANAMT"] else float(v) for k,v in val.items() if k in ["TRANAMT","TRANDESC","TRANDESCS","CURRBAL","DRCRFLAG","TRANDATE"]} for val in transactions if val["DRCRFLAG"] != None]

    
    return jsonify(trans)


@app.route('/api/customer_details')
@fields_get()
@token_required
@horizon_login
def get_customer_details(current_user,auth_hrzn,fields):

    details = custacctdetrq(auth_hrzn,current_user.cust_key)
    if not details[0]: return details[1],400
    details = details[1]

    full_name = details["CUSTSEG"]["NALINE1"]
    emails = to_list(details["EMAILSEG"]["EMAILS"])
    emails = [{"email":x['INETADDR'],"pref_seq":x["PREFSEQ"]} for x in emails]

    phones = to_list(details["PHONESEG"]["PHONES"])
    area_code = lambda x:f" {x['AREACODE']}" if (x['AREACODE'] or "").strip() not in ['','0'] else ""
    phone_type = lambda x:f" ({x['PHONETYPE']})" if (x['PHONETYPE'] or "").strip() not in ['','0'] else ""
    phones = [{"phone":f"+{x['COUNTRYCD']}{area_code(x)} {x['PHONENBR']}{phone_type(x)}","pref_seq":x["PREFSEQ"]} for x in phones]

    address = custaddrinqrq(auth_hrzn,current_user.cust_key)
    if not address[0]: return address[1],400
    address = address[1]

    address = to_list(address["AddrSegment"])
    remove_null = lambda x: x or ""
    keys = ['ADDR1STNBR','ADDR1STNM','ADDR2STNBR','ADDR2STNM','CITY','STATE','ZIPCODE','FRGNPOSTCD','FRGNCTRYNM']
    addresses = [{"primary":remove_null(x['PRIMADDR']),"address":" ".join(remove_null(x[k]) for k in keys if remove_null(x[k]))} for x in address]

    return jsonify({"full_name":full_name,"phones":phones,"emails":emails,"addresses":addresses})

