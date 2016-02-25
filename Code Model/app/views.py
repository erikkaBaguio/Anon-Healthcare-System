from flask import Flask, jsonify, session, render_template, request, flash, redirect, url_for, abort, g
from flask.ext.login import login_user, logout_user, current_user, login_required
from app import app, db, login_manager
from app.models import DBconn


USERS = {}

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

@app.route('/add' , methods=['POST', 'GET'])
def add():
    if request.method == 'POST':
        post = Post(request.form['title'], request.form['body'])
        db.session.add(post)
        db.session.commit()
        flash('New entry was successfully posted')

    return render_template('add.html')


@login_manager.user_loader  # function loads user from the database
def load_user(id):
    return User.query.get(int(id))


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    username = request.form['username']
    password = request.form['password']
    registered_user = User.query.filter_by(username=username, password=password).first()
    if registered_user is None:
        flash('Username or Password is invalid', 'error')
        return redirect(url_for('login'))
    login_user(registered_user)
    flash('Logged in successfully')
    return redirect(request.args.get('next') or url_for('index'))

@app.route('/addUser', methods=['GET'])
def addUser(fname):

    res = spcall()


@app.route('/users', methods=['GET'])
def loadusers():
    res = spcall('getuserinfo', ())

    if 'Error' in str(res[0][0]):
        return jsonify({'status': 'error', 'message': res[0][0]})

    recs = []

    for r in res:
        recs.append({"id": r[0],
                     "fname": r[1],
                     "mname": r[2],
                     "lname": r[3],
                     "email": r[4],
                     "role": r[5],
                     "is_active": str(r[6])})
    return jsonify({'status': 'OK', 'message': res[0][0]})

