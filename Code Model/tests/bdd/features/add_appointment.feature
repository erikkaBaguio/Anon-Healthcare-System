Feature: Add appointment
  As a nurse,I want to add an appointment and send it
  to the doctor

  Scenario: Nurse send the assessment to the doctor
            Given the nurse already assess the patient
            When the nurse request an appointment to the doctor with id '1'
            Then I should get a '200' response
            And the following details are returned:
              | done      | id | doctor   |
              | True      | 1  | 1        |