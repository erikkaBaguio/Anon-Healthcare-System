# Created by josiah at 3/18/16
Feature: Register User
  As a System Administrator I want to be able to register users to the system.

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        |fname|  |mname|    |lname|    |email|
        |Josiah| |Timonera| |Regencia| |jetregencia@gmail.com|
    When the admin clicks the 'submit' button
    Then I should get a '200' response
    And  I will see a message 'ok'


  Scenario: Add a new user to the system - no input 'fname'
    Given admin inputs:
        |fname| |mname|    |lname|    |email|
        |     | |Timonera| |Regencia| |jetregencia@gmail.com|
    When the admin clicks the 'submit' button
    Then I should get a '400' response
    And I will see a message 'fname is a required field'


  Scenario: Add a new user to the system - no input 'mname'
    Given admin inputs:
        |fname|  |mname|    |lname|    |email|
        |Josiah| |      |   |Regencia| |jetregencia@gmail.com|
    When the admin clicks the 'submit' button
    Then I should get a '400' response
    And I will see a message 'mname is a required field'


  Scenario: Add a new user to the system - no input 'lname'
    Given admin inputs:
        |fname| |mname|    |lname|    |email|
        |     | |Timonera| |Regencia| |jetregencia@gmail.com|
    When the admin clicks the 'submit' button
    Then I should get a '400' response
    And I will see a message 'fname is a required field


  Scenario: Add a new user to the system - no input 'fname'
    Given admin inputs:
        |fname|  |mname|    |lname|   |email|
        |Josiah| |Timonera| |     |   |jetregencia@gmail.com|
    When the admin clicks the 'submit' button
    Then I should get a '400' response
    And I will see a message 'lname is a required field'



    Scenario: Add a new user to the system - no input 'email'
    Given admin inputs:
        |fname|  |mname|    |lname|    |email|
        |Josiah| |Timonera| |Regencia| |     |
    When the admin clicks the 'submit' button
    Then I should get a '400' response
    And I will see a message 'email is a required field'