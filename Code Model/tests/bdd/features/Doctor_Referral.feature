# Created by erikka at 2/18/16
Feature: Doctor Referral

  As a doctor, I want to refers the patient to another doctor for clarity of the situation.

  Scenario: the doctor refers the patient to another for clarity of the situation.
    Given the doctor has already approved the appointment request.
	When the doctor refers the patient to another doctor.
	Then the other doctor receives the appointment request.