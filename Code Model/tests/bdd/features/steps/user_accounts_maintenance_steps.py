from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
import json


@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given the following details of a user:')
def given_the_following_details_of_a_user(step):
    world.user = step.hashes[0]


@step(u'And   the username \'([^\']*)\' does not yet exist')
def and_the_username_group1_does_not_yet_exist(step, username):
    world.browser = TestApp(app)
    world.response = world.app.get('/anoncare.api/userexists/{}/'.format(username))


@step(u'When  admin clicks the register button')
def when_admin_clicks_the_register_button(step):
    world.post_response = world.app.post('/anoncare.api/user/', data=json.dumps(world.user))


@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_have_a_group1_response(step, expected_status_code):
    assert_equals(world.post_response.status_code, int(expected_status_code))


@step(u'And   it should have a field exists containing False')
def and_it_should_have_a_field_exists_containing_false(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['exists'], False)


@step(u'And   it should have a field status containing OK')
def and_it_should_have_a_field_status_containing_ok(step):
    world.post_resp = json.loads(world.post_response.data)
    assert_equals(world.post_resp['status'], 'OK')
