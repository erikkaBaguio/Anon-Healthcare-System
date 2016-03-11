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

<<<<<<< HEAD
@app.route('/users', methods=['GET'])
# @auth.login_required
def get_all_users():
    res = spcall('getuserinfo', ())

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
        recs.append({"fname": r[0], "mname": r[1], "lname": r[2], "email": r[3], "password": r[4],
                     "role":r[5], "is_active": str[6]})

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/question/<question_id>/', methods = ['GET'])
def get_question(question_id):
    res= spcall('get_newquestion_id', (question_id))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

@app.route('/question', methods=['GET'])
# def get_question(id){}
    r = res[0]
    return jsonify({"id": r[0], "question": r[1], "user_id": r[2], "category_id": r[3], "done": str(r[4])})


@app.route('/tasks', methods=['GET', 'POST'])
@auth.login_required
def getalltasks():
    res = spcall('gettasks', ())

@app.errorhandler(404)
def page_not_found(e):
    return 'Sorry, the page you were looking for was not found.'


@app.errorhandler(500)
def internal_server_error(e):
    return '(Error 500) Sorry, there was an internal server error.'

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    form = LoginForm()
    if request.method == 'POST':
        user = db.session.query(User).filter(User.email == request.form['email']).one()
        if request.form['password'] == user.password:
            login_user(user, remember=True)
            return redirect(url_for('home'))
        else:
            error = 'Invalid credentials. Try again.'
    return render_template('login.html', title='Sign In', form=form, error=error)

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


if __name__ == '__main__':
    app.run()
