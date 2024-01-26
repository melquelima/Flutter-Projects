

from dateUts import *
from app.models.Decorators.horizon import request_cert


def depaccttrninqrq(auth_hrzn,ACC,BEGINDATE,ENDDATE,SearchTKN="",dataToReturn=[]):
    applcd_type = {"1":"DD","2":"SV","3":"CD"}


    BEGIN_DATE = fmtDate(BEGINDATE,"%Y%m%d")
    END_DATE   = fmtDate(ENDDATE,"%Y%m%d")
    APPLCD    = applcd_type[ACC[0]]

    url                       = "https://api-gw1-prod1.fisglobal.com/api/horizon/deposits-demand-savings/v1/depaccttrninqrq"
    payload                   = f"<?xml version='1.0'?><DepAcctTrnInqRq><SgnonToKeN>{auth_hrzn['SignonTKN']}</SgnonToKeN><VENDORID/><SEQUENCE>12345678</SEQUENCE><APPLCD>{APPLCD}</APPLCD><ACTNBR>{ACC}</ACTNBR><DTSELTOPT>T</DTSELTOPT><BEGINDATE>{BEGIN_DATE}</BEGINDATE><ENDDATE>{END_DATE}</ENDDATE><FIRSTNEXT>F</FIRSTNEXT><NBRRECTORT>100</NBRRECTORT><SEQOPT>D</SEQOPT><RTNMEMOPST>Y</RTNMEMOPST><SRCHCSTTKN>{SearchTKN}</SRCHCSTTKN></DepAcctTrnInqRq>"
    auth_hrzn["Content-Type"] = "text/plain"

    resp = request_cert("POST",url,auth_hrzn,payload,"xmltojson")
    if not resp[0]: return resp
    resp = resp[1]["DepAcctTrnInqRs"]

    trans = resp["ResponseData"]["TRANSACTION"]

    if "SearchTKN" in resp:
        tkn = resp["SearchTKN"]
        return depaccttrninqrq(auth_hrzn,ACC,BEGINDATE,ENDDATE,SearchTKN=tkn,dataToReturn=dataToReturn+trans)

    return True,dataToReturn+trans



def custacctdetrq(auth_hrzn,CUSTKEY):

    url                       = "https://api-gw1-prod1.fisglobal.com/api/horizon/customer/v1/custacctdetrq"
    key                       = "CustAcctDetRq"
    key_s                     = key[0:-1] + "s"
    payload                   = f"<TAXIDNBR/><CUSTKEY>{CUSTKEY}</CUSTKEY><TINAGGR>N</TINAGGR><INTERFACE/><OWNERTYPE/><RETRNNACAP/><VWUNDPREL>Y</VWUNDPREL><SRCHDIRCT/><SRCHAPPLCD/><SRCHACTNBR/><NBRACTTORT>5</NBRACTTORT><INCLRROD>N</INCLRROD><NBRPHONERT>5</NBRPHONERT><NBREMAILRT>5</NBREMAILRT><RTCUSTINFO>Y</RTCUSTINFO><RTDUPRESV>N</RTDUPRESV>"
    payload                   = f"<?xml version='1.0'?><{key}><SgnonToKeN>{auth_hrzn['SignonTKN']}</SgnonToKeN><VENDORID/><SEQUENCE>12345678</SEQUENCE>{payload}</{key}>"
    auth_hrzn["Content-Type"] = "text/plain"

    resp = request_cert("POST",url,auth_hrzn,payload,"xmltojson")
    if not resp[0]: return resp
    resp = resp[1][key_s]

    data = resp["RESPONSEDATA"]

    return True,data


def custaddrinqrq(auth_hrzn,CUSTKEY):

    url                       = "https://api-gw1-prod1.fisglobal.com/api/horizon/customer/v1/custaddrinqrq"
    key                       = "CustAddrInqRq"
    key_s                     = key[0:-1] + "s"
    payload                   = f"<CUSTKEY>{CUSTKEY}</CUSTKEY><ADDRSEQ>999</ADDRSEQ><NBRRECTORT>999</NBRRECTORT>"
    payload                   = f"<?xml version='1.0'?><{key}><SgnonToKeN>{auth_hrzn['SignonTKN']}</SgnonToKeN><VENDORID/><SEQUENCE>12345678</SEQUENCE>{payload}</{key}>"
    auth_hrzn["Content-Type"] = "text/plain"

    resp = request_cert("POST",url,auth_hrzn,payload,"xmltojson")
    if not resp[0]: return resp
    resp = resp[1][key_s]

    data = resp["ResponseData"]

    return True,data


