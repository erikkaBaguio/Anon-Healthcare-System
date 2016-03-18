# Created by josiah at 3/18/16
Feature: Retrieve User
  As a system administrator, I want to be able to view the details of a specific user in s
  Scenario: Retrieve a user's details
    Given user already exists with data:
          |fname|  |mname|    |lname|    |email|                 |username|
          |Josiah| |Timonera| |Regencia| |jetregencia@gmail.com| |Josiah.Regencia|

    When the System Administrator chooses id '1'
    Then I should get a '200' response
    And  the system administrator can retrieve the user.