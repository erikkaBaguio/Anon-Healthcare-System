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
    Given the following patient info where fname isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |6 |         | mname1 |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info where mname isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |9 |    fname2    |      | lname2 |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then I should get a message OK

#Rainy Case
Scenario: Adding patient file
    Given the following patient info where lname isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |11 |    fname3   | mname3     |     |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info where sex isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |13 |    fname4   | mname4     |  lname4   |  20 |      |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where height isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |14 |    fname5   | mname5     |  lname5   |  20 |      |    1         |     1          |    | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where date_of_bith isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |16 |    fname6   | mname6     |  lname6   |  20 |    female  |    1         |     1          | 5 ft  | 45     |          | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info where civil_status isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |17 |    fname8   | mname8     |  lname8   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data

#Rainy Case
Scenario: Adding patient file
    Given the following patient info where name_of_guardian isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |18 |    fname9   | mname9     |  lname9   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |         | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where home_address isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |18 |    fname9   | mname9     |  lname9   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |         | mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where cough isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |19 |    fname10   | mname10     |  lname10   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |    | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where dyspnea isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |20 |    fname11   | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |    | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where hemoptysis isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |21 |    fname12  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |       | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where tb_exposure isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |22 |    fname13  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |        | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where frequency isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |23|    fname14  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     |     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where flank_plan isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |24|    fname15  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data


#Rainy Case
Scenario: Adding patient file
    Given the following patient info where discharge isnull:
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |25|    fname16  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |      | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |    
    When I click the add button
    Then I should get a message Please fill up the required data









