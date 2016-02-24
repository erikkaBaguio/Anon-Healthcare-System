# Created by remarc balisi at 2/21/16
Feature: Appointment Confirmation

Scenario: Confirms whether the doctor accepts/decline the patient/refers to another doctor.
	Given Nurse has sent the examination and appointment request to the doctor. 
	When The doctor receives appointment, examination and initial diagnosis of the patient.
	Then  The doctor accepts or refer the patient to another doctor.
