
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
# from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app


# auth = HTTPBasicAuth()
COLLEGES = {}
DISEASES = {}
SYMPTOMS = {}
DISEASE_RECORDS = {}
QUESTIONS = {}
APPOINTMENTS = {}

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


@app.errorhandler(404)
def page_not_found(e):
    return 'Sorry, the page you were looking for was not found.'

@app.errorhandler(500)
def internal_server_error(e):
    return '(Error 500) Sorry, there was an internal server error.'


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/dashboard/')
def dashboard():
    return render_template('dashboard.html')


@app.route('/anoncare.api/departments/<int:department_id>/', methods = ['GET'])
def get_departmet(department_id):
    res = spcall('getdepartmentID', str(department_id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"department_id": str(department_id), "department_name": str(r[0])})

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
