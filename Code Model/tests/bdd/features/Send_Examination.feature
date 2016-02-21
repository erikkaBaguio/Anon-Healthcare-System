# Created by remarc balisi at 2/21/16
Feature: Send Examination

Scenario: The nurse sends examination answers to the doctor.
	Given The doctor approved the appointment request. 
	When The nurse clicks the send button.
	Then The doctor receives the examination answers.