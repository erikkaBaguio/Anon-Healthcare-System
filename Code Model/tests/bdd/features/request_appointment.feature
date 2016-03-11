Feature: Request Appointment

  Scenario: The nurse requests for appointment to the doctor.
    Given The examination of the patient is finished.
    When I request an appointment to doctor with id '2'
    Then I should get a '200' response
    And the following assessment details are returned:
       | id | patient_id| doctor_id|
       | 1  | 1         |    2     |