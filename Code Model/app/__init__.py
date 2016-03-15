from flask import Flask, render_template, request, flash, redirect, url_for
from flask.ext.login import LoginManager
# from flask_restful import Resource, Api
from flask.ext.sqlalchemy import SQLAlchemy


#Create an Instance of Flask
app = Flask(__name__)

from app import views
