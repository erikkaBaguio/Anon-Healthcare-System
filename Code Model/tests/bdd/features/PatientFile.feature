#created by Mary grace
Feature: Patient File

Scenario: Create patient file
    Given the following patient info
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |7| Kristel     |Daligdig|Pabillaran|19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single       | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a '200' response
    And I should get a status OK
    And I should get a message OK
