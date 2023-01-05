from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os

app = Flask(__name__)
app.config.from_object('config')
cors = CORS(app)
ma = Marshmallow(app)
db = SQLAlchemy(app)
#db.create_all()



from app.controllers.API.login import *