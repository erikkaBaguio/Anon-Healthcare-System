# Created by gege at 3/12/16
Feature: Diagnostic Questions Records Maintenance
  As an admin, I want to retrieve all the diagnostic questions records for a specific category

  Scenario: Retrieve a diagnostic questions
    Given some questions are in a system
    When I retrieve a diagnostic question 1
    Then I should get a '200' response
    And the following questions are returned:
       | id | question                                | user_id | category_id | is_active |
       | 1  | Hoarseness or a problem with your voice |   1     |      1      |   true    |


