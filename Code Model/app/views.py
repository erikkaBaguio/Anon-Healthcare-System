
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request, session, redirect
from functools import wraps
# from flask.ext.httpauth import HTTPBasicAuth
from .models import DBconn
import json, flask
from app import app
# import requests

#auth = HTTPBasicAuth()

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


#############################################AUTHENTICATION#########################################
def check_auth(email, password):
    #this function will check the username and password is valid.

    user = spcall('checkauth',(email, password) )
    print user

    if 'Invalid Username or Password' in str(user[0][0]):
        return jsonify( { 'status': 'error', 'message':user[0][0]} )

    # user_records = []

    # for r in user:
    #     user_records.append({'fname':r[2], 'mname':r[3], 'lname':r[4],
    #                          'email':r[5], 'is_active':r[9]
    #                         })
    return jsonify({"user": user})
    session['logged_in'] = True
    # return jsonify({'status': 'user is logged in', 'entries':user_records})
    return redirect('/admin')


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    return jsonify({'status':'ok'})

#create a wrapper: this wrapper is for athenticating users
def anoncare_login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if session.get('logged_in'):
            if session['logged_in']:
                pass

        else:
            return login()

        return f(*args, **kwargs)

    return decorated

####################################################################################################

@app.route('/admin', methods=['GET', 'POST'])
@anoncare_login_required
def admin_home():
    return render_template('index.html')

@app.route('/api.anoncare/question', methods=['GET'])
def get_all_questions():
    res = spcall('get_newquestion',())
    print res

@app.route('/anoncare.api/diseases')
def get_all_diseases_data():
    res = spcall('get_all_diseases_data',())
    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
        recs.append({"question": r[0], "user_id": r[1], "category_id": r[2], "is_active": str([3])})

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})


@app.route('/api.anoncare/question', methods =['POST'])
def new_question():
    id = request.form['inputID']
    question = request.form['inputquestion']
    user_id = request.form['inputUserID']
    category_id = request.form['inputCategoryID']
    is_active = False
    
    res = spcall('newquestion', (id, question, category_id, is_active), True)

    if 'Error' in res[0][0]:

        recs.append({"id": r[0], "name": r[1], "done": str(r[2])})

    return jsonify({'status': 'OK', 'entries': recs, 'count': len(recs)})

@app.route('/anoncare.api/patient_file/personal_info/', methods =['POST'])
def newpersonal_info():
    
    height = request.form[inputHeight]
    weight = request.form[inputWeight]
    date_of_birth = request.form[inputDateOfBirth]
    civil_status =request.form[inputCivilStatus]
    name_of_guardian = request.form[inputNameOFGuardian]
    home_address = request.form[inputHomeAddress]
    is_active = False

    res = spcall('newpersonal_info', (height,weight, date_of_birth, civil_status, name_of_guardian,
                                      home_address, is_active), True)

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    return jsonify({'status': 'OK', 'message': res[0][0]})


    jsn = json.loads(request.data)
    height = jsn['height']
    weight = jsn['weight']
    date_of_birth = jsn['date_of_birth']
    civil_status = jsn['civil_status']
    name_of_guardian = jsn['name_of_guardian']
    home_address = jsn['home_address']
    is_active = jsn['is_active']

    response = spcall('newpersonal_info', (
        height, 
        weight, 
        date_of_birth, 
        civil_status,
        name_of_guardian,
        home_address,
        is_active), True)
   

    if 'Error' in response[0][0]:
        return  jsonify({'status': 'error', 'message': response[0][0]})
    return jsonify({'status': 'OK', 'message': response[0][0]}), 201

def get_question(question_id):
    res= spcall('get_newquestion_id', (category_id))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": r[0], "question": r[1], "user_id": r[2], "category_id": r[3], "is_active": str[4]})

@app.route('/anoncare.api/colleges/<college_id>/', methods = ['GET'])
def get_college(college_id):
    res = spcall('getcollegeID', str(college_id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"college_id": str(college_id), "college_name": str(r[0])})


@app.route('/anoncare.api/users/<int:id>/', methods=['GET'])
def get_user_with_id(id):
    res = spcall('getuserinfoid', str(id))
    entries = []

    print "res is ", res

    if len(res) == 0:
        return jsonify({"status": "ok", "message": "No User Found"}),
    else:
        row = res[0]
        entries.append({
                        "fname":  row[0],
                        "mname": row[1],
                        "lname": row[2],
                        "email": row[3],
                        "username": row[4]})

        return jsonify({"status": "ok", "message": "ok", "entries": entries})


@app.route('/user/', methods=['POST', 'GET'])
def insertuser():
    if request.method == 'POST':
        user_info = request.get_json(force=True)

        print "user_info is "
        print user_info

        valueName = user_info['fname']
        valueMName = user_info['mname']
        valueLName = user_info['lname']
        valueEmail = user_info['email']
        valueUsername = user_info['username']
        valuePass = user_info['password']



        res = spcall("newuserinfo", (valueName, valueMName, valueLName, valueEmail, valueUsername, valuePass, True), True)


        return jsonify({'status': 'ok'})


# @app.route('/user/', methods=['POST', 'GET'])
# def insertuser():
#     if request.method == 'POST':
#         valueName = request.form.get('fname')
#         valueMName = request.form.get('mname')
#         valueLName = request.form.get('lname')
#         valueEmail = request.form.get('email')
#
#         res = spcall("newuserinfo", (valueName, valueMName, valueLName, valueEmail), True)
#         return jsonify({'status': 'ok'})
#     return render_template('index2.html')
#
#     if 'Error' in res[0][0]:
# 		return jsonify({'status': 'error', 'message': res[0][0]})


@app.route('/anoncare.api/departments/<int:department_id>/', methods = ['GET'])
def get_departmet(department_id):
    res = spcall('getdepartmentID', str(department_id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"department_id": str(department_id),
                    "department_name": str(r[0]),
                    "college_name": str(r[1])})

@app.route('/anoncare.api/vital_signs/<int:vital_signID>', methods = ['GET'])
def get_vital_signs(vital_signID):
    res = spcall('getvitalsignsID', str(vital_signID))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"vital_signID": str(vital_signID),
                    "temperature (C)": str(r[0]),
                    "pulse_rate": str(r[1]),
                    "respiration_rate": str(r[2]),
                    "blood_pressure": str(r[3]),
                    "weight": str(r[4])})

def checkauth(username, password):
    res = spcall('checkauth', (username, password))
    print res
    if 'Invalid username' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0], "username": username, "pass" : password})

    session['logged_in'] = True
    return jsonify({'status': 'ok'}), 201

@app.route('/anoncare.api/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        json_data = request.get_json(force=True)
        username = json_data['username']
        password = json_data['password']
        return checkauth(username, password)
    return render_template('login.html')

@app.route('/anoncare.api/notify/<int:assessment_id>/<int:doctor_id>', methods=['POST'])
def notify(assessment_id, doctor_id):
    response = spcall("createnotify", (assessment_id, doctor_id), True)

    if 'Error' in str(response[0][0]):
        return jsonify({'status': 'error', 'message': response[0][0]})

    return jsonify({'status': response[0][0]})


@app.route('/anoncare.api/patient/<id>/', methods = ['GET'])
def getpatient_file(id):
    response = spcall('get_newpatient_id', id)
    entries = []
    if len(response) == 0:
        return jsonify({"status":"ok", "message": "No patient file found", "entries":[], "count": "0"})
    else:
        row = response[0]
        entries.append({"id": id,
                        "fname": row[0],
                        "mname": row[1],
                        "lname": row[2],
                        "age": row[3],
                        "sex": row[4],
                        "department_id": row[5],
                        "patient_type_id": row[6],
                        "personal_info_id": row[7],
                        "is_active": row[8]})
        return jsonify({"status": "ok", "message": "ok", "entries": entries, "count":len(entries)})


@app.route('/anoncare.api/notify/<int:assessment_id>/<int:doctor_id>', methods=['GET'])
def getnotify(assessment_id, doctor_id):
    notification = spcall("getnotify", (assessment_id, doctor_id))

    if 'Error' in str(notification[0][0]):
        return jsonify({'status': 'error', 'message': notification[0][0]})

    records = []
    for r in notification:
        records.append({ "doctor_id": str(r[0]), "is_read": str(r[1]) })
    return jsonify({'status': 'Ok','entries': records, 'count': len(records) })

@app.route('/anoncare.api/refer/<int:assessment_id>/<int:doctor_id>', methods=['GET'])
def doctor_referral(assessment_id, doctor_id):
    notification = spcall("referDoctor", (assessment_id, doctor_id))

    if 'Error' in str(notification[0][0]):
        return jsonify({'status': 'error', 'message': notification[0][0]})

    records = []
    for r in notification:
        records.append({ "doctor_id": str(r[0]), "is_read": str(r[1]) })
    return jsonify({'status': 'Ok','entries': records, 'count': len(records) })


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
