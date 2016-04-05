# Created by irika-pc at 4/4/2016
Feature: Create, update, and get assessments of the patient

  #SUNNY CASES
  Scenario: Create assessment successfully.
      Given the nurse have the following assessment details:
            |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
            |1  | Josiah  |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

      When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'OK'

  Scenario: Update assessment
      Given the details of the patient assessment with an id 2
            |id |assessment_date            |nameofpatient|age|department|  temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight  | chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis|reccomendation|attendingphysician|
            |2  |2016-03-28 23:46:52.76     |1            |18 |1         |  36.4        | 70          | 19 breaths/minute | 100/80           | 45     | fever         |cough                  |medications     |diagnosis|recommendation|1                 |

      And   the new details for the patient assessment with an id 2
            |id |assessment_date            |nameofpatient|age|department|  temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight  | chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis     |reccomendation|attendingphysician|
            |2  |2016-03-28 23:46:52.76     |1            |18 |1         |  36.4        | 70          | 19 breaths/minute | 100/80           | 45     | fever         |cough                  |medications     |finaldiagnosis|recommendation|1                 |

      When  the doctor PUT to the assessment resource url '/anoncare.api/assessments/update/2/'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'Updated'

  Scenario: View Assessment of Patient
      Given the patient assessment with an id '2'
      When  the doctor press view assessment with an id '2'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'count' containing '1'
      And 	the following details will be returned
            |id |assessment_date            |nameofpatient| age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
            | 2 |2016-03-28 23:46:52.76     |1            |18   |  1          |36.4         | 70          | 19 breaths/minute | 100/80          | 45     |fever          | cough                  |medications       |diagnosis    |recommendation  |1                  |

    #RAINY CASES
      Scenario: First name field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  |   |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Middle name field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |         |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Last name field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |Timonera |         | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Chief complaint field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |Timonera | Regencia| 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     |               | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Medications taken field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |Timonera | Regencia| 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     |complaint      | history                |                  | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Diagnosis field is null.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  | Josiah  |Timonera | Regencia| 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     |complaint      | history                | medication1      |             | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ERROR'

      Scenario: Duplicate assessment id.
          Given the nurse have the following assessment details:
                |id | fname   | mname   | lname   | age | department  | temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight |chiefcomplaint |historyofpresentillness | medicationstaken | diagnosis   | reccomendation | attendingphysician|
                |1  |Josiah   |Timonera |Regencia | 19  | 1           | 37.1        | 80          | 19 breaths/minute | 90/70           | 48     | complaint     | history                | medication1      | diagnosis1  | recommendation1| 1                 |

          When  the nurse POST to the assessment resource url '/anoncare.api/assessments/'
          Then  it should have a '200' response
          And   it should have a field 'status' containing 'OK'
          And   it should have a field 'message' containing 'ID EXISTS'

Scenario: View Assessment of Patient that doesn't exist
      Given the patient assessment with an id '3'
      When  the doctor press view assessment with an id '3'
      Then  it should have a '200' response
      And   it should have a field 'status' containing 'OK'
      And   it should have a field 'message' containing 'No entries found'
      And   it should have a field 'count' containing '0'
      And   it should have a field 'entries' containing '[]'