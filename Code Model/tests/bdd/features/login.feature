# Created by erikka at 3/12/16
Feature: Login
  As an admin/nurse/doctor, I want to login to the website so that I can access the system.


    Scenario: admin/nurse/doctor logins successfully.
            Given the admin/nurse/doctor has registered username and password
            When the admin/nurse/doctor enters username 'fname.lname'
            And the admin/nurse/doctor enters password pass'
            Then the admin/nurse/doctor should be successfully logged in


