
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request, session, redirect
from functools import wraps
# from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app
import requests

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

@app.route('/anoncare.api/users/<int:id>/', methods=['GET'])
def get_user_with_id(id):
    res = spcall('getuserinfoid', str(id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]

    return jsonify({"fname": str(r[0]), "mname": str(r[1]), "lname": str(r[2]),
                    "email": str(r[3]), "username": str(r[4])})

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
    return render_template('index2.html')

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

@app.route('/anoncare.api/assessments/<int:assessment_id>/', methods=['GET'])
def view_assessment(assessment_id):
    assessment = spcall("getassessmentID", str(assessment_id))

    if 'Error' in str(assessment[0][0]):
        return jsonify({'status': 'error', 'message': notification[0][0]})

    records = []
    for r in assessment:
        records.append({"Date": str(r[0]), "Patient": str(r[1]),
                        "Age": str(r[2]), "Department": str(r[3]),
                        "Vital Signs": str(r[4]), "Chief Complaint": str(r[5]),
                        "History of patient illness": str(r[6]), "Medications taken": str(r[7]),
                        "Diagnosis": str(r[8]), "Recommendation": str(r[9]),
                        "Attending Physician": str(r[10])})

    return jsonify({'status': 'OK', 'entries': records, 'count': len(records)})

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
