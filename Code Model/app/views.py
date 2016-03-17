
#!flask/bin/python
import os
from os import sys
from flask import Flask, jsonify, render_template, request
# from flask.ext.httpauth import HTTPBasicAuth
from models import DBconn
import json, flask
from app import app



# auth = HTTPBasicAuth()
DISEASES = {}
SYMPTOMS = {}
DISEASE_RECORDS = {}
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

@app.route('/anoncare.api/diseases')
def get_all_diseases_data():
    res = spcall('get_all_diseases_data',())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []
    for r in res:
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

    if 'Error' in str(listOfSymptoms[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    symptom = []
    for r in listOfSymptoms:
        symptom.append({"id": r[0], "name": r[1], "done": str(r[2])})

    return jsonify({'status': 'ok', 'entries': symptom, 'count': len(symptom)})

@app.route('/anoncare.api/symptoms/<int:id>/', methods = ['GET'])
def get_symptom(id):
    res = spcall('get_symptom', str(id))

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    r = res[0]
    return jsonify({"id": str(id), "name": str(r[0]), "done": str(r[1])})

@app.route('/anoncare.api/disease_records', methods = ['GET'])
def get_disease_records():
    diseases = spcall('getalldiseaserecords', ())

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
