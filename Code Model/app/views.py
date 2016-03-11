#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app

auth = HTTPBasicAuth()

def spcall(qry, param, commit=False):
    try:
        dbo = DBconn()
        cursor = dbo.getcursor()
        cursor.callproc(qry, param)
        res = cursor.fetchall()
        if commit:
            dbo.dbcommit()
        return res
    except:
        res = [("Error: " + str(sys.exc_info()[0]) + " " + str(sys.exc_info()[1]),)]
    return res

@app.route('/')
def index():
    return render_template('index.html')

@app.errorhandler(404)
def page_not_found(e):
    return 'Sorry, the page you were looking for was not found.'

@app.errorhandler(500)
def internal_server_error(e):
    return '(Error 500) Sorry, there was an internal server error.'

@app.route('/users', methods=['POST'])
@auth.login_required
def get_all_users():
    res = spcall('get_all_users', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": r[0], "fname": r[1], "mname": r[2], "lname": r[3], "email":r[4], "password": r[5], "role": [6], "done":r[7]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/users', methods=['GET'])
@auth.login_required
def get_all_users():
    res = spcall('get_all_users', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": r[0], "fname": r[1], "mname": r[2], "lname": r[3], "email":r[4], "password": r[5], "role": [6], "done":r[7]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@auth.get_password
def getpassword(email):
    return spcall("getpassword", (email,))[0][0]


@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging


    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp


if __name__ == '__main__':
    app.run()
