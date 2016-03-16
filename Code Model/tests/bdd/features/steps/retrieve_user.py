import json
from lettuce import step, world, before
from nose.tools import assert_equals
from app import app
from app.views import USERS

@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given Some users are in the system')
def given_some_users_are_in_the_system(step):
    USERS.update({'fname': 'Josiah', 'mname': 'Timonera', 'lname': 'Regencia',
                'username': 'Josiah.Regencia', 'email': 'jetregencia@gmail.com',
                'password': 'Ki1wkJiKi87m4&95', 'is_active': 'TRUE', 'role_id': 1})

USERS = {}


@step(u'When I retrieve all users')
def when_i_retrieve_all_users(step):
    world.response = world.app.get('/users')


@step(u'Then The following user details are returned:')
def then_the_following_user_details_are_returned(step):
    assert_equals(step.hashes, [json.load(world.response.data)])