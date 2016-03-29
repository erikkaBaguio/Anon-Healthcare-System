# Created by josiah at 3/18/16
Feature: User Accounts Maintenance
  As a system administrator, I want to be able to add, view the details of a specific user

  #Adding a user

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        | fname   | mname     | lname     | email                   | username          | password               |  role_id|
        | Wichelle| Timonera  | Regencia  | jawshaeleazar@gmail.com | wichelle.regencia | josiaheleazareregencia |  1      |

    And the username 'wichelle.regencia' does not yet exist

    When admin clicks the register button

    Then admin should get an exists False

    And admin should get a '200' response

    And admin should get a status OK


  Scenario: Add a new user to the system - username already exists
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id|
        | Josiah  | Timonera  | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      |

    And the username 'josiah.regencia' exists

    When admin clicks the register button

    Then admin should get an exists True

    And admin should get a '200' response

    And admin should get a status error

  ################################################################


  Scenario: Retrieve a user's details
    Given user already exists with data:
          |fname|  |mname|    |lname|    |email|                 |username|
          |Josiah| |Timonera| |Regencia| |jetregencia@gmail.com| |Josiah.Regencia|

    When the System Administrator chooses id '1'
    Then I would get a '200' response
    And  the system administrator can retrieve the user.


  Scenario: User's details does not exist
    Given User with id '22'
    When I retrieve the user's details
    Then I would get a '200' response
    And I should get a message No User Found

