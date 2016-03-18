import json
from webtest import TestApp
from lettuce import step, world, before
from nose.tools import assert_equals, assert_raises, raises
from flask import *
from app import app



@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the following department already exists:')
def given_the_following_department_already_exists(step):
    world.column = step.hashes[0]


@step(u'When the Nurse choose department id \'([^\']*)\'')
def when_the_nurse_choose_department_id_group1(step, department_id):
    world.response = world.app.get('/anoncare.api/departments/{}/'.format(department_id))


@step(u'Then the nurse should get a \'([^\']*)\' response')
def then_the_nurse_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And the nurse can retrieve the department.')
def and_the_nurse_can_retrieve_the_department(step):
    world.department_id = world.column['department_id']
    world.college_name = world.column['college_name']
    world.department_name = world.column['department_name']
    response = json.loads(world.response.data)
    assert_equals(response['department_id'], world.department_id)
    assert_equals(response['college_name'], world.college_name)
    assert_equals(response['department_name'], world.department_name)

# ======================================================================================

@step(u'Given the following vital signs are already exists:')
def given_the_following_vital_signs_are_already_exists(step):
    world.vitals = step.hashes[0]
    print world.vitals


@step(u'When the nurse retrieve vital signs with an id \'([^\']*)\'')
def when_the_nurse_retrieve_vital_signs_with_an_id_group1(step, vital_signID):
    world.response = world.app.get('/anoncare.api/vital_signs/{}/'.format(vital_signID))


@step(u'Then the nurse should get a \'([^\']*)\' response')
def then_the_nurse_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And the nurse can see the vital signs of the patient.')
def and_the_nurse_can_see_the_vital_signs_of_the_patient(step):
    world.browser = TestApp(app)
    world.response = world.browser.get('/anoncare.api/vital_signs/1')
    world.vital_signID = world.vitals['vital_signID']
    world.temperature = world.vitals['temperature']
    world.pulse_rate = world.vitals['pulse_rate']
    world.respiration_rate = world.vitals['respiration_rate']
    world.blood_pressure = world.vitals['blood_pressure']
    world.weight = world.vitals['weight']
    response = json.loads(world.response.body)
    assert_equals(response['vital_signID'], world.vital_signID)
    assert_equals(response['pulse_rate'], world.pulse_rate)
    assert_equals(response['respiration_rate'], world.respiration_rate)
    assert_equals(response['blood_pressure'], world.blood_pressure)
    assert_equals(response['weight'], world.weight)
    assert_equals(response['temperature (C)'], world.temperature)
