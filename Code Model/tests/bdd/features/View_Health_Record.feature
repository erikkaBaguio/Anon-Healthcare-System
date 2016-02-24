# Created by remarc balisi at 2/21/16
Feature: View health record

Scenario: Doctor view the health record of the patient.
	Given The doctor approves the appointment request. 
	When The doctor clicks the view button.
	Then The doctor can view the patient’s health record.
