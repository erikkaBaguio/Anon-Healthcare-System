from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
import json

@before.all
def before_all():
    world.app = app.test_client()

""" Common steps for jsonify response """

@step(u'Then  it should have a \'([^\']*)\' response')
def then_it_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And   it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_get_a_field_group1_containing_group2(step, field, expected_value):
    world.response_json = json.loads(world.response.data)
    assert_equals(str(world.response_json[field]), expected_value)


""" Feature : Assessment """

""" Scenario: Create assessment successfully """

@step(u'Given the nurse have the following assessment details:')
def given_the_nurse_have_the_following_assessment_details(step):
    world.assessment = step.hashes[0]

@step(u'When  the nurse POST to the assessment resource url \'([^\']*)\'')
def when_the_nurse_post_to_the_assessment_resource_url_group1(step, url):
    world.response = world.app.post(url, data=json.dumps(world.assessment))


""" Feature : Create Final Diagnosis """

""" Scenario: Update assessment """

@step(u'Given the details of the patient assessment with an id 2')
def given_the_details_of_the_patient_assessment_with_an_id_2(step):
    world.assessment_oldInfo = step.hashes[0]

@step(u'And   the new details for the patient assessment with an id 2')
def and_the_new_details_for_the_patient_assessment_with_an_id_2(step):
    world.assessment_updatedInfo = step.hashes[0]

@step(u'When  the doctor PUT to the assessment resource url \'([^\']*)\'')
def when_the_doctor_put_to_the_assessment_resource_url_group1(step, url):
    world.browser = TestApp(app)
    world.response = world.app.put(url, data=json.dumps(world.assessment_updatedInfo))


""" Feature: View Assessment """

""" Scenario: View Assessment of Patient """

@step(u'Given the patient assessment with an id \'([^\']*)\'')
def given_the_patient_assessment_with_an_id_group1(step, assessment_id):
    world.assessment = world.app.get('/anoncare.api/assessments/{}/'.format(assessment_id))
    world.response_json = json.loads(world.assessment.data)
    assert_equals(world.response_json['status'], 'OK')

@step(u'When  the doctor press view assessment with an id \'([^\']*)\'')
def when_the_doctor_press_view_assessment_with_an_id_group1(step, assessment_id):
    world.response = world.app.get('/anoncare.api/assessments/{}/'.format(assessment_id))

@step("the following details will be returned")
def step_impl(step):
    response_json = json.loads(world.assessment.data)
    assert_equals(world.response_json['entries'], response_json['entries'])

""" Feature: Login  """

""" Scenario: User successfully logged in """
@step(u'Given the login requirements')
def given_the_login_requirements(step):
    world.login = step.hashes[0]

@step(u'When  the clicks the login button')
def when_the_clicks_the_login_button(step):

    world.response = world.app.post('/anoncare.api/login',data=json.dumps(world.login))