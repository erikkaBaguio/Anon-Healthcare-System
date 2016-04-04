# Created by erikka at 3/12/16
Feature: Login
  As an admin/nurse/doctor, I want to login to the website so that I can access the system.

#    POST
    Scenario: user logins successfully.
        Given an account that is already stored in the system
              |username       |password |
              |Josiah.Regencia|pass     |

        When  the user enters username 'Josiah.Timonera'
        And   the user enters password 'pass'
        Then  it should have a '201' response
        And   it should have a field 'status' containing 'OK'
        And   it should have a field 'status' containing 'Successfully logged in.'




