# Created by josiah at 3/15/16
Feature: Retrieve User
  As an admin, I want to be able to retrieve data from a particular user.

  Scenario: Retrieve User Details
    Given Some users are in the system

    When I retrieve all users


    Then I should get a ‘200’ response

    And The following user details are returned:
              |fname|  |mname|      |lname|        |email|
              |Josiah| |Timonera|  |Regencia|    |jetregencia@gmail.com|