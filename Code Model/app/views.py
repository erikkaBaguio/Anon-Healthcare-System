
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
# from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app

<<<<<<< HEAD
USERS = {}
QUESTIONS = {}
CATEGORY = {}
auth = HTTPBasicAuth()
=======
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f


# auth = HTTPBasicAuth()
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

<<<<<<< HEAD
=======
@app.errorhandler(404)
def page_not_found(e):
    return 'Sorry, the page you were looking for was not found.'

@app.errorhandler(500)
def internal_server_error(e):
    return '(Error 500) Sorry, there was an internal server error.'
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/dashboard/')
def dashboard():
    return render_template('dashboard.html')

<<<<<<< HEAD
@app.route('/api.anoncare/question', methods=['GET'])
def get_all_questions():
    res = spcall('get_newquestion',())
    print res
=======
@app.route('/anoncare.api/diseases')
def get_all_diseases_data():
    res = spcall('get_all_diseases_data',())

>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f
    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
<<<<<<< HEAD
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
=======
        recs.append({"id": r[0], "name": r[1], "done": str(r[2])})

    return jsonify({'status': 'ok', 'entries': recs, 'count': len(recs)})

@app.route('/anoncare.api/diseases/<int:disease_id>/', methods = ['GET'])
def get_disease_data(disease_id):
    res = spcall('get_disease_data', str(disease_id))

    if 'Error' in str(res[0][0]):
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": str(disease_id), "name": str(r[0]), "done": str(r[1])})

@app.route('/anoncare.api/symptoms', methods = ['GET'])
def get_symptoms():
    listOfSymptoms = spcall('get_all_symptom',())

<<<<<<< HEAD
@app.route('/question/<category_id>/', methods = ['GET'])
def get_question(question_id):
    res= spcall('get_newquestion_id', (category_id))

    if 'Error' in res[0][0]:
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": r[0], "question": r[1], "user_id": r[2], "category_id": r[3], "is_active": str[4]})



@app.route('/api.anoncare/question_category', methods = ['GET'])
def get_all_category():
    res =spcall('get_newquestion_category', ())
=======
    if 'Error' in str(listOfSymptoms[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    symptom = []
    for r in listOfSymptoms:
        symptom.append({"id": r[0], "name": r[1], "done": str(r[2])})

    return jsonify({'status': 'ok', 'entries': symptom, 'count': len(symptom)})

@app.route('/anoncare.api/symptoms/<int:id>/', methods = ['GET'])
def get_symptom(id):
    res = spcall('get_symptom', str(id))
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

<<<<<<< HEAD
    recs = []
    for r in res:
        recs.append({"category_name": r[0], "is_active": str(r[1])})
    return jsonify({'status': 'OK', 'entries': recs, 'count':len(recs)})



    
@app.route('/api.anoncare/question_category/<id>/', methods = ['GET'])
def get_category(id):
    res = spcall('get_newquestion_category_id', (id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": (id), "category_name": str(r[0]), "done": str(r[1])})



@app.route('/tasks', methods=['GET', 'POST'])
@auth.login_required
def getalltasks():
    res = spcall('gettasks', ())
=======
    r = res[0]
    return jsonify({"id": str(id), "name": str(r[0]), "done": str(r[1])})

@app.route('/anoncare.api/disease_records', methods = ['GET'])
def get_disease_records():
    diseases = spcall('getalldiseaserecords', ())
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f

    if 'Error' in str(diseases[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    disease = []
    for r in diseases:
        disease.append({"id": r[0], "disease_id": r[1], "symptom_id": r[2], "done": r[3]})

    return jsonify({'status': 'ok', 'entries': disease, 'count': len(disease)})

@app.route('/anoncare.api/disease_records/<int:id>/', methods = ['GET'])
def get_disease_recordID(id):
    disease_records = spcall('getdiseaserecordID', str(id))

    if 'Error' in str(disease_records[0][0]):
        return jsonify({'status': 'error', 'message': disease_records[0][0]})

    disease = disease_records[0]
    return jsonify({"id": str(id), "disease_id": str(disease[0]), "symptom_id": str(disease[1]), "done": str(disease[2])})

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
