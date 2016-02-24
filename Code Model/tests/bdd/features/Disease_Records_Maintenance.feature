# Created by mary grace at 2/19/16
Feature: Disease Records Maintenance
    As an admin, I want to add a disease so that the Doctor can diagnose the patient.

Scenario: adding a new disease to the system.
	Given disease is not yet in the system. 
	When I input a new disease 'dengue fever'.
	Then  it should  be stored in the database.
