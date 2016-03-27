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
#Scenario1:

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
    assert_equals(world.resp['status'], 'OK')


#---------------------------------------------------------------------------------------------------------
#Scenario2
# Rainy Case

@step(u'Given a patient file with id \'([^\']*)\'')
def given_a_patient_file_with_id_group1(step, id):
	world.patient = world.app.get('/anoncare.api/patient/{}/'.format(id))
	world.resp = json.loads(world.patient.data)
	assert_equals(world.resp['status'], 'OK')
    
@step(u'When I retrieve the patient id \'([^\']*)\'')
def when_i_retrieve_the_patient_id_1(step, id):
    world.response = world.app.get('/anoncare.api/patient/{}/'.format(id))

@step(u'Then I should get a \'([^\']*)\' response')
def and_i_should_get_a_status(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And I should get a status OK')
def and_i_should_get_a_status_ok(step):
	world.resp = json.loads(world.response.data)
	assert_equals(world.resp['status'], 'OK')

@step(u'And I should get a message No patient file found')
def and_i_should_get_a_message_ok(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['message'], 'No patient file found')

#-----------------------------------------------------------------------------------------------
#Scenario3
@step(u'Given the following patient info')
def given_the_following_patient_info(step):
    world.patient = step.hashes[0]

@step("I POST the patient file resource_url '/anoncare.api/patient/'")
def when_i_post_the_patient_file_resource_ur(step):
    world.patient_uri = '/anoncare.api/patient/'
    world.patient_response = world.app.post(world.patient_uri, data = json.dumps(world.patient))
    
@step(u'And I should get a message OK')
def and_i_should_get_a_message_OK(step):
    world.patient_response_json = json.loads(world.patient_response.data)
    assert_equals(world.patient_response_json['message'], 'OK')

#-----------------------------------------------------------------------------------------------------
#Scenario4
@step(u'Given the following personal info')
def given_the_following_personal_info(step):
    world.personal = step.hashes[0]

@step("I POST the patient file resource_url '/anoncare.api/patient/personal/'")
def when_i_post_the_patient_file_resource_url_group1(step):
    world.personal_uri = '/anoncare.api/patient/personal/'
    world.personal_response = world.app.post(world.personal_uri, data = json.dumps(world.personal))

#--------------------------------------------------------------------------------------------------------
#Scenario5
@step(u'Given the following pulmonary info')
def given_the_following_pulmonary_info(step):
    world.pulmonary = step.hashes[0]    

@step("I POST the patient file resource_url '/anoncare.api/patient/pulmonary/'")
def when_i_post_the_patient_file_resource_url_group1(step):
    world.pulmonary_uri = '/anoncare.api/patient/pulmonary/'
    world.pulmonary_response = world.app.post(world.pulmonary_uri, data =json.dumps(world.pulmonary))

#---------------------------------------------------------------------------------------------------------













