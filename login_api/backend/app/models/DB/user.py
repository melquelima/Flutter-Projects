from app import db,ma
from sqlalchemy import Float,Column,Integer,String,ForeignKey,DateTime,Time,Boolean,Date
from datetime import datetime,date,timedelta
from marshmallow import Schema, fields

from app.others.mallow import mallow

class User(db.Model):
    __tablename__ = "usuarios"

    id                  = Column(Integer,primary_key=True)
    username            = Column(String(255),nullable = False,unique=True)
    senha               = Column(String(255),nullable = False)
    tax_id              = Column(String(255),nullable = False)
    cust_key            = Column(String(255),nullable = False)

    def __init__(self,username,senha,tax_id,cust_key):
        self.username = username
        self.senha    = senha
        self.tax_id    = tax_id
        self.cust_key    = cust_key

    def __repr__(self):
        return "<User %r>" % self.id

    def save(self):
        db.session.add(self)
        db.session.commit()
    
    def toJson(self,schema=None):
        return mallow(schema if schema else UserSchema,self)



class UserSchema(ma.Schema):
    #id       = fields.Integer()
    username = fields.String()
    #tax_id    = fields.String()
