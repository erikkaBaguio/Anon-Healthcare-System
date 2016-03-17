# Created by gege at 3/12/16
Feature: Diagnostic Questions Records Maintenance
  As an admin, I want to retrieve a specific category

  
  Scenario: get the category question
    Given some categories are in the system
    When I retrieve the category '1'
    Then I should get a '200' response
    And the following category is returned:
    |id|category_name|done      |
    |1 |category1    |True      |


  
  