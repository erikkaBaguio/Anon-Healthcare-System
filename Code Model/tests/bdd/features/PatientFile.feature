#created by marygrace
Feature: Patient File

Scenario: Create a personal info
	Given I have the following personal info of the patient
	|height    |weight|date of birth|civil status|name of guardian |home address                 |is_active|
	|4ft 11inch| 84   | July 25 1996| single     | Marissa Cabolbol| Biga Lugait Misamis Oriental|  true   |
	When I POST the personal info to the resource url '/anoncare.api/patient_file/personal_info/'
	Then I should get a '200' response
	AND I should get a status "OK"


	