#created by Mary grace
Feature: Patient File


Scenario: Get the patient file
    Given the following patient file already exists:
    |id| fname    | mname | lname  |age| sex  | department_id|patient_type_id| personal_info_id| is_active|
    |2 |Mary Grace|Pasco  |Cabolbol|19 |female|        1     |       1       |       2         |   TRUE   |
    When I retrieve patient id '2'
    Then I get a '200' response
    And I can retrieve the patient file.
    
Scenario: Get patient file that doesn't exists
    Given I retrieve a patient file with resource url '/anoncare.api/patient/6/'
    When I retrieve the JSON result
    Then I should get a '200' response
    And I should get a status ok
    And I should get a message No patient file found