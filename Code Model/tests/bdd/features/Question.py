#
# # import json
# # from lettuce import step, world, before
# # from nose.tools import assert_equals
# # from app import app
# # from app.views import QUESTIONS
# #
# #
# # @before.all
# # def before_all():
# #     world.app = app.test_client()
# #
# #
# # @step("some questions are in the system ")
# # def given_some_questions_are_in_the_system(step):
# #     """
# #     :type step: lettuce.core.Step
# #     """
# #     QUESTIONS.update({u'question': u'Hoarseness or a problem with your voice', 'user_id': '1', 'category_id': '1', u'is_active': u'false'})
# #
# #
# #
# # @step("I retrieve a diagnostic question \'(.*)\' ")
# # def when_I_retrieve_a_diagnostic_question7(step, id):
# #     """
# #     :type step: lettuce.core.Step
# #     """
# #     world.response = world.app.get('/question/{}'.format(id))
# #
# #
# # @step("I should get a \'(.*)\' response")
# # def then_I_should_get_a_200_response(step, expected_status_code):
# #     """
# #     :param expected_status_code:
# #     :type step: lettuce.core.Step
# #     """
# #     assert_equals(world.response.status_code, int(expected_status_code))
# #
# #
# # @step("the following question details are returned:")
# # def the_following_questions(step):
# #     """
# #     :type step: lettuce.core.Step
# #     """
# #     assert_equals(step.hashes, [json.loads(world.response.data)])
#
# from lettuce import step, world, before
# from nose.tools import assert_equals, assert_raises, raises
# from flask import *
# from webtest import TestApp
# from app import app
# from app.views import CATEGORY
# import json
#
# @before.all
# def before_all():
#     world.app = app.test_client()
#
#
# @step('Given some categories are in the system')
# def given_some_categories_are_in_the_system(step):
#     CATEGORY.update({'id':'1','category_name': 'category1', 'done': 'True'})
#
# @step('When I retrieve the category \'(.*)\'')
# def when_I_retrieve_the_category_question1(step, id):
#     world.response = world.app.get('/api.anoncare/question_category/{}/'.format(id))
#
# @step('Then I should get a \'(.*)\' response')
# def then_I_should_get_a_200_response(step, expected_status_code):
#     assert_equals(world.response.status_code, int(expected_status_code))
#
# @step('the following category is returned:')
# def the_following_category_is_returned(step):
#     assert_equals(step.hashes, [json.loads(world.response.data)])
#
