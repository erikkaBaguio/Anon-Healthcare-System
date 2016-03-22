import json
from webtest import TestApp
from lettuce import step, world, before
from nose.tools import assert_equals, assert_raises, raises
from flask import *
from app import app

"""Sunny Case"""
@step(u'Given   the patient assessment with an id \'([^\']*)\' exists')
def given_the_patient_assessment_with_an_id_group1_exists(step, assessment_id):
    world.assessments = world.app.get('/anoncare.api/assessments/{}/'.format(assessment_id))
    world.resp = json.loads(world.assessments.data)
    assert_equals(world.resp['status'], 'OK')

@step(u'When    the doctor press view assessment with an id 1')
def when_the_doctor_press_view_assessment_with_an_id_1(step):
    world.response = world.app.get('/anoncare.api/assessments/1/')

@step("the doctor should get a \'([^\']*)\' response")
def step_impl(step,expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step("the following assessment details will be returned")
def step_impl(step):
    resp = json.loads(world.response.data)
    assert_equals(world.resp['entries'], resp['entries'])


"""Rainy Case"""
@step(u'Given   the doctor access the url \'([^\']*)\'')
def given_the_doctor_access_the_url_group1(step, url):
    world.assessment_uri = url

@step(u'When    the doctor retrieves the JSON results')
def when_the_doctor_retrieves_the_json_results(step):
    world.response = world.app.get(world.assessment_uri)

@step(u'And     it should have a field "([^"]*)" containing "([^"]*)"')
def and_it_should_have_a_field_group1_containing_group2(step, status, expected_status):
    world.resp = json.loads(world.response.data)
    assert_equals(world.resp[status], expected_status)

@step(u'And     it should have a field message containing "([^"]*)"')
def and_it_should_have_a_field_message_containing_group1(step, expected_message):
    assert_equals(world.resp['message'], expected_message)

@step(u'And     it should have a field "([^"]*)" containing 0')
def and_it_should_have_a_field_group1_containing_0(step, count):
    assert_equals(world.resp[count], '0')

@step(u'And     it should have an empty field "([^"]*)"')
def and_it_should_have_an_empty_field_group1(step, entries):
    assert_equals(world.resp[entries], [])

