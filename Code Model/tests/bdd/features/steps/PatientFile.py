import json
from lettuce import step, world, before
from nose.tools import assert_equals

from flask import *
from webtest import TestApp
from app import app

@before.all
def before_all():
    world.app = app.test_client()

#---------------------------------------------------------------------------------------------------------
@step(u'Given the following patient info')
def given_the_following_patient_info(step):
    world.patient = step.hashes[0]

@step(u'When I click the add button')
def when_i_click_the_add_button(step):
    world.patient_uri = '/anoncare.api/patient/'
    world.patient_response = world.app.post(world.patient_uri, data = json.dumps(world.patient))

@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_200_response(step, expected_status_code):
    assert_equals(world.patient_response.status_code, int(expected_status_code))

@step(u'And I should get a status OK')
def and_i_should_get_a_status_ok(step):
    world.patient_response_json = json.loads(world.patient_response.data)
    assert_equals(world.patient_response_json['status'], 'OK')

@step(u'And I should get a message OK')
def and_i_should_get_a_message_OK(step):
    assert_equals(world.patient_response_json['message'], 'OK')

#-----------------------------------------------------------------------------------------------------











