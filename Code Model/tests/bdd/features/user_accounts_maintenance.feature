# Created by josiah at 3/18/16
Feature: User Accounts Maintenance
  As a system administrator, I want to be able to add, view the details of a specific user

  #Adding a user

  Scenario: Add a new user to the system - all requirements put
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    And the username 'josiah.eleazar' does not yet exist

    When admin clicks the register button

    Then admin should get an exists False

    And admin should get a '200' response

    And admin should get a status OK


  Scenario: Add a new user to the system - username already exists
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Josiah   | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    And the username 'josiah.regencia' exists

    When admin clicks the register button

    Then admin should get an exists True

    And admin should get a '200' response

    And admin should get a status error


   Scenario: Empty fname
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        |          | Bingo    | Kaboom    | jawshaeleazar@gmail.com | .kaboom           | josiaheleazareregencia | 1      | False       |

    When admin clicks the register button

    Then admin should get an is_empty True

    And admin should get a '200' response

    And admin should get a status All Fields Must Be Filled

  Scenario: Empty mname
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Bam      |          | Kaboom    | jawshaeleazar@gmail.com | bam.kaboom         | josiaheleazareregencia| 1      | False       |

    When admin clicks the register button

    Then admin should get an is_empty True

    And admin should get a '200' response

    And admin should get a status All Fields Must Be Filled

  Scenario: Empty lname
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        | Bam      | Bingo    |           | jawshaeleazar@gmail.com | bam.              | josiaheleazareregencia | 1      | False       |

    When admin clicks the register button

    Then admin should get an is_empty True

    And admin should get a '200' response

    And admin should get a status All Fields Must Be Filled

  Scenario: Empty lname
    Given admin inputs:
        | fname    | mname    | lname     | email | username            | password               | role_id| is_available|
        | Bam      | Bingo    | Kaboom    |       | bam.kaboom         | josiaheleazareregencia  | 1      | False       |

    When admin clicks the register button

    Then admin should get an is_empty True

    And admin should get a '200' response

    And admin should get a status All Fields Must Be Filled

  ################################################################


  Scenario: Retrieve a user's details
    Given user with id '1'
    When the System Administrator chooses id '1'
    Then I would get a '200' response
    And  the system administrator can retrieve the user.


  Scenario: User's details does not exist
    Given User with id '32'
    When I retrieve the user with id '32'
    Then I would get a '200' response
    And I should get a message No User Found
#    And I should get a message No User Found


 ######################################################################
  # Empty Signup Field

  Scenario: Fname field is empty
    Given admin inputs:
        | fname    | mname    | lname     | email                   | username          | password               | role_id| is_available|
        |          | Timonera | Regencia  | jawshaeleazar@gmail.com | josiah.regencia   | josiaheleazareregencia | 1      | False       |

    When When admin clicks the register button


