# Created by erikka at 3/17/16
Feature: Assessment
  As a nurse, I want to assess the patient.

      Scenario: Create assessment successfully.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the product resource url /anoncare.api/assessments/
          Then  it should get a '200' response
          And   it should get a field status containing OK
          And   it should get a field message containing OK

      Scenario: First name field is null.
          Given the nurse have the following assessment details with a null first name:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  |   |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the product resource url /anoncare.api/assessments/
          Then  it should get a '200' response
          And   it should get a field status containing OK
          And   it should get a field message containing ERROR.

      Scenario: Duplicate assessment id.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  |Josiah   |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |


          When  the nurse POST to the product resource url /anoncare.api/assessments/
          Then  it should get a '200' response
          And   it should get a field status containing OK
          And   it should get a field message containing ID EXISTS.

