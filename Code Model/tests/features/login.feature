Feature: Login
   Admin/Doctor/Nurse login to access the system

  Scenario: Admin login
    Given admin is not logged in
    And inputs username and password
    When the admin clicks login button
    Then the admin will be redirected to dashboard