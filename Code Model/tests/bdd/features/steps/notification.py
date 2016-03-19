import json

from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import TestApp

from app import app

    # """
    # :type step: lettuce.core.Step
    # """
    # world.browser = TestApp(app)
    # world.response = world.browser.get('/#/dashboard/products/add')
    # world.response.charset = 'utf8'
    # assert_equals(world.response.status_code, 200)
    # assert_equals(json.loads(world.response.text), {"status": "ok"})
    # world.product = world.app.get('/api/v1/products/1/')
    # world.resp = json.loads(world.product.data)
    # assert_equals(world.resp['status'], 'ok')

@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the nurse already assess the patient with assessment id 6')
def already_assess(step):
    """
    :type step: lettuce.core.Step
    """
    world.browser = TestApp(app)

@step(u'When the nurse request an appointment to the doctor with id 1')
def request_appointment(step):
    world.response = world.browser.post('/anoncare.api/notify/6/1')
    world.response.charset = 'utf8'
    assert_equals(json.loads(world.response.text), {"status": "Ok"})

@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, 200)

@step(u'And the following details are returned:')
def and_the_following_disease_details_are_returned(step):
	world.notification = world.app.get('/anoncare.api/notify/6/1')
	world.resp = json.loads(world.notification.data)[u'entries']
	world.notification_returned = step.hashes[0]
	assert_equals(world.notification_returned, world.resp[0])

# =====================================================================================