# Created by mary grace at 2/24/16
Feature: Diagnostic Questions Records Maintenance

    As an admin, I want to add diagnostic questions for a disease in the examination

Scenario: adding diagnostic questions for a certain disease.
	Given specific symptom is already connected to a specific disease.
	When system administrator input diagnostic question "How long have you had the cough?".
	Then diagnostic question is added in the database.
    And I get a response of "Diagnostic Question successfully added".

