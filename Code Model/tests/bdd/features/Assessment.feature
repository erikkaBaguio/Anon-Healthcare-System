# Created by erikka at 3/17/16
Feature: Assessment
  As a nurse, I want to assess the patient.

  Scenario: Nurse retrieve specific department successfully.
          Given the following department already exists:
                | department_id  | college_name  |  department_name  |
                | 1              | SCS         |  Computer Science |
          When the Nurse choose department id '1'
          Then I should get a '200' response
          And the nurse can retrieve the department.
