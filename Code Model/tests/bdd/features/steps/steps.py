from lettuce import step, world, before
from nose.tools import assert_equals

from app import app
import json

@before.all
def before_all():
    world.app = app.test_client()


# ===========================================================================================================================
""" Common steps for jsonify response """

@step(u'Then  it should get a \'([^\']*)\' response')
def then_it_should_get_a_group1_response(step, expected_status_code):
    assert_equals(str(world.response.status_code), expected_status_code)

@step(u'And   it should get a field status containing OK')
def and_it_should_get_a_field_status_containing_ok(step):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['status'], 'OK')

@step(u'And   it should get a field message containing OK')
def and_it_should_get_a_field_message_containing_ok(step):
    assert_equals(world.resp['message'], 'OK')

@step(u'And   it should have a field message containing "([^"]*)"')
def and_it_should_have_a_field_message_containing_group1(step, expected_message):
    assert_equals(world.resp['message'], expected_message)

""" Rainy Cases """

""" Scenario: A field is empty """
@step(u'And   it should get a field message containing ERROR.')
def and_it_should_get_a_field_message_containing_error(step):
    assert_equals(world.resp['message'], 'ERROR')

""" Scenario: ID Duplication """

@step(u'And   it should get a field message containing ID EXISTS')
def and_it_should_get_a_field_message_containing_ok(step):
    assert_equals(world.resp['message'], 'ID EXISTS')

# ===========================================================================================================================
""" Feature : Assessment """

""" Sunny Case """

""" Scenario: Create assessment successfully """
@step(u'Given the nurse have the following assessment details:')
def given_the_nurse_have_the_following_assessment_details(step):
    world.assessment = step.hashes[0]

@step(u'When  the nurse POST to the product resource url /anoncare.api/assessments/')
def when_the_nurse_post_to_the_product_resource_url_anoncare_api_assessments(step):
    world.response = world.app.post('/anoncare.api/assessments/', data=json.dumps(world.assessment))

""" Rainy Case """

""" Scenario: First name field is null """
@step(u'Given the nurse have the following assessment details with a null first name:')
def given_the_nurse_have_the_following_assessment_details_with_a_null_first_name(step):
    world.assessment = step.hashes[0]

""" Scenario: Middle name field is null """
@step(u'Given the nurse have the following assessment details with a null middle name:')
def given_the_nurse_have_the_following_assessment_details_with_a_null_middle_name(step):
    world.assessment = step.hashes[0]

""" Scenario: Last name field is null """
@step(u'Given the nurse have the following assessment details with a null last name:')
def given_the_nurse_have_the_following_assessment_details_with_a_null_last_name(step):
    world.assessment = step.hashes[0]


""" Scenario: Duplicate assessment id """

@step(u'And   it should get a field message containing ID EXISTS')
def and_it_should_get_a_field_message_containing_ok(step):
    assert_equals(world.resp['message'], 'ID EXISTS')


# ===========================================================================================================================

""" Feature: View Assessment """

"""Sunny Case"""

""" Scenario: View Assessment of Patient """

@step(u'Given the patient assessment with an id \'([^\']*)\' exists')
def given_the_patient_assessment_with_an_id_group1_exists(step, assessment_id):
    world.assessments = world.app.get('/anoncare.api/assessments/{}/'.format(assessment_id))
    world.resp = json.loads(world.assessments.data)
    assert_equals(world.resp['status'], 'OK')

@step(u'When  the doctor press view assessment with an id 2')
def when_the_doctor_press_view_assessment_with_an_id_2(step):
    world.response = world.app.get('/anoncare.api/assessments/2/')

@step(u'And   it should have a field "([^"]*)" containing 1')
def and_it_should_have_a_field_group1_containing_1(step, count):
    assert_equals(world.resp[count], 1)

@step("the following assessment details will be returned")
def step_impl(step):
    resp = json.loads(world.response.data)
    assert_equals(world.resp['entries'], resp['entries'])

"""Rainy Case"""

""" Scenario: Patient's assessment details does not exist """

@step(u'Given the patient assessment with an id \'([^\']*)\' that does not exists')
def given_the_patient_assessment_with_an_id_group1_that_does_not_exists(step, assessment_id):
    world.assessments = world.app.get('/anoncare.api/assessments/{}/'.format(assessment_id))
    world.resp = json.loads(world.assessments.data)

@step(u'When  the doctor press view assessment with an id 3')
def when_the_doctor_press_view_assessment_with_an_id_3(step):
    world.response = world.app.get('/anoncare.api/assessments/3/')

@step(u'And   it should have a field "([^"]*)" containing "([^"]*)"')
def and_it_should_have_a_field_group1_containing_group2(step, status, expected_status):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp[status], expected_status)

@step(u'And   it should have a field "([^"]*)" containing 0')
def and_it_should_have_a_field_group1_containing_0(step, count):
    assert_equals(world.resp[count], '0')

@step(u'And   it should have an empty field "([^"]*)"')
def and_it_should_have_an_empty_field_group1(step, entries):
    assert_equals(world.resp[entries], [])

# ===========================================================================================================================

# ===========================================================================================================================

# ===========================================================================================================================

# ===========================================================================================================================