#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app

auth = HTTPBasicAuth()

QUESTIONS = {}
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

@auth.get_password
def getpassword(email):
    return spcall("getpassword", (email,))[0][0]


@app.route('/')
def index():
    return render_template('index.html')



@app.route('/question', methods=['GET'])
def get_all_questions():
    res= spcall('get_newquestion',())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"question": r[0], "user_id": r[1], "category_id": r[2], "done": str(r[3])})
    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/question/<question_id>/', methods = ['GET'])
def get_question(question_id):
    res= spcall('get_newquestion_id', (question_id))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": r[0], "question": r[1], "user_id": r[2], "category_id": r[3], "done": str(r[4])})

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
