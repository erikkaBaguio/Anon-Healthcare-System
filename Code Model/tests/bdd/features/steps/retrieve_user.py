# from lettuce import step, world, before
# from nose.tools import assert_equals
# from app import app
# from app.views import USERS
# import json


# @before.all
# def before_all():
#     world.app = app.test_client()



# @step(u'Given some users are in the system')
# def given_some_users_are_in_the_system(step):
#     USERS.update({'3': {
#                     "email": "neiel.care@gmail.com",
#                     "fname": "Neiel",
#                     "lname": "Paradiang",
#                     "mname": "Care",
#                     "password": "6x(Rf7Ip3%^sn8fC",
#                     "role": 3,
#                     "username": "Neiel.Paradiang"
#                 }})
#     # assert False, 'This step must be implemented'


# USERS = {}


# @step(u'When I retrieve the user with id \'([^\']*)\'')
# def when_i_retrieve_the_user_with_id_group3(step, group3):
#     world.response = world.app.get('/user/{}'.format(group3))
#     # assert False, 'This step must be implemented'


# @step(u'Then I should get a \'([^\']*)\' response')
# def then_i_should_get_a_group3_response(step, group3):
#     assert_equals(world.response.status_code, int(group3))
#     # assert False, 'This step must be implemented'


# @step(u'And the following user details are returned:')
# def and_the_following_user_details_are_returned(step):
#     assert_equals(step.hashes, [json.loads(world.response.data)])
#     # assert False, 'This step must be implemented'
