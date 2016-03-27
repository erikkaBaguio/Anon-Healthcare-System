Feature: Appointment Confirmation 
  As a doctor I want to confirm the appointment so that I can make the final diagnosi.

  Scenario: Doctor confirms the appointment whether he/she accepts the patient or refers patient to another doctor.
            Given the doctor with id 2 received the appointment with id 6
            When the doctor with id 2 accept the appointment
            Then The doctor can finalize the diagnosis.
            And The following appointment confirmation details are returned:
              | assessment_id  | doctor_id | description 			   |
              | 6    		   | 1		   | "Final diagnosis is ok"   |