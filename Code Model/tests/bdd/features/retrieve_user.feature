## Created by josiah at 3/15/16
#Feature: Retrieve User
#  As an admin, I want to be able to retrieve data from a particular user.
#
#  Scenario: Retrieve a customers details
#  Given some users are in the system
#  When I retrieve the user with id '3'
#  Then I should get a '200' response
#  And the following user details are returned:
#  | email |                | fname | | lname |     | mname | | password |         | role | | username |
#  | neiel.care@gmail.com | | Neiel | | Paradiang | | Care  | | 6x(Rf7Ip3%^sn8fC | | 3    | |Neiel.Paradiang|