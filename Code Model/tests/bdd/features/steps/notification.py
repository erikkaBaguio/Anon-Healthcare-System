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
    world.assessments = world.browser.get('/anoncare.api/assessments/6/')
    world.assessments.charset = 'utf8'
    assert_equals(json.loads(world.assessments.text)[u'status'], "OK")

@step(u'When the nurse request an appointment to the doctor with id 1')
def request_appointment(step):
    world.response = world.browser.post('/anoncare.api/notify/6/1')
    world.response.charset = 'utf8'
    assert_equals(json.loads(world.response.text), {"status": "Ok"})

@step(u'Then I should get \'([^\']*)\' response')
def then_i_should_get_a_group2_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And the following details are returned:')
def notification_details(step):
	world.notification = world.app.get('/anoncare.api/notify/6/1')
	world.resp = json.loads(world.notification.data)[u'entries']
	world.notification_returned = step.hashes[0]
	assert_equals(world.notification_returned, world.resp[0])

@step(u'Given the doctor with id 3 click the notification button')
def doctor_notification(step):
    world.notification = world.app.get('/anoncare.api/notify/3')
    world.notification.charset = 'utf8'

@step(u'When there is no available notification for doctor with id 3')
def no_available_notification(step):
    assert_equals(json.loads(world.notification.data)[u'status'], "error")

@step(u'Then return a \'([^\']*)\' response')
def then_return_a(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And the following message will pop out No available notifications')
def notification_message(step):

    assert_equals(json.loads(world.notification.data)[u'message'], "No available notifications")

# =====================================================================================