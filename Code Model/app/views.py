from flask import render_template, request,flash, redirect, url_for
from app import app, db
from app.models import Post

USERS = {}

@app.route('/add' , methods=['POST', 'GET'])
def add():
    if request.method == 'POST':
        post=Post(request.form['title'], request.form['body'])
        db.session.add(post)
        db.session.commit()
        flash('New entry was successfully posted')

    return render_template('add.html')