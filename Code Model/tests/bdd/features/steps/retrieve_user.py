# coding=utf-8
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
    USERS.update({'id': '2', 'fname': 'Josiah', 'mname': 'Timonera', 'lname': 'Regencia',
                  'username': 'Josiah.Regencia', 'email': 'jetregencia@gmail.com',
                  'password': 'Ki1wkJiKi87m4&95', 'is_active': 'TRUE', 'role_id': '1'})
    # assert False, 'This step must be implemented'


@step(u'I retrieve all users')
def when_i_retrieve_user_with_id_3(step):
    world.response = world.app.get('/users/{}')
    # assert False, 'This step must be implemented'


@step(u'Then I should get a ‘200’ response')
def then_i_should_get_a_200_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))
    # assert False, 'This step must be implemented'


@step(u'And The following user details are returned:')
def and_the_following_user_details_are_returned(step):
    assert_equals(step.hashes, [json.load(world.response.data)])
    # assert False, 'This step must be implemented'
