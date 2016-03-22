#created by Mary grace
Feature: Patient File


Scenario: Get the patient file
    Given the following patient file already exists:
    |id| fname    | mname | lname  |age| sex  | department_id|patient_type_id| personal_info_id| is_active|
    |2 |Mary Grace|Pasco  |Cabolbol|19 |female|        1     |       1       |       2         |   TRUE   |
    When I retrieve patient id '2'
    Then I get a '200' response
    And I can retrieve the patient file.
 
#Rainy Case    
Scenario: Get patient file that doesn't exists
    Given a patient file with id '1'
    When I retrieve the patient id '1'
    Then I get a '200' response
    And I should get a status OK
    And I should get a message No patient file found


Scenario: Create patient file
    Given the following patient info
    |fname  |mname   |lname     |age|sex   |department_id|patient_type_id|personal_info_id|is_active|
    |Kristel|Daligdig|Pabillaran|19 |female|    1       | 1             |  2             | True    | 
    When I POST the patient file resource_url '/anoncare.api/patient/'
    Then I should get a '200' response
    And I should get a status OK
    And I should get a message OK

