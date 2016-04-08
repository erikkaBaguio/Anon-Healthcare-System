<<<<<<< HEAD:Code Model/tests/bdd/features/steps/appointment_confirmation.py
# import json

# from lettuce import step, world, before
# from nose.tools import assert_equals
# from webtest import TestApp

# from app import app

#     # """
#     # :type step: lettuce.core.Step
#     # """
#     # world.browser = TestApp(app)
#     # world.response = world.browser.get('/#/dashboard/products/add')
#     # world.response.charset = 'utf8'
#     # assert_equals(world.response.status_code, 200)
#     # assert_equals(json.loads(world.response.text), {"status": "ok"})
#     # world.product = world.app.get('/api/v1/products/1/')
#     # world.resp = json.loads(world.product.data)
#     # assert_equals(world.resp['status'], 'ok')

# @before.all
# def before_all():
#     world.app = app.test_client()

# @step(u'Given the doctor with id 2 received the appointment with id 6')
# def received_appointment(step):
#     """
#     :type step: lettuce.core.Step
#     """
#     world.browser = TestApp(app)
#     world.response = world.browser.get('/anoncare.api/notify/6/2')
#     world.response.charset = 'utf8'
#     world.load_response = json.loads(world.response.text)[u'status']
#     assert_equals(world.load_response, "Ok")

# @step(u'When the doctor with id 2 accept the appointment')
# def accept_appointment(step):
#     world.response = world.browser.post('/anoncare.api/accept/6/2')
#     world.response.charset = 'utf8'
#     assert_equals(json.loads(world.response.text)[u'status'], 'ok')

# @step(u'Then The doctor can finalize the diagnosis')
# def finalize_diagnosis(step):
#     world.entries = json.loads(world.response.text)[u'entries']
#     assert_equals(world.entries[0][u'is_accepted'], 'True')

# @step(u'And The following appointment confirmation details are returned:')
# def appointment_confirmation_details(step):
# 	world.notification_returned = step.hashes[0]
# 	assert_equals(world.notification_returned, world.entries[0])

# # =====================================================================================
=======
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
    assert_equals(world.load_response, "OK")

@step(u'When the doctor with id 2 accept the appointment')
def accept_appointment(step):
    world.response = world.browser.post('/anoncare.api/accept/6/2')
    world.response.charset = 'utf8'
    assert_equals(json.loads(world.response.text)[u'status'], 'OK')

@step(u'Then The doctor can finalize the diagnosis')
def finalize_diagnosis(step):
    world.entries = json.loads(world.response.text)[u'entries']
    assert_equals(world.entries[0][u'is_accepted'], 'True')

@step(u'And The following appointment confirmation details are returned:')
def appointment_confirmation_details(step):
	world.notification_returned = step.hashes[0]
	assert_equals(world.notification_returned, world.entries[0])

# =====================================================================================
>>>>>>> c25172d35b744a735ca3fc84716ec3ca771e7a81:Code Model/tests/bdd/features/steps/oppointment_confirmation.py
