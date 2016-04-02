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
@step(u'Given a patient id \'([^\']*)\'')
def given_a_patient_id_group1(step, id):
    world.patient1 = world.app.get('/anoncare.api/patient/{}/'.format(id))
    world.resp1 = json.loads(world.patient1.data)
    assert_equals(world.resp1['status'], 'OK')

@step(u'Then I get a \'([^\']*)\' response')
def then_i_get_a_group1_response(step, expected_status_code):
    assert_equals(world.patient1.status_code, int(expected_status_code))
    
@step(u'And the following patient file is retrieved:')
def and_the_following_patient_file_is_retrieved(step):
    world.resp2 = json.loads(world.patient1.data)
    assert_equals(world.resp2['entries'], world.resp2['entries'])

#----------------------------------------------------------------------------------------------------

#Rainy Case- GET
@step(u'Given a patient file with id \'([^\']*)\'')
def given_a_patient_file_with_id_group1(step, id):
    world.patient = world.app.get('/anoncare.api/patient/{}/'.format(id))
    world.resp = json.loads(world.patient.data)
    assert_equals(world.resp['status'], 'OK')
    
@step(u'When I retrieve the patient id \'([^\']*)\'')
def when_i_retrieve_the_patient_id_10(step, id):
    world.response = world.app.get('/anoncare.api/patient/{}/'.format(id))

@step(u'And I should get a message No patient file found')
def and_i_should_get_a_message_ok(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['message'], 'No patient file found')

#------------------------------------------------------------------------------------------------------
#Rainy Case- POST
@step(u'Given the following patient file with id 1 already existed:')
def given_the_following_patient_file_with_id_1_already_existed(step):
    world.patient3 = step.hashes[0]

@step(u'When I enter the existing patient file')
def when_i_enter_the_existing_patient_file(step):
    world.patient3_uri = '/anoncare.api/patient/'
    world.patient3_response = world.app.post(world.patient3_uri, data = json.dumps(world.patient3))

@step(u'Then I get a message Patient already EXISTED')
def then_i_get_a_message_patient_already_existed(step):
    world.resp3 = json.loads(world.patient3_response.data)
    assert_equals(world.resp3['message'], 'Patient already EXISTED')

@step(u'Given the following patient file with fname, mname and lname already existed:')
def given_the_following_patient_file_with_fname_mname_and_lname_already_existed(step):
    world.patient4 = step.hashes[0]

@step(u'Given the following patient info without fname:')
def given_the_following_patient_info_without_fname(step):
    world.patient = step.hashes[0]

@step(u'When I click the add button')
def when_I_click_the_add_button(step):
    world.patient_uri = '/anoncare.api/patient/'
    world.patient_response = world.app.post(world.patient_uri, data = json.dumps(world.patient))

@step(u'Then I should get a message Please fill up the required data')
def then_i_should_get_a_message_please_fill_up_the_required_data(step):
    world.resp4 = json.loads(world.patient_response.data)
    assert_equals(world.resp4['message'], 'Please fill up the required data')


@step(u'Then I should get a message OK')
def then_i_should_get_a_message_ok(step):
    world.resp5 = json.loads(world.patient_response.data)
    assert_equals(world.resp5['message'], 'OK')




