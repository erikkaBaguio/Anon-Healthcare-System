# Created by josiah at 3/18/16
Feature: Retrieve User
  As a system administrator, I want to be able to view the details of a specific user

  Scenario: Retrieve a user's details
    Given user already exists with data:
          |fname|  |mname|    |lname|    |email|                 |username|
          |Josiah| |Timonera| |Regencia| |jetregencia@gmail.com| |Josiah.Regencia|

    When the System Administrator chooses id '1'
    Then I would get a '200' response
    And  the system administrator can retrieve the user.


  Scenario: User's details does not exist
    Given User with id '2'
    When I retrieve the user's details
    Then I would get a '200' response
    And I should get a status ok
    And I should get a message No User Found

