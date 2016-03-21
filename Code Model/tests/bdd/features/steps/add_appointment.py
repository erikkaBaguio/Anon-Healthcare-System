# import json

# from lettuce import step, world, before
# from nose.tools import assert_equals

<<<<<<< HEAD
# from app import app
=======
from app import app
>>>>>>> 95f95cff34ceb6f2d5552b843875554c6eccb666
# import app.views import APPOINTMENTS


# @before.all
# def before_all():
#     world.app = app.test_client()

# @step(u'Given the nurse already assess the patient')
# def given_diseases_that_are_already_stored_in_the_system(step):
#     DISEASES.update({'done': 'True', 'id': '1', 'doctor': '1'})

# @step(u'When the nurse request an appointment to the doctor with id \'([^\']*)\'')
# def when_the_admin_retrieve_the_disease_with_an_id_number_group1(step,disease_id):
#     world.response = world.app.get('/anoncare.api/diseases/{}/'.format(disease_id))

# @step(u'Then I should get a \'([^\']*)\' response')
# def then_i_should_get_a_group1_response(step, expected_status_code):
#     assert_equals(world.response.status_code, int(expected_status_code))

# @step(u'And the following details are returned:')
# def and_the_following_disease_details_are_returned(step):
#     assert_equals(step.hashes, [json.loads(world.response.data)])

# # =====================================================================================