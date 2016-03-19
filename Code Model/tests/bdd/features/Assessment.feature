# Created by erikka at 3/17/16
Feature: Assessment
  As a nurse, I want to assess the patient.

  Scenario: Nurse retrieve specific department successfully.
          Given the following department already exists:
                | department_id  | college_name  |  department_name  |
                | 1              | SCS           |  Computer Science |
          When the Nurse choose department id '1'
          Then the nurse should get a '200' response
          And the nurse can retrieve the department.

  Scenario: Nurse retrieves successfully the vital signs of a specific patient.
          Given the following vital signs are already exists:
                | vital_signID  | temperature| pulse_rate|  respiration_rate  |blood_pressure|weight|
                | 1             | 37.2       | 80.0        |  16 breaths/minute |110/70        |45.5  |
          When the nurse retrieve vital signs with an id '1'
          Then the nurse should get a '200' response
          And the nurse can see the vital signs of the patient.

