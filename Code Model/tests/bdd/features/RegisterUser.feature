# Created by josiah at 3/18/16
Feature: Register User
  As a System Administrator I want to be able to register users to the system.

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        |fname|  |mname|    |lname|    |email|
        |Josiah| |Regencia| |Eleazar| |jawshaeleazar@gmail.com|

    When admin clicks the register button

    Then Then the user is added to the system