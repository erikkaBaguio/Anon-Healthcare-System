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

@step(u'Given the doctor with id 1 has already approved the appointment request with id \'([^\']*)\'')
def already_assess(step, appointment_id):
    """
    :type step: lettuce.core.Step
    """
    world.browser = TestApp(app)
    world.appointment_id = appointment_id

@step(u'When the doctor refers the appointment to another doctor with id 2')
def refer_doctor(step):
    world.response = world.browser.post('/anoncare.api/referral/6/2')
    world.response.charset = 'utf8'
    assert_equals(json.loads(world.response.text), {"status": "Updated"})

@step(u'Then the doctor with id 2 receives the appointment request')
def then_i_should_get_a_group1_response(step):
    world.response = world.browser.post('/anoncare.api/notify/6/2')
    world.response.charset = 'utf8'
    world.notification = world.app.get('/anoncare.api/notify/6/2')

@step(u'And the following details are returned:')
def referral_details(step):
	world.notification = world.app.get('/anoncare.api/notify/6/2')
	world.resp = json.loads(world.notification.data)[u'entries']
	world.notification_returned = step.hashes[0]
	assert_equals(world.notification_returned, world.resp[0])

# =====================================================================================