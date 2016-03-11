# Created by josiah at 3/12/16
Feature: User Accounts Maintenance
As an admin, I want to add a new account for a new user.


  Scenario: Create a user account in the system
    Given	the user is not yet registered in the system.
	When	admin inputs:
		|fname| |mname|       |lname|        |email|
		|Josiah| |Timonera|  |Regencia|    |jetregencia@gmail.com|
	Then   I should get a ‘200’ response