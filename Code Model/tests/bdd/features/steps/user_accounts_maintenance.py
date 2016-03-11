from behave import *

use_step_matcher("re")


@then("I should get a ‘200’ response")
def step_impl(context):
    """
    :type context: behave.runner.Context
    """
    pass