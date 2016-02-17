# Created by erikka at 2/18/16
Feature: Password Reset

  As an admin/nurse/doctor, I want to reset my password

  Scenario: Password Reset
    Given 	admin/doctor/nurse wants to change the password.
	When admin/doctor/nurse inputs new password and submit.
	Then  admin/doctor/nurse password changed.