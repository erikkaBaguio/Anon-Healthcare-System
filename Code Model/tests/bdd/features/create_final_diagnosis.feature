# Created by irika-pc at 4/3/2016
Feature: Create final diagnosis
  As a doctor, I want to finalize the diagnosis of the patient.

  Scenario: Update assessment
      Given the details of the patient assessment with an id 2
            |id |assessment_date            |nameofpatient|age|department|  temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight  | chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis|reccomendation|attendingphysician|
            |2  |2016-03-28 23:46:52.76     |1            |18 |1         |  36.4        | 70          | 19 breaths/minute | 100/80           | 45     | fever         |cough                  |medications     |diagnosis|recommendation|1                 |

      And   the new details for the patient assessment with an id 2
            |id |assessment_date            |nameofpatient|age|department|  temperature | pulse_rate  | respiration_rate  | blood_pressure  | weight  | chiefcomplaint|historyofpresentillness|medicationstaken|diagnosis     |reccomendation|attendingphysician|
            |2  |2016-03-28 23:46:52.76     |1            |18 |1         |  36.4        | 70          | 19 breaths/minute | 100/80           | 45     | fever         |cough                  |medications     |finaldiagnosis|recommendation|1                 |

      When  the doctor PUT to the assessment resource url '/anoncare.api/assessments/update/2/'
      Then  it should get a '200' response
      And   it should get a field status containing 'OK'
      And   it should get a field message containing 'Updated'
