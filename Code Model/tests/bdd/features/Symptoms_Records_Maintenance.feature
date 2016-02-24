# Created by mary grace at 2/24/16
Feature: Symptoms Records Maintenance

  As an admin, I want to add symptoms of a disease.

  Scenario: adding symptoms for a certain disease.
    Given   disease is already in the system.
	When I input the symptom ‘headache’.
	Then it should be stored in the database.
    And it should be connected to the disease intended.