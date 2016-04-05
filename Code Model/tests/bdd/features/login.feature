# Created by erikka at 3/12/16
Feature: Login
  As an admin/nurse/doctor, I want to login to the website so that I can access the system.

#    Sunny Case
    Scenario: user successfully logged in
        Given the login requirements
              |username       |password                   |
              |muhammad.puting|pass     |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'OK'
        And   it should have a field 'message' containing 'Successfully logged in.'


#   Rainy case
    Scenario: Username is empty
        Given the login requirements
              |username       |password                   |
              |               |josiaheleazareregencia     |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'error'
        And   it should have a field 'message' containing 'Invalid Username or Password'

    Scenario: Username is invalid
        Given the login requirements
              |username       |password               |
              |ambot          |josiaheleazareregencia |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'error'
        And   it should have a field 'message' containing 'Invalid Username or Password'

    Scenario: Password is invalid
        Given the login requirements
              |username       |password      |
              |josiah.regencia|ambot         |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'error'
        And   it should have a field 'message' containing 'Invalid Username or Password'

    Scenario: Password is invalid
        Given the login requirements
              |username       |password      |
              |josiah.regencia|ambot         |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'error'
        And   it should have a field 'message' containing 'Invalid Username or Password'

    Scenario: Username and password is invalid
        Given the login requirements
              |username       |password      |
              |ambot          |ambotnapud    |

        When  the clicks the login button
        Then  it should have a '200' response
        And   it should have a field 'status' containing 'error'
        And   it should have a field 'message' containing 'Invalid Username or Password'


