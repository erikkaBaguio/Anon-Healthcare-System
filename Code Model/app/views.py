from flask import Flask, session, render_template, request, flash, redirect, url_for, abort, g
from flask.ext.login import login_user, logout_user, current_user, login_required
from app import app, db, login_manager
from app.models import Post, User


@app.route('/add', methods=['POST', 'GET'])
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
