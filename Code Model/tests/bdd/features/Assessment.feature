# Created by erikka at 3/17/16
Feature: Assessment
  As a nurse, I want to assess the patient.

  Scenario: Nurse retrieve specific college successfully.
          Given the following colleges already exists:
                | college_id  | college_name  |
                | 1           | SCS           |
          When the Nurse choose id '1'
          Then I should get a '200' response
          And the nurse can retrieve the college.
