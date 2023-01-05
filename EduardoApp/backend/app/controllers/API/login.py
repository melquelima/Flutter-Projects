from app import app,db
from flask import request,make_response
from werkzeug.security import generate_password_hash as GPH, check_password_hash as CPH
from functools import wraps
import jwt
from datetime import datetime, timedelta
from app.models.db.user import User
from dateUts import *


@app.route('/user',methods=['POST'])
def create_user():
    data = request.get_json()

    hashed_pwd = GPH(data['password'],method="sha256")

    new_user = User(userName=data['userName'],password=hashed_pwd,isAdmin="Y")
    new_user.save()
    return 'User created successfully!'


@app.route('/login',methods=['GET'])
def login():
    auth = request.authorization
    error = make_response('Could not verify',401,{'WWW-Authenticate':'Basic realm="Login required!"'})

    if not auth or not auth.username or not auth.password:
        return error
    
    user = User.query.filter_by(userName=auth.username).first()

    if not user:
        return error

    if CPH(user.password, auth.password):
        exp = datetime.utcnow() + timedelta(minutes=1)
        token = jwt.encode({'id':user.id,'exp':exp},app.config['SECRET_KEY'])
        return {'token': token.decode('UTF-8'),"user":user.toJson()}
    
    return "User or passsword does not match",401



def token_required(f):
    @wraps(f)
    def decorated(*args,**kwargs):
        token = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']
        
        if not token:
            return "Token is missing!",400
        try:
            data = jwt.decode(token,app.config['SECRET_KEY'])
            current_user = User.query.filter_by(id=data['id']).first()
        except jwt.ExpiredSignatureError:
            return 'Signature expired. Please log in again.',401
        except jwt.InvalidTokenError:
            return 'Invalid token. Please log in again.',400
        
        return f(current_user,*args,**kwargs)
    return decorated