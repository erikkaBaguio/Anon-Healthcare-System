# Created by erikka at 3/12/16
Feature: Login
  As a user, I want to login to the website so that I can access the system.


  Scenario: valid credentials
    Given the user on the login page
    When the user provides the username "fname.lname"
    And the user provides the password "pass"
    Then the user should be successfully logged in