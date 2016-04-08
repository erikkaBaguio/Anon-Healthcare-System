#Feature: doctor referral
#  As a doctor I want refer the patient to another physician.
#
#  Scenario: the doctor refers the patient to another for clarity of the situation.
#            Given the doctor with id 1 has already approved the appointment request with id '6'.
#            When the doctor refers the appointment to another doctor with id 2.
#            Then the doctor with id 2 receives the appointment request.
#            And following details are returned:
#              | doctor_id  |assessment_id| is_read |
#              | 2    	   | 6           | False   |