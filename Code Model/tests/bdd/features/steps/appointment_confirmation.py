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

@step(u'Given the doctor with id 2 received the appointment with id 6')
def received_appointment(step):
    """
    :type step: lettuce.core.Step
    """
    world.browser = TestApp(app)
    world.response = world.browser.get('/anoncare.api/notify/6/2')
    world.response.charset = 'utf8'
    world.load_response = json.loads(world.response.text)[u'status']
    assert_equals(world.load_response, "Ok")

@step(u'When the doctor with id 2 accept the appointment')
def accept_appointment(step):
    world.response = world.browser.post('/anoncare.api/notify/6/1')
    world.response.charset = 'utf8'
    assert_equals(json.loads(world.response.text), {"status": "Ok"})

@step(u'Then The doctor can finalize the diagnosis')
def finalize_diagnosis(step, expected_status_code):
    assert_equals(world.response.status_code, expected_status_code)

@step(u'And The following appointment confirmation details are returned:')
def appointment_confirmation_details(step):
	world.notification = world.app.get('/anoncare.api/notify/6/1')
	world.resp = json.loads(world.notification.data)[u'entries']
	world.notification_returned = step.hashes[0]
	assert_equals(world.notification_returned, world.resp[0])

# =====================================================================================