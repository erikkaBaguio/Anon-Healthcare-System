#created by marygrace
Feature:  Diagnostic Questions Records Maintenance
  As an admin, I want to retrieve all the diagnostic questions records for a specific category

  Scenario: Retrieve a diagnostic question from a specific category
    Given some questions are in a system
    When I retrieve all the questions under category 'reflux'
    Then I should get a '200' response
    And the following questions are returned:
       | id | question                                | user_id | category_id | is_active |
       | 1  | Hoarseness or a problem with your voice |   1     |      1      |   true    |
       | 2  | Clearing your throat                    |   1     |      1      |   true    |
       | 3  | Excess throat mucus or postnasal drip   |   1     |      1      |   true    |