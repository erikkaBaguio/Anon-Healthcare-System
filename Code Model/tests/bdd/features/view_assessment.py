import json
from webtest import TestApp
from lettuce import step, world, before
from nose.tools import assert_equals, assert_raises, raises
from flask import *
from app import app


@step(u'Given   the patient assessment with an id \'([^\']*)\' exists')
def given_the_patient_assessment_with_an_id_group1_exists(step, assessment_id):
    world.assessment = world.app.get('/anoncare.api/assessments/1/')
    world.resp = json.loads(world.assessment.data)
    assert_equals(world.resp['status'], 'OK')

@step(u'When    the doctor press view assessment with an id 1')
def when_the_doctor_press_view_assessment_with_an_id_1(step):
    world.response = world.app.get('/anoncare.api/assessments/1/')

@step("the doctor should get a \'([^\']*)\' response")
def step_impl(step,expected_status_code):
    """
    :type step: lettuce.core.Step
    """
    assert_equals(world.response.status_code, int(expected_status_code))

@step("the following assessment details will be returned")
def step_impl(step):
    """
    :type step: lettuce.core.Step
    """
    resp = json.loads(world.response.data)
    assert_equals(world.resp['entries'], resp['entries'])