from flask import Flask
from flask_cors import CORS, cross_origin
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow

app = Flask(__name__)
app.config.from_object('config')
cors = CORS(app,resources={r'*':{'origins':'http://localhost:4200'}})
ma = Marshmallow(app)
db = SQLAlchemy(app)


from app.controllers import *
from app.controllers.auth import *
from app.controllers.horizon import *


a = 1