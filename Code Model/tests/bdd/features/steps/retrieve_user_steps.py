import json
from lettuce import step, world, before
from nose.tools import assert_equals
from flask import *
from app import app


@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given user already exists with data:')
def given_user_already_exists_with_data(step):
    world.column = step.hashes[0]
    # assert False, 'This step must be implemented'


@step(u'When the System Administrator chooses id \'([^\']*)\'')
def when_the_system_administrator_chooses_id_group1(step, id):
    world.response = world.app.get('/anoncare.api/users/{}/'.format(id))


@step(u'And  the system administrator can retrieve the user.')
def and_the_system_administrator_can_retrieve_the_user(step):
    world.fname = world.column['fname']
    world.mname = world.column['mname']
    world.lname = world.column['lname']
    world.email = world.column['email']
    world.username = world.column['username']
    res = json.loads(world.response.data)
    assert_equals(res['username'], world.username)