Feature: Login
   Admin/Doctor/Nurse login to access the system

  Scenario: Admin login
    Given admin is not logged in
    And inputs username and password
    When the admin clicks login button
    Then the admin will be redirected to dashboard

  Scenario: Doctor Login
  	Given doctor is not logged in
  	And inputs the login form
  	When the doctor clicks login button
  	Then the doctor redirected to dashboard

  Scenario: Nurse Login
    Given nurse is not logged in
    And inputs the login form
    When the nurse clicks login button
    Then the nurse redirected to dashboard
