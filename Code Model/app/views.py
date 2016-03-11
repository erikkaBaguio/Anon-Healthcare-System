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

@app.route('/users', methods=['GET'])
@auth.login_required
def get_all_users():
    res = spcall('get_all_users', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": r[0], "fname": r[1], "mname": r[2], "lname": r[3], "email":r[4], "password": r[5], "done":r[6]})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@auth.get_password
def getpassword(email):
    return spcall("getpassword", (email,))[0][0]


@app.route('/')
def index():
    return render_template('index2.html')

@app.route('/question', methods=['GET'])
def get_question(id){}

@app.route('/tasks', methods=['GET', 'POST'])
@auth.login_required
def getalltasks():
    res = spcall('gettasks', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"id": r[0], "title": r[1], "description": r[2], "done": str(r[3])})

    if request.method == 'POST':
        return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

    return render_template('index.html')

@app.route('/tasks/<int:id>/<string:title>/<string:description>/<string:done>')
def inserttask(id, title, description, done):

    res = spcall("newtask", (id, title, description, done=='true'), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'ok', 'message': res[0][0]})

@app.route('/tasks/delete/<int:id>')
def deletetask(id):

    res = spcall('deletetask', (id, 'true'=='true'),True)

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'Deleted'})

@app.route('/user/', methods=['POST'])
def insertuser():
	valueName = request.form.get('fname')
	valueMName = request.form.get('mname')
	valueLName = request.form.get('lname')
	valueEmail = request.form.get('email')
	valuePass = request.form.get('pass')
	done = ""
	res = spcall("newuserinfo", (valueName, valueMName, valueLName, valueEmail, valuePass, True), True)
	return jsonify({'status': 'ok',})

	if 'Error' in res[0][0]:
		return jsonify({'status': 'error', 'message': res[0][0]})

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

# @app.route('/addUser', methods=['POST'])
# def addUser(fname):


if __name__ == '__main__':
    app.run()
