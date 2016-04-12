from lettuce import step, world, before
from nose.tools import assert_equals
from webtest import *
from app import app
import json


@before.all
def before_all():
    world.app = app.test_client()


@step(u'Given email address input is \'([^\']*)\'')
def given_email_address_input_is_group1(step, email):
    world.email = world.app.get('/anoncare.api/user/emailverfication/{}/'.format(email))


@step(u'When I click the submit button')
def when_i_click_the_submit_button(step):
    world.browser = TestApp(app)
    world.email_validation_res = world.app.get()


@step(u'Then it should have a \'([^\']*)\' response')
def then_it_should_have_a_group1_response(step, group1):
    assert False, 'This step must be implemented'


@step(u'And it should have a field \'([^\']*)\' containing \'([^\']*)\'')
def and_it_should_have_a_field_group1_containing_group2(step, group1, group2):
    assert False, 'This step must be implemented'

