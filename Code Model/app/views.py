
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
# from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app

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

@app.route('/admin', methods=['GET'])
def admin_home():
    return render_template('/admin/index.html')

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

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/anoncare.api/diseases/<int:disease_id>/', methods = ['GET'])
def get_disease_data(disease_id):
    res = spcall('get_disease_data', str(disease_id))

    if 'Error' in str(res[0][0]):

        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": str(disease_id), "name": str(r[0]), "done": str(r[1])})

@app.route('/anoncare.api/symptoms', methods = ['GET'])
def get_symptoms():
    listOfSymptoms = spcall('get_all_symptom',())

@app.route('/question/<category_id>/', methods = ['GET'])
def get_question(question_id):
    res= spcall('get_newquestion_id', (category_id))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": r[0], "question": r[1], "user_id": r[2], "category_id": r[3], "is_active": str[4]})

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

@app.route('/anoncare.api/colleges/<int:college_id>/', methods = ['GET'])
def get_college(college_id):
    res = spcall('getcollegeID', str(college_id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"college_id": str(college_id), "college_name": str(r[0])})
    # return jsonify({"fname": r[0], "mname": r[1], "lname": r[2], "email": r[3], "role": r[4],
    #                 "username": r[5]})
    # return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

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
        user_info = request.json

        print "user_info is "
        print user_info


        valueName = user_info['fname']
        valueMName = user_info['mname']
        valueLName = user_info['lname']
        valueEmail = user_info['email']

        res = spcall("newuserinfo", (valueName, valueMName, valueLName, valueEmail, True, 3), True)


        return jsonify({'status': 'ok'})
    return render_template('index2.html')

@app.route('/anoncare.api/departments/<int:department_id>/', methods = ['GET'])
def get_departmet(department_id):
    res = spcall('getdepartmentID', str(department_id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"department_id": str(department_id), "department_name": str(r[0])})

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
