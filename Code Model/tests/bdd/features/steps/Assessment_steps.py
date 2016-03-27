import json
from webtest import TestApp
from lettuce import step, world, before
from nose.tools import assert_equals, assert_raises, raises
from flask import *
from app import app



@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the nurse have the following assessment details:')
def given_the_nurse_have_the_following_assessment_details(step):
    world.assessment = step.hashes[0]

@step(u'When  the nurse POST to the product resource url /anoncare.api/assessments/')
def when_the_nurse_post_to_the_product_resource_url_anoncare_api_assessments(step):
    world.assessment_post_uri = '/anoncare.api/assessments/'
    world.assessment_response = world.app.post(world.assessment_post_uri, data=json.dumps(world.assessment))

@step(u'Then  the nurse should get a \'([^\']*)\' response')
def then_the_nurse_should_get_a_group1_response(step, expected_status_code):
    assert_equals(str(world.assessment_response.status_code), expected_status_code)

@step(u'And   the nurse get a field status containing "([^"]*)"')
def and_the_nurse_get_a_field_status_containing_group1(step, expected_status):
    world.assessment_resp = json.loads(world.assessment_response.data)
    assert_equals(world.assessment_resp['status'], expected_status)

@step(u'And   the nurse get a field message containing "([^"]*)"')
def and_the_nurse_get_a_field_message_containing_group1(step, expected_message):
    assert_equals(world.assessment_resp['message'], expected_message)