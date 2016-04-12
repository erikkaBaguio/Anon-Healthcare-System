# Created by josiah at 3/18/16
Feature: User Accounts Maintenance
  As a system administrator, I want to be able to add, view the details of a specific user

  #Adding a user

  Scenario: Add a new user to the system - all requirements put
    Given the following details of a user:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Sean     | Timonera | Regencia  | jawshaeleazar@gmail.com | sean.regencia     | josiaheleazareregencia | 3      | False       |


    And   the username 'sean.regencia' does not yet exist
    When  admin clicks the register button
    Then  it should have a '200' response
    And   it should get a field 'exists' containing 'False'
    And   it should have a field 'status' containing 'OK'


  Scenario: Add a new user to the system - username already exists
    Given the following details of a user:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    And   the username 'josiah.regencia' exists
    When  admin clicks the register button
    Then  it should have a '200' response
    And   it should get a field 'exists' containing 'True'
    And   it should have a field 'status' containing 'error'


  ################################################################

  Scenario: Retrieve a user's details
    Given user with id '1'
    When  the admin enter with an id '1'
    Then  it should have a '200' response
    And   it should have a field 'status' containing 'OK'
    And   it should have a field 'message' containing 'OK'
    And   the following user details will be returned:
        | fname    | mname    | lname     | email                   | username          |
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   |


  Scenario: Retrieve a user's details that does not exist
    Given user with id '32'
    When  the admin enter with an id '32'
    Then  it should have a '200' response
    And   it should have a field 'status' containing 'OK'
    And   it should have a field 'message' containing 'No User Found'


 ######################################################################

##Password Reset

  Scenario: User resets password
    Given new password of the user:
          |password      |
          |new passwordo!|

    When user clicks the update button
    Then  it should have a '200' response
    And   it should have a field 'status' containing 'Password Changed'