
from app import app
from werkzeug.security import check_password_hash as CPH
from flask import request,make_response,url_for,session
from app.models.DB.user import User,UserSchema

from datetime import timedelta
from datetime import datetime
import jwt
from app.others.mallow import *
from werkzeug.security import check_password_hash as CPH


@app.route('/login')
def login():
    session["test"] = "asdasdasdasd"
    session.modified = True
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return "Insira o usuario e senha",401

    user = User.query.filter_by(username=auth.username).first()

    if not user:
        return "Usuario ou senha invalidos!",401


    if user.senha == auth.password:
        token = jwt.encode({'id':user.id,'exp':datetime.utcnow() + timedelta(minutes=30)},app.config['SECRET_KEY'])
        rsp = make_response({'token': token.decode('UTF-8'),'user':user.toJson()})
        return rsp
    else:
        return "User or password invalid!",401

@app.route('/sessionActive/<string:token>')
def sessionActive(token):
    try:
        jwt.decode(token,app.config['SECRET_KEY'])
        return {"status":True,"message":"token valido!"}
    except:
        return {"status":False,"message":"token invalido!"}







