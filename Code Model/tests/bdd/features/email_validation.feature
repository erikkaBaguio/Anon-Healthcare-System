# Created by Sha-el Regencia at 12/04/2016
Feature: Email Validation
  As a user, I want to make sure my email is validated

  Scenario: Invalid email
    Given email address input is 'jetregencia'
    When I click the submit button
    Then it should have a '200' response
    And it should have a field 'invalid' containing 'True'