Feature: notification
  As a doctor I want to receive a notification after the nurse
  has added assessment.

  Scenario: Nurse send the assessment to the doctor
            Given the nurse already assess the patient with assessment id 6
            When the nurse request an appointment to the doctor with id 1
            Then I should get a '200' response
            And the following details are returned:
              | doctor_id  | is_read |
              | 1    	   | False   |