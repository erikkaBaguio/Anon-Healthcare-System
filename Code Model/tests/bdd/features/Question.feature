# Created by gege at 3/12/16
Feature: Diagnostic Questions Records Maintenance
  As an admin,

  Scenario: retrieving a question details.
    Given some category of questions are in the system
    When when I retrieve a diagnostic question 7
    Then I should get a '200' response
    And the following question details are returned:
       | id | question                                | user_id | category_id | is_active |
       | 7  | Hoarseness or a problem with your voice |   1     |      1      |   false    |


