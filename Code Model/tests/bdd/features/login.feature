# Created by erikka at 3/12/16
Feature: Login
  As an admin/nurse/doctor, I want to login to the website so that I can access the system.

#    POST
    Scenario: admin/nurse/doctor logins successfully.
            Given an account that is already stored in the system
                 |username       |password |
                 |Josiah.Timonera|pass     |
            When the admin/nurse/doctor enters username 'Josiah.Timonera'
            And the admin/nurse/doctor enters password 'pass'
            Then the admin/nurse/doctor should get a 201
            And be successfully logged in




