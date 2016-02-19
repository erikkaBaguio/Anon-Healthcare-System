from lettuce import step

@step(u'Given disease is not yet in the system.')
def given_disease_is_not_yet_in_the_system(step):
    assert False, 'This step must be implemented'


@step(u'When I input a new disease \'([^\']*)\'.')
def when_i_input_a_new_disease_group1(step, group1):
    assert False, 'This step must be implemented'


@step(u'Then  it should  be stored in the database.')
def then_it_should_be_stored_in_the_database(step):
    assert False, 'This step must be implemented'
