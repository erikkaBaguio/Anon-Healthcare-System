# Created by erikka at 3/15/16
Feature: Symptom Records Maintenance
  As an admin,I want to be able to view all symptoms records
  and view specific symptom
  and add a symptom

  Scenario: Admin retrieves symptom records successfully
            Given symptom number 3 is valid disease id
            When the admin retrieve the symptom with and id number '3'
            Then I should get a '200' response
            And the following symptom details are returned:
              | done      | id | name   |
              |  True     | 3  | fever  |