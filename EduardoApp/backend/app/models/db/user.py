from app import db,ma
from marshmallow import fields
from app.models.others.mallow import *

from SqlUts import tblUts

class User(db.Model,tblUts(db)):
    __tablename__ = "users"

    userName = db.Column(db.String(50),unique=True)
    password = db.Column(db.String(80))
    isAdmin = db.Column(db.String(1))

    def __init__(self,userName,password,isAdmin):
        self.userName = userName
        self.password = password
        self.isAdmin = isAdmin
    def toJson(self,schema = None):
        return mallow(schema if schema else UserSchema,self)

class UserSchema(ma.Schema):
    id       = fields.Integer()
    userName = fields.String()
    isAdmin = fields.String()
