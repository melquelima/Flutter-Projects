from flask import request
from functools import wraps
import jwt
from app import app
from app.models.DB.user import User



def token_required(function):
    @wraps(function)
    def wrapper(*args, **kwargs):

        token = None

        if not "token" in request.headers:
            return "Token is missing!",400
        token = request.headers['token']
        
        try:
            data = jwt.decode(token,app.config['SECRET_KEY'])
        except jwt.ExpiredSignatureError:
            return "Session Expired",401
        except:
            return "Invalid token!",401
        
        current_user = User.query.get(data["id"])

        kwargs["current_user"] = current_user

        return function(*args, **kwargs)
        
    return wrapper



