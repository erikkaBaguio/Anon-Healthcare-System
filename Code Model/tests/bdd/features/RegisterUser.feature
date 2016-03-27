# Created by josiah at 3/18/16
Feature: Register User
  As a System Administrator I want to be able to register users to the system.

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        | fname   | mname     | lname     | email                   | username          | password               |
        | Josiah  | Timonera  | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia |

    And the username 'josiah.regencia' does not yet exist

    When admin clicks the register button

    Then admin should get an exists False

    And admin should get a '200' response

    And admin should get a status OK


  Scenario: Add a new user to the system - username already exists
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               |
        | Josiah  | Timonera  | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia |

    And the username 'josiah.regencia' exists

    When admin clicks the register button

    Then admin should get an exists True

    And admin should get a '200' response

    And admin should get a status error