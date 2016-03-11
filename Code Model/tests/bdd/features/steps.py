from lettuce import step, world, before
from nose.tools import assert_equals
from app.views import app, USERS

@before.all
def before_all():
    world.app = app.test_client()

@step(u'Given the nurse is not yet registered in the system.')
def given_the_nurse_is_not_yet_registered_in_the_system(step):
    assert True, 'This step must be implemented'

@step(u'And admin fills up the account form')
def and_admin_fills_up_the_account_form(step):
    assert True, 'This step must be implemented'

@step(u'When admin clicks the save button.')
def when_admin_clicks_the_save_button(step):
    assert True, 'This step must be implemented'

@step(u'Then the system will display a success message that states that a new account of a nurse is saved.')
def then_the_system_will_display_a_success_message_that_states_that_a_new_account_of_a_nurse_is_saved(step):
    assert True, 'This step must be implemented'