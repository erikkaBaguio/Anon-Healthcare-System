#created by Mary Grace
Feature: Create patient file

Scenario: Create patient file
    Given the following details of patient
    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
    |10| Kristel     |Daligdig|Pabillaran|19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single       | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
    When I click the add button
    Then  it should have a '200' response
    And   it should have a field 'status' containing 'OK'
    And   it should have a field 'message' containing 'OK'


Scenario: Get the patient file
    Given a patient file with id '1'
    When I retrieve the patient id '1'
    Then  it should have a '200' response
    And the following patient file is retrieved:
    |id| fname       | mname | lname    |age| sex    | height | weight | date_of_birth  | civil_status |name_of_guardian|home_address |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness|
    |1 | Mary Grace  | Pasco | Cabolbol |19 | female |      4ft    |   45   |  august 13 1995|    single    |Juan Manalo     |iligan city  |mild  | none   |  none     |    none    | none     |   none    |    none   |   none |  none   |  none            | none |none|    none       |  none          |  none      |none  |    none      |   none    |    none     |    none    | none     |     none         |   none  |  none  |   none   |   none


##Rainy Case
#Scenario: Get patient file that doesn't exists
#    Given a patient file with id '100'
#    When I retrieve the patient id '100'
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'No patient file found'
#
#
##Rainy Case
#Scenario: ID duplication in adding patient file
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |1|Mary Grace     |Pasco |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Patient already EXISTED'
#
#
##Rainy Case
#Scenario: Adding patient file with fname, mname and lname already existed
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |15|Mary Grace     |Pasco |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Patient already EXISTED'
#
#
#
##Rainy Case
#Scenario: Adding patient file where fname isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |6 |         | mname1 |Cabolbol |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where mname isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |9 |    fname2    |      | lname2 |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where lname isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |11 |    fname3   | mname3     |     |19 |female  |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where sex isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |13 |    fname4   | mname4     |  lname4   |  20 |      |    1         |     1          | 5 ft  | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where height isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |14 |    fname5   | mname5     |  lname5   |  20 |      |    1         |     1          |    | 45     | August 20 1996 | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where date_of_bith isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |16 |    fname6   | mname6     |  lname6   |  20 |    female  |    1         |     1          | 5 ft  | 45     |          | single           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where civil_status isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |17 |    fname8   | mname8     |  lname8   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |           | Corazon Aquino | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where name_of_guardian isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |18 |    fname9   | mname9     |  lname9   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |         | Dalipuga Iligan City| mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where home_address isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |18 |    fname9   | mname9     |  lname9   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |         | mild | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where cough isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |19 |    fname10   | mname10     |  lname10   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |    | none   | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where dyspnea isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |20 |    fname11   | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |    | none      | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where hemoptysis isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |21 |    fname12  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |       | none       | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where tb_exposure isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |22 |    fname13  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |        | none     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where frequency isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |23|    fname14  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     |     | none      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where flank_plan isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |24|    fname15  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |      |  none     | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where discharge isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |25|    fname16  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |      | none   | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where dysuria isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |26|    fname17  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |     | none    | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where nocturia isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |26|    fname17  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |     | none            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
#
##Rainy Case
#Scenario: Adding patient file where dec_urine_amount isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |27|    fname18  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |            | none  |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where asthma isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |28|    fname19  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |       |none|  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where ptb isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |29|    fname20  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1   |      |  none         |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where heart_problem  isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |30|    fname21  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |       |    none      |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where hepatitis_a_b  isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |31|    fname22  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   |        |  none      | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
#
##Rainy Case
#Scenario: Adding patient file where chicken_pox  isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |32|    fname23  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |       | none |    none      |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where typhoid_fever  isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |34|    fname25  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |         |   none    |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
#
##Rainy Case
#Scenario: Adding patient file where chest_pain isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |35|    fname26  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |       |   none      |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where palpitations  isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |36|    fname27  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flank1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |        |    none    |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where pedal_edema isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |37|    fname28  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     |      |  none    |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where orthopnea isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |38|    fname29  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |      |     none         |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where nocturnal_dyspnea isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |39|    fname30  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |           |   none  |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where headache isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |40|    fname31  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |    nocturnaldyspnea1  |       |  none  |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where seizure isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |41|    fname32  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |    nocturnaldyspnea1  |   headache1    |        |   none   |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
#
##Rainy Case
#Scenario: Adding patient file where dizziness isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |42|    fname33  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |    nocturnaldyspnea1  |   headache1    |   seizure1     |      |   none              | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
##Rainy Case
#Scenario: Adding patient file where loss_of_consciousness isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |43|    fname34  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |  mumps1    |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |    nocturnaldyspnea1  |   headache1    |   seizure1     |    dizziness  |           | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'
#
#
##Rainy Case
#Scenario: Adding patient file where mumps isnull
#    Given the following details of patient
#    |id| fname       | mname  | lname    |age| sex    | department_id| patient_type_id|height | weight | date_of_birth  | civil_status |name_of_guardian|home_address         |cough |dyspnea |hemoptysis |tb_exposure |frequency |flank_plan |discharge  |dysuria |nocturia |dec_urine_amount |asthma |ptb |heart_problem  |hepatitis_a_b |chicken_pox |mumps |typhoid_fever |chest_pain |palpitations |pedal_edema |orthopnea |nocturnal_dyspnea |headache |seizure |dizziness |loss_of_consciousness| is_active |
#    |44|    fname35  | mname11     |  lname11   |  20 |    female  |    1         |     1          | 5 ft  | 45     | July 30 1995         |      single     |    Sandara Park    |    Paris, France    |  mild  |  none  |   hemo1    |   tb1     | freq1    |   flak1   |   discharge1   |   dysuria1  |   nocturia1  |      dec_urine_amount1   |   asthma1    |   ptb  |    heartprobs1   | hepa_a1     |   chicken_pox1    |        |   typhoid1      |   chestpain1    |   palpitation1     | pedaledema1     |   orthopnea1   |    nocturnaldyspnea1  |   headache1    |   seizure1     |    dizziness  |      lossofconsciousness1     | true      |
#    When I click the add button
#    Then  it should have a '200' response
#    And   it should have a field 'status' containing 'OK'
#    And   it should have a field 'message' containing 'Please fill up the required data'