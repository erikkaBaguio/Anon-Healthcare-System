import json
from lettuce import step, world, before
from nose.tools import assert_equals
from flask import *
from app import app


@before.all
def before_all():
    world.app = app.test_client()


###Adding a user
@step(u'Given admin inputs:')
def given_admin_inputs(step):
    world.user = step.hashes[0]


@step(u'When admin clicks the register button')
def when_admin_clicks_the_register_button(step):
    world.response = world.app.post('/anoncare.api/user/', data=json.dumps(world.user))


@step(u'And admin should get a status error')
def and_admin_should_get_a_status_error(step):
    world.respond = world.app.post('/anoncare.api/user/', data=json.dumps(world.user))
    world.resp = json.loads(world.respond.data)
    assert_equals(world.resp['status'], 'error')


@step(u'And the username \'([^\']*)\' exists')
def and_the_username_group1_exists(step, username):
    world.user_exists_respond = world.app.get('/anoncare.api/userexists/{}/'.format(username))


@step(u'Then admin should get an exists True')
def then_admin_should_get_an_exists_true(step):
    world.user_exists_resp = json.loads(world.user_exists_respond.data)
    assert_equals(world.user_exists_resp['exists'], True)


@step(u'And the username \'([^\']*)\' does not yet exist')
def and_the_username_group1_does_not_yet_exist(step, username):
    world.user_exists_response = world.app.get('/anoncare.api/userexists/{}/'.format(username))


@step(u'Then admin should get an exists False')
def then_admin_should_get_an_exists_false(step):
    world.user_exists_res = json.loads(world.user_exists_response.data)
    assert_equals(world.user_exists_res['exists'], False)


@step(u'And admin should get a \'([^\']*)\' response')
def and_admin_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And admin should get a status OK')
def and_admin_should_get_a_status_ok(step):
    world.res = json.loads(world.response.data)
    assert_equals(world.res['status'], 'OK')

####End of Adding a user#######

#========================================================================================================#

###retrieving a user with id __

@step(u'Given user already exists with data:')
def given_user_already_exists_with_data(step):
    world.column = step.hashes[0]


@step(u'When the System Administrator chooses id \'([^\']*)\'')
def when_the_system_administrator_chooses_id_group1(step, id):
    world.get_response = world.app.get('/anoncare.api/users/{}/'.format(id))


@step(u'And  the system administrator can retrieve the user.')
def and_the_system_administrator_can_retrieve_the_user(step):
    world.get_resp = json.loads(world.get_response.data)
    assert_equals(world.get_resp['status'], 'ok')


@step(u'Given User with id \'([^\']*)\'')
def given_user_with_id_group1(step, id):
    world.get_response = world.app.get('/anoncare.api/users/{}/'.format(id))


@step(u'When I retrieve the user\'s details')
def when_i_retrieve_the_user_s_details(step):
    world.get_response = world.app.get('/anoncare.api/users/22/')



@step(u'Then I would get a \'([^\']*)\' response')
def then_i_would_get_a_group1_response(step, expected_status_code):
    assert_equals(world.get_response.status_code, int(expected_status_code))


# @step(u'And I should get a message No User Found')
# def and_i_should_get_a_message_no_user_found(step):
#     world.get_resp = json.loads(world.get_response.data)
#     print "world.resp is ", world.get_resp
#     assert_equals(world.get_resp['message'], 'No User Found')

###End of retrieving a user with id __