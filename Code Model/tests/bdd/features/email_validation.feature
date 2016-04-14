# Created by Sha-el Regencia at 12/04/2016
Feature: Email Validation
  As a user, I want to make sure my email is validated

  Scenario: Invalid email
    Given the following details of a user:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Hello    | Timonera | Regencia  | jawshaeleazar           | hello.regencia    | josiaheleazareregencia | 3      | False       |


    And   the email 'jawshaeleazar' is invalid
    When  admin clicks the register button
    Then  it should have a '200' response
    And   it should get a field 'invalid' containing 'True'
    And   it should have a field 'email' containing 'Invalid!'