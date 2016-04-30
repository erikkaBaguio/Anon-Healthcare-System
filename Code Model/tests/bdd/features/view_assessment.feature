# Created by erikka at 3/21/16
Feature: View Assessment
  As a doctor, I want to view the assessment of my patient.

  #  Sunny case
#  Scenario: View Assessment of Patient
#      Given the patient assessment with an school id '20130000'
#      And   the patient assessment with an id '1'
#      When  the doctor press view assessment with an id '1'
#      Then  it should have a '200' response
#      And   it should have a field 'status' containing 'OK'
#      And   it should have a field 'count' containing '1'
#      And 	the following details will be returned
#            |assessment_id|school_id       |assessment_date            |temperature | pulse_rate  | respiration_rate | blood_pressure  | weight |chief_complaint |history_of_present_illness |medications_taken |diagnosis   |reccomendation |attending_physician|
#            |1            |20130000        |2016-04-26 19:42:24.883    |36.4        | 70          | 19               | 100/80          | 45     |fever           | cough                     |medications       |diagnosis   |recommendation |Muhammad Puting    |
#
#  #  Rainy Case
#  Scenario: View Assessment of Patient that doesn't exist
#      Given the patient assessment with an id '3'
#      When  the doctor press view assessment with an id '3'
#      Then  it should have a '200' response
#      And   it should have a field 'status' containing 'OK'
#      And   it should have a field 'message' containing 'No entries found'
#      And   it should have a field 'count' containing '0'
#      And   it should have a field 'entries' containing '[]'

#  Sunny case
  Scenario: View All Assessment of Patient
      Given the patient assessment with a school id '20130000'
      When  the doctor press search with school id '20130000'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And 	the following details will be returned
            |assessment_id|school_id       |assessment_date            |temperature | pulse_rate  | respiration_rate | blood_pressure  | weight |chief_complaint |history_of_present_illness |medications_taken |diagnosis   |reccomendation |attending_physician|
            |6            |20130000        |2016-04-26 19:42:24.883    |36.4        | 70          | 19               | 100/80          | 45     |fever           | cough                     |medications       |diagnosis   |recommendation |Muhammad Puting    |
            |5            |20130000        |2016-04-26 19:42:24.883    |36.4        | 70          | 19               | 100/80          | 45     |fever           | cough                     |medications       |diagnosis   |recommendation |Muhammad Puting    |
            |1            |20130000        |2016-04-26 19:42:24.883    |36.4        | 70          | 19               | 100/80          | 45     |fever           | cough                     |medications       |diagnosis   |recommendation |Muhammad Puting    |
