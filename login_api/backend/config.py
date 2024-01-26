from datetime import timedelta

DEBUG = True
SQLALCHEMY_TRACK_MODIFICATIONS = True
CORS_HEADERS = 'Content-Type'
SECRET_KEY = "asdjkgasd$#43"


USER,PWD,SERVER,DB,PORT = ('postgres','qwerty333','192.168.15.22','postgres',5430) 

SQLALCHEMY_DATABASE_URI     = f"postgresql+psycopg2://{USER}:{PWD}@{SERVER}:{PORT}/{DB}"


#================================= HORIZON ======================
CERT_TOKEN          = 'nKLX7w3ZfmuS'
HORIZON_TOKEN       = 'UmVycmpmTFRhWFhaM2luQm9ucU5EYzU3enBZYTpfdVdFbU5oVEJ5Ymp2TEg0Y3k4cEtfU0lab2Nh'
CERT_FILE_NAME      = './config/api-gw1-prod1.fisglobal.com.pfx'
ORGANIZATION_ID     = 'a04d21d5-7561-4449-baa3-ffafcdc14e99'
UUID                = '005822e3-eed6-4fac-ad2a-9942a10aad49'
USER_HORIZON        = 'B258ZOH'
PASSWORD_HORIZON    = 'APZ!mng145@jGF'