from flask import render_template, request,flash, redirect, url_for
from app import app, db
from app.models import Post

@app.route('/add' , methods=['POST', 'GET'])
def add():
    if request.method == 'POST':
        post=Post(request.form['title'], request.form['body'])
        db.session.add(post)
        db.session.commit()
        flash('New entry was successfully posted')

    return render_template('add.html')

#function loads user from the database
@login_manager.user_loader
def load_user(id):
    return User.query.get(int(id))