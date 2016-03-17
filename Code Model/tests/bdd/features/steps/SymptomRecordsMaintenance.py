# import json
#
# from lettuce import step, world, before
# from nose.tools import assert_equals
#
# from app import app
# import app.views
#
#
# @before.all
# def before_all():
#     # world.app = app.test_client()
#
# @step(u'Given symptom number 3 is valid disease id')
# def given_symptom_number_3_is_valid_disease_id(step):
#     SYMPTOMS.update({'done': 'True', 'id': '3', 'name': 'fever'})
#
# @step(u'When the admin retrieve the symptom with and id number \'([^\']*)\'')
# def when_the_admin_retrieve_the_symptom_with_and_id_number_group1(step, id):
#     world.response = world.app.get('/anoncare.api/symptoms/{}/'.format(id))
#
# @step(u'Then I should get a \'([^\']*)\' response')
# def then_i_should_get_a_group1_response(step, expected_status_code):
#     assert_equals(world.response.status_code, int(expected_status_code))
#
# @step(u'And the following symptom details are returned:')
# def and_the_following_symptom_details_are_returned(step):
#     assert_equals(step.hashes, [json.loads(world.response.data)])