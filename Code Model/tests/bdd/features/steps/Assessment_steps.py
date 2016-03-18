import json

from lettuce import step, world, before
from nose.tools import assert_equals, assert_raises, raises
from flask import *
from app import app



@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the following department already exists:')
def given_the_following_department_already_exists(step):
    world.column = step.hashes[0]


@step(u'When the Nurse choose department id \'([^\']*)\'')
def when_the_nurse_choose_department_id_group1(step, department_id):
    world.response = world.app.get('/anoncare.api/departments/{}/'.format(department_id))


@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))


@step(u'And the nurse can retrieve the department.')
def and_the_nurse_can_retrieve_the_department(step):
    world.department_id = world.column['department_id']
    world.college_name = world.column['college_name']
    world.department_name = world.column['department_name']
    res = json.loads(world.response.data)
    assert_equals(res['department_name'], world.department_name)