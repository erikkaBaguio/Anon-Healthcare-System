# Created by erikka at 2/18/16
Feature: Nurse Accounts Maintenance

  As an admin, I want to add a new account for nurse.

  Scenario: Adding nurse account in the system
    Given the nurse is not yet registered in the system.
	And admin fills up the account form
	When admin clicks the save button.
	Then the system will display a success message that states that a new account of a nurse is saved.