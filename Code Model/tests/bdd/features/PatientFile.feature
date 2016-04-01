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

Scenario: Get the patient file
    Given a patient id '1'   
    When I retrieve the patient id '1'
    Then I get a '200' response
    And the following patient file is retrieved:
    |id| fname       | mname | lname    |age| sex    | height | weight | date_of_birth  | civil_status |name_of_guardian|home_address |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| 
    |1 | Mary Grace  | Pasco | Cabolbol |19 | female |       1      |   1           | 4ft    |   45   |  august 13 1995|    single    |Juan Manalo     |iligan city  |mild  | none   |  none     |    none    | none     |   none    |    none   |   none |  none   |  none            | none |none|    none       |  none          |  none      |none  |    none      |   none    |    none     |    none    | none     |     none         |   none  |  none  |   none   |   none     
                        
#Rainy Case    
Scenario: Get patient file that doesn't exists
    Given a patient file with id '100'
    When I retrieve the patient id '100'
    Then I get a '200' response
    And I should get a status OK
    And I should get a message No patient file found


#Rainy Case
Scenario: Adding patient file 
    Given the following patient file already existed:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |1|Mary Grace     |Pasco |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I enter the existing patient file 
    Then I get a message Patient already EXISTED


#Rainy Case 
Scenario: Adding patient file
    Given the following patient info without fname:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |6 |         | mname1 |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a message Please fill up the required data




























