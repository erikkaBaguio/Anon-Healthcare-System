import json

from lettuce import step, world, before
from nose.tools import assert_equals

from app import app
from app.views import APPOINTMENTS


@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the nurse already assess the patient')
def given_diseases_that_are_already_stored_in_the_system(step):
    DISEASES.update({'done': 'True', 'id': '1', 'doctor': '1'})

@step(u'When the nurse request an appointment to the doctor with id \'([^\']*)\'')
def when_the_admin_retrieve_the_disease_with_an_id_number_group1(step,disease_id):
    world.response = world.app.get('/anoncare.api/diseases/{}/'.format(disease_id))

@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And the following details are returned:')
def and_the_following_disease_details_are_returned(step):
    assert_equals(step.hashes, [json.loads(world.response.data)])

# =====================================================================================

@step(u'Given disease records that are already stored in the system')
def given_disease_records_that_are_already_stored_in_the_system(step):
    DISEASE_RECORDS.update({"id": '1', "disease_id": '1', "symptom_id": '3', "done": 'True'})

@step(u'When the admin retrieve the disease record with an id number \'([^\']*)\'')
def when_the_admin_retrieve_the_disease_record_with_an_id_number_group1(step, id):
    world.response = world.app.get('/anoncare.api/disease_records/{}/'.format(id))

@step(u'Then I should get a \'([^\']*)\' response')
def then_i_should_get_a_group1_response(step, expected_status_code):
    assert_equals(world.response.status_code, int(expected_status_code))

@step(u'And the following disease record details are returned:')
def and_the_following_disease_record_details_are_returned(step):
    assert_equals(step.hashes, [json.loads(world.response.data)])