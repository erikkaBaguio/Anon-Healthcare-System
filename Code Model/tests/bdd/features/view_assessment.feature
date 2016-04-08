# Created by erikka at 3/21/16
Feature: View Assessment
  As a doctor, I want to view the assessment of my patient.

  #  Sunny case
  Scenario: View Assessment of Patient
      Given the patient assessment with an id '2'
      When  the doctor press view assessment with an id '2'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'count' containing '1'
      And 	the following details will be returned
            |id |assessment_date            |nameofpatient| age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
            | 2 |2016-03-28 23:46:52.76     |1            |18   |  1          |36.4         | 70          | 19 breaths/minute | 100/80          | 45     |fever          | cough                  |medications       |diagnosis    |recommendation  |1                  |

  #  Rainy Case
  Scenario: View Assessment of Patient that doesn't exist
      Given the patient assessment with an id '3'
      When  the doctor press view assessment with an id '3'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'No entries found'
      And   it should have a field 'count' containing '0'
      And   it should have a field 'entries' containing '[]'

#  Sunny case
  Scenario: View All Assessment of Patient
      Given the assessment of all patient
      When  the doctor press view all assessment
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And 	the following details will be returned
            |id |assessment_date            |nameofpatient| age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
            | 2 |2016-03-28 23:46:52.76     |1            |18   |  1          |36.4         | 70          | 19 breaths/minute | 100/80          | 45     |fever          | cough                  |medications       |diagnosis    |recommendation  |1                  |