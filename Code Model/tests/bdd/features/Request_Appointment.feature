# Created by remarc balisi at 2/21/16
Feature: Request Appointment

Scenario: The nurse requests for appointment to the doctor.
	Given The examination of the patient is finished. 
	When The nurse sends a request of appointment to the doctor preferred.
	Then The doctor is notified for an appointment.