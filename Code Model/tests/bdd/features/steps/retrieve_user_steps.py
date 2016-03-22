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


@step(u'When the System Administrator chooses id \'([^\']*)\'')
def when_the_system_administrator_chooses_id_group1(step, id):
    world.response = world.app.get('/anoncare.api/users/{}/'.format(id))


@step(u'And  the system administrator can retrieve the user.')
def and_the_system_administrator_can_retrieve_the_user(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['status'], 'ok')


@step(u'Given I retrieve a user with resource url \'([^\']*)\'')
def given_i_retrieve_a_user_with_resource_url_group1(step, url):
    world.user_uri = url


@step(u'When I retrieve the JSON result')
def when_i_retrieve_the_json_result(step):
    world.response = world.app.get('/anoncare.api/users/2/')
    # world.response = world.app.get(world.user_uri)


@step(u'Then I would get a \'([^\']*)\' response')
def then_i_would_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))
    # assert_equals(200, int(expected_status_code))


@step(u'And I should get a status ok')
def and_i_should_get_a_status_not_ok(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['status'], 'ok')



@step(u'And I should get a message No User Found')
def and_i_should_get_a_message_no_user_found(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['message'], 'No User Found')
