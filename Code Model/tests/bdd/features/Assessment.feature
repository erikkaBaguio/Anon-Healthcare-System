# Created by erikka at 3/17/16
Feature: Assessment
  As a nurse, I want to assess the patient.

#SUNNY CASE
      Scenario: Create assessment successfully.
          Given the nurse have the following assessment details:
                |id   | school_id| temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |200  | 20130000 | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse clicks the add button
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'OK'



#RAINY CASES
      Scenario: Chief complaint field is null.
          Given the nurse have the following assessment details:
                |id | schoool_id | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |2  | 20130001   | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     |               | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse clicks the add button
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Medications taken field is null.
          Given the nurse have the following assessment details:
                |id | schoool_id | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |2  | 20130001   | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                |                  | diagnosis1  | recommendation1| 1                 |

          When  the nurse clicks the add button
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Diagnosis field is null.
          Given the nurse have the following assessment details:
                |id | schoool_id | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |2  | 20130001   | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      |             | recommendation1| 1                 |

          When  the nurse clicks the add button
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Duplicate assessment id.
          Given the nurse have the following assessment details:
                |id | schoool_id | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |2  | 20130001   | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse clicks the add button
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ID EXISTS'
