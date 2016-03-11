# Created by mary grace at 2/24/16
Feature: Diagnostic Questions Records Maintenance

Scenario: adding diagnostic questions for a certain disease.
	Given specific symptom is already connected to a specific disease.
	When system administrator input diagnostic question "What do you feel?".
	Then diagnostic question is added in the database.
	And I get a response of "Diagnostic Question successfully added".
