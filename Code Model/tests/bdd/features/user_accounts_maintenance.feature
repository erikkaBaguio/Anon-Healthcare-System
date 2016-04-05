# Created by josiah at 3/18/16
Feature: User Accounts Maintenance
  As a system administrator, I want to be able to add, view the details of a specific user

  #Adding a user

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    And the username 'josiah.regencia' does not yet exist

    When admin clicks the register button

    Then admin should get a field 'exists' 'False'

    And admin should get a '200' response

    And admin should have a field 'status' 'OK'


  Scenario: Add a new user to the system - username already exists
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    And the username 'josiah.regencia' exists

    When admin clicks the register button

    Then admin should a field 'exists' 'True'

    And admin should get a '200' response

    And admin should have a field 'status' 'error'



  ################################################################


  Scenario: Retrieve a user's details
    Given user with id '1'
    When the System Administrator chooses id '1'
    Then I would get a '200' response
    And  the system administrator can retrieve the user.


  Scenario: User's details does not exist
    Given User with id '32'
    When I retrieve the user with id '32'
    Then I would get a '200' response
    And I should get a field 'message' 'No User Found'
#    And I should get a message No User Found


 ######################################################################

##Password Reset

  Scenario: User resets password
    Given User updates password:
      |password      |
      |new passwordo!|

    When user clicks the update button

    Then user gets a '200' response

    And user should field 'status' 'Password Changed'
