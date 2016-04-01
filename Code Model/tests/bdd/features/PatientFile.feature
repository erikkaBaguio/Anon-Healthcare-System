#created by Mary grace
Feature: Patient File

Scenario: Create patient file
    Given the following patient info
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |10| Kristel     |Daligdig|Pabillaran|19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single       | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
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
    Given the following patient file with id 1 already existed:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |1|Mary Grace     |Pasco |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I enter the existing patient file 
    Then I get a message Patient already EXISTED

#Rainy Case
Scenario: Adding patient file
    Given the following patient file with fname, mname and lname already existed:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |15|Mary Grace     |Pasco |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      | 
    When I enter the existing patient file 
    Then I get a message Patient already EXISTED

#Rainy Case 
Scenario: Adding patient file
    Given the following patient info without fname:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |6 |         | mname1 |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info without mname:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |9 |    fname2    |      | lname2 |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a message OK

#Rainy Case
Scenario: Adding patient file
    Given the following patient info without lname:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |11 |    fname3   | mname3     |     |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info without sex:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |13 |    fname4   | mname4     |  lname4   |  20 |      |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info without height:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |14 |    fname5   | mname5     |  lname5   |  20 |      |    1         |     1          |    | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info without date_of_bith:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |16 |    fname6   | mname6     |  lname6   |  20 |    female  |    1         |     1          | 5 ft  | 45     |          | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info without civil_status:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |17 |    fname8   | mname8     |  lname8   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

















