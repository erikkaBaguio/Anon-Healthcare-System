import json
from lettuce import step, world, before
from nose.tools import assert_equals

from flask import *
from webtest import TestApp
from app import app

@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given patient id \'([^\']*)\' is in the system')
def given_patient_2_is_in_the_system(step,id):
    world.browser = TestApp(app)
    world.patient = world.app.get('/anonacare.api/patient/{}/'.format(id))
    world.resp = json.loads(world.patient.data)
    assert_equals(world.resp['status'], 'ok')

@step("I retrieve patient \'(.*)\'")
def when_I_retrieve_patient_id2(step, id):
    world.response = world.app.get('/anoncare.api/patient/{}/'.format(id))

@step("I should get a \'([^\']*)\' response")
def then_i_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step("the following patient file are returned'")
def and_the_following_patient_file_are_returned(step):
    resp = json.loads(world.response.data)
    assert_equals(world.resp['entries'], resp['entries'])






