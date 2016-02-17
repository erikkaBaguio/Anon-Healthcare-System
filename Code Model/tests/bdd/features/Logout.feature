# Created by erikka at 2/18/16
Feature: Logout

  As an admin/nurse/doctor, I want to logout of the website.

  Scenario: Logout
    Given admin/doctor/nurse is on a page with a logout button
	When admin/doctor/nurse clicks the logout button
	Then admin/doctor/nurse will be redirected to homepage