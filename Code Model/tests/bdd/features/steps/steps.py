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

@step(u'When  the nurse clicks the add button')
def when_the_nurse_clicks_the_add_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/anoncare.api/assessments/', data=json.dumps(world.assessment))


""" Feature : Create Final Diagnosis """

""" Scenario: Update assessment """

@step(u'Given the details of the patient assessment with an id 2')
def given_the_details_of_the_patient_assessment_with_an_id_2(step):
    world.assessment_oldInfo = step.hashes[0]

@step(u'And   the new details for the patient assessment with an id 2')
def and_the_new_details_for_the_patient_assessment_with_an_id_2(step):
    world.assessment_updatedInfo = step.hashes[0]

@step(u'When  the doctor clicks the update button')
def when_the_doctor_clicks_the_update_button(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/anoncare.api/assessments/update/2/', data=json.dumps(world.assessment_updatedInfo))


""" Feature: View Assessment """

""" Scenario: View Assessment of Patient """

@step(u'Given the patient assessment with a school id \'([^\']*)\'')
def given_the_patient_assessment_with_an_id_group1(step, school_id):
    world.assessment = world.app.get('/api/anoncare/assessments/{}/'.format(school_id))
    world.response_json = json.loads(world.assessment.data)
    assert_equals(world.response_json['status'], 'OK')

@step(u'When  the doctor press view assessment with an id \'([^\']*)\'')
def when_the_doctor_press_view_assessment_with_an_id_group1(step, assessment_id):
    world.browser = TestApp(app)
    world.response = world.app.get('/api/anoncare/assessments/{}/'.format(assessment_id))

@step(u'When  the doctor press search with school id \'([^\']*)\'')
def when_the_doctor_press_search_with_school_id_group1(step, school_id):
    world.browser = TestApp(app)
    world.response = world.app.get('/api/anoncare/assessments/{}/'.format(school_id))

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


""" Feature: Patient file  """

""" Scenario: Create patient file"""

@step(u'Given the following details of patient')
def given_the_following_details_of_patient(step):
    world.patient = step.hashes[0]

@step(u'When I click the add button')
def when_i_click_the_add_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/anoncare.api/patient/', data = json.dumps(world.patient))


""" Scenario: Create patient file"""

@step(u'Given a patient file with id \'([^\']*)\'')
def given_a_patient_file_with_id_group1(step, id):
    world.patient1 = world.app.get('/anoncare.api/patient/{}/'.format(id))
    world.response_json = json.loads(world.patient1.data)
    assert_equals(world.response_json['status'], 'OK')

@step(u'And the following patient file is retrieved:')
def and_the_following_patient_file_is_retrieved(step):
    world.response_json = json.loads(world.patient1.data)
    assert_equals(world.response_json['entries'], world.response_json['entries'])

@step(u'When I retrieve the patient id \'([^\']*)\'')
def when_i_retrieve_the_patient_id_10(step, id):
    world.response = world.app.get('/anoncare.api/patient/{}/'.format(id))



""" Feature: User Accounts Maintenance  """

""" Scenario: Add a new user to the system - all requirements put """
@step(u'Given the following details of a user:')
def given_the_following_details_of_a_user(step):
    world.user = step.hashes[0]

@step(u'And   the username \'([^\']*)\' does not yet exist')
def and_the_username_group1_does_not_yet_exist(step, username):
    world.user_exists_response = world.app.get('/anoncare.api/userexists/{}/'.format(username))

@step(u'When  admin clicks the register button')
def when_admin_clicks_the_register_button(step):
    world.browser = TestApp(app)
    world.response = world.app.post('/anoncare.api/user/', data=json.dumps(world.user))

@step(u'And   it should have a field exists containing \'([^\']*)\'')
def and_it_should_have_a_field_exists_containing_group1(step, group1):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp['exists'], False)


""" Scenario: Add a new user to the system - username already exists """
@step(u'And   the username \'([^\']*)\' exists')
def and_the_username_group1_exists(step, username):
    world.user_exists_response = world.app.get('/anoncare.api/userexists/{}/'.format(username))

""" Scenario: Retrieve a user's details """
@step(u'Given user with id \'([^\']*)\'')
def given_user_with_id_group1(step, id):
    world.user = world.app.get('/anoncare.api/users/{}/'.format(id))

@step(u'When  the admin enter with an id \'([^\']*)\'')
def when_the_admin_enter_with_an_id_group1(step, id):
    world.browser = TestApp(app)
    world.response = world.app.get('/anoncare.api/users/{}/'.format(id))

@step("the following user details will be returned")
def step_impl(step):
    response_json = json.loads(world.user.data)
    assert_equals(world.response_json['entries'], response_json['entries'])

""" Scenario: User resets password """
@step(u'Given new password of the user:')
def given_new_password_of_the_user(step):
    world.new_password = step.hashes[0]

@step(u'When user clicks the update button')
def when_user_clicks_the_update_button(step):
    world.browser = TestApp(app)
    world.response = world.app.put('/anoncare.api/password_reset/', data=json.dumps(world.new_password))