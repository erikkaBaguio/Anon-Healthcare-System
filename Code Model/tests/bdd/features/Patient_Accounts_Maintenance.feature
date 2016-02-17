# Created by erikka at 2/18/16
Feature: Patient Accounts Maintenance

  As an admin, I want to add a new account for patient.

  Scenario: Adding patient account in the system
    Given the patient is not yet registered in the system.
	And admin fills up the account form
	When admin clicks the save button.
	Then the system will display a success message that states that a new accout of a patient is saved.
