import json
from lettuce import step, world, before
from nose.tools import assert_equals

from flask import *
from webtest import TestApp
from app import app

@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the following patient file already exists')
def given_the_following_patient_file_already_exists(step):
    world.column = step.hashes[0]

@step(u'When I retrieve patient id \'([^\']*)\'')
def when_I_retrieve_patient_id_2(step, id):
    world.response = world.app.get('/anoncare.api/patient/{}/'.format(id))

@step(u'Then I get a \'([^\']*)\' response')
def then_i_get_a_200_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And I can retrieve the patient file.')
def and_i_can_retrieve_the_patient_file(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['status'], 'ok')

@step(u'Given I retrieve a patient file with resource url \'([^\']*)\'')
def given_i_retrieve_a_patient_file_7(step, url):
	world.patient_uri = url

@step(u'When I retrieve the JSON result')
def when_i_retrieve_the_json_result(step):
    world.response = world.app.get(world.patient_uri)

@step(u'Then I should get a \'([^\']*)\' response')
def and_i_should_get_a_status_group1(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And I should get a status ok')
def and_i_should_get_a_status_group1(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['status'], 'ok')

@step(u'And I should get a message No patient file found')
def and_i_should_get_a_message_group1(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['message'], 'No patient file found')





