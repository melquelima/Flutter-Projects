
from app import app
from werkzeug.security import check_password_hash as CPH
from flask import render_template,send_from_directory

@app.route('/')
@app.route('/<path:path>')
def route_path(path=None):
  return render_template('index.html')


@app.route('/assets/<path:path>', methods=['GET'])
def static_proxy(path):
  return send_from_directory('./static/assets', path)