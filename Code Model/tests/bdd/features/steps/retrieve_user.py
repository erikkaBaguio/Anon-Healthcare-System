from lettuce import step, world, before
from nose.tools import assert_equals
from app import app
from app.views import USERS

@before.all
def before_all():
    world.app


@step(u'Given Some users are in the system')
def given_some_users_are_in_the_system(step):
    USERS.update({'id': '2', 'fname': 'Josiah', 'mname': 'Timonera', 'lname': 'Regencia',
                  'username': 'Josiah.Regencia', 'password': '#AQ2gDLkZz~xv9x!'})
    # assert False, 'This step must be implemented'


@step(u'When I retrieve user with id ‘3’')
def when_i_retrieve_user_with_id_3(step):
    assert False, 'This step must be implemented'


@step(u'Then I should get a ‘200’ response')
def then_i_should_get_a_200_response(step):
    assert False, 'This step must be implemented'


@step(u'And The following user details are returned:')
def and_the_following_user_details_are_returned(step):
    assert False, 'This step must be implemented'
