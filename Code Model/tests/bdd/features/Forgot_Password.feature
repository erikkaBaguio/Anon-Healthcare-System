# Created by josiah at 2/18/16
Feature: Forgot Password
  As an admin/nurse/doctor, I want to be able to reset
  my password through my email address whenever I forget what my password was.

  Scenario: Admin/doctor/nurse forgot his/her password
    Given admin/doctor/nurse has already clicked forgot password button
    And admin/doctor/nurse is already redirected to forgot password page
    When admin/doctor/nurse inputs his/her email address used in the account
    And admin/doctor/nurse clicks send email button
    Then a link to inputting a new password will be sent to the email address of the admin/doctor/nurse
    And admin/doctor/nurse can change his/her password by clicking the link