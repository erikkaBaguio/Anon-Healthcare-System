from lettuce import step, world, before
from nose.tools import assert_equals

from app import app
import json

@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given admin inputs:')
def given_admin_inputs(step):
    world.user = step.hashes[0]


@step(u'When admin clicks the register button')
def when_admin_clicks_the_register_button(step):
    world.response = world.app.post('/anoncare.api/user/', data=json.dumps(world.user))


@step(u'Then admin should get a \'([^\']*)\' response')
def then_admin_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And admin should get a status OK')
def and_admin_should_get_a_status_ok(step):
    world.res = json.loads(world.response.data)
    assert_equals(world.res['status'], 'OK')


@step(u'And admin should get a message OK')
def and_admin_should_get_a_message_ok(step):
    assert_equals(world.res['message'], 'OK')



