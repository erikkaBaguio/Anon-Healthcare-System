# Created by erikka at 3/21/16
Feature: View Assessment
  As a doctor, I want to view the assessment of my patient.

  #  Sunny case
  Scenario: View Assessment of Patient
    Given   the patient assessment with an id '1' exists
    When    the doctor press view assessment with an id 1
    Then	the doctor should get a '200' response
    And     it should have a field "status" containing "OK"
    And     it should have a field "count" containing 1
    And 	the following assessment details will be returned
            |id |assessment_date|nameofpatient|age|department|chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis|reccomendation|attendingphysician|
            |1  |2016-03-21     |1            |18 |1         |fever         |cough                  |medications     |diagnosis|reccomendation|1                 |

  #  Rainy Case
  Scenario: View Assessment of Patient that doesn't exist
    Given   the patient assessment with an id '2' that does not exists
    When     the doctor press view assessment with an id 2
    Then	the doctor should get a '200' response
    And     it should have a field "status" containing "OK"
    And     it should have a field message containing "No entries found"
    And     it should have a field "count" containing 0
    And     it should have an empty field "entries"

##  Sunny case
#  Scenario: View All Assessment of Patient
#    Given   the patient assessment with an id '1' exists
#    When    the doctor press view assessment with an id 1
#    Then	the doctor should get a '200' response
#    And     it should have a field "status" containing "OK"
#    And     it should have \following assessment details will be returned
#            |id |assessment_date|nameofpatient|age|department|chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis|reccomendation|attendingphysician|
#            |1  |2016-03-21     |1            |18 |1         |fever         |cough                  |medications     |diagnosis|reccomendation|1                 |
