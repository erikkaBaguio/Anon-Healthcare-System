--[POST] Insert role
--select store_role('admin');
CREATE OR REPLACE FUNCTION store_role(par_rolename TEXT)
  RETURNS TEXT AS
$$
DECLARE
  loc_name TEXT;
  loc_res  TEXT;
BEGIN

  SELECT INTO loc_name rolename
  FROM Role
  WHERE rolename = par_rolename;

  IF loc_name ISNULL
  THEN
    INSERT INTO Role (rolename) VALUES (par_rolename);
    loc_res = 'OK';

  ELSE
    loc_res = 'EXISTED';

  END IF;
  RETURN loc_res;
END;
$$
LANGUAGE 'plpgsql';


select store_role('admin');
select store_role('doctor');
select store_role('nurse');

--------------------------------------------------------------- USER ---------------------------------------------------------------
-- Check if user exists via username
-- return 'OK' if user does not exist
-- Otherwise, 'EXISTED'.
create or replace function check_username(in par_username text) returns text as
  $$ declare local_response text; local_id bigint;
    begin

      select into local_id id from Userinfo where username = par_username;

      if local_id isnull then
        local_response = 'OK';
      else
        local_response = 'EXISTED';

      end if;

      return local_response;

    end;
  $$
  language 'plpgsql';


-- Check if user exists via email
-- return 'OK' if user does not exist
-- Otherwise, 'EXISTED'.
create or replace function check_mail(in par_mail text) returns text as
  $$ declare local_response text; local_id bigint;
    begin

      select into local_id id from Userinfo where email = par_mail;

      if local_id isnull then
        local_response = 'OK';
      else
        local_response = 'EXISTED';

      end if;

      return local_response;

    end;
  $$
  language 'plpgsql';


-- [POST] Insert user
-- select store_user('remarc', 'espinosa', 'balisi', 'apps-user', 'admin', 'remarc.balisi@gmail.com', 2);
create or replace function store_user(in par_fname text, in par_mname text, in par_lname text, in par_username text, in par_password text, in par_email text, in par_role_id int8) returns text as
  $$ declare local_response text;
    begin

      insert into Userinfo(fname, mname, lname, username, password, email, role_id) values (par_fname, par_mname, par_lname, par_username, par_password, par_email, par_role_id);
      local_response = 'OK';
      return local_response;

    end;
  $$
  language 'plpgsql';


-- [GET] Get password of a specific user
--select get_password('apps-user');
create or replace function get_password(par_username text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password
     from Userinfo
     where username = par_username;

     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

------------------------------------------------------------- END USER -------------------------------------------------------------
--[POST] Creating a patient file
--Select * from store_patient(20131288, 'David', 'Lopez', 'Guzman', 20, 'male' , 1, 1, '5 ft 5 inches' , 50 , 'January 30, 1996', 'single', 'Maria Lopez', 'Davao City', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', TRUE);

CREATE OR REPLACE FUNCTION store_patient(par_schoolId           INT, par_fname TEXT, par_mname  TEXT, par_lname TEXT, par_age INT, 
                                      par_sex                   TEXT, par_department_id          INT, par_patient_type_id INT, par_height TEXT, par_weight          FLOAT, 
                                      par_date_of_birth         DATE, par_civil_status          TEXT, par_name_of_guardian TEXT, par_home_address TEXT, par_smoking TEXT,
                                      par_allergies             TEXT, par_alcohol               TEXT, par_medicationstaken TEXT, par_drugs        TEXT, par_cough   TEXT, 
                                      par_dyspnea               TEXT, par_hemoptysis            TEXT, par_tb_exposure TEXT, par_frequency TEXT, par_flank_plan      TEXT, 
                                      par_discharge             TEXT, par_dysuria               TEXT, par_nocturia TEXT, par_dec_urine_amount TEXT,  par_asthma     TEXT, 
                                      par_ptb                   TEXT, par_heart_problem         TEXT, par_hepatitis_a_b TEXT, par_chicken_pox TEXT,  par_mumps      TEXT,
                                      par_typhoid_fever         TEXT, par_chest_pain            TEXT, par_palpitations TEXT, par_pedal_edema TEXT,  par_orthopnea   TEXT,
                                      par_nocturnal_dyspnea     TEXT, par_headache              TEXT, par_seizure TEXT, par_dizziness TEXT, par_loss_of_consciousness TEXT,
                                      par_is_active BOOLEAN) RETURNS TEXT AS
$$
DECLARE
  loc_fname TEXT;
  loc_mname TEXT;
  loc_lname TEXT;
  loc_res   TEXT;
  loc_id   INT;

BEGIN

  SELECT INTO loc_id school_id
  FROM Personal_info
  WHERE school_id = par_schoolId;
  
  SELECT INTO loc_fname fname
  FROM Personal_info
  WHERE fname = par_fname AND mname = par_mname AND lname = par_lname;
  IF par_schoolId ISNULL OR par_fname = '' OR par_mname = '' OR par_lname = '' OR par_age ISNULL OR par_sex = '' OR
     par_department_id ISNULL OR par_patient_type_id ISNULL OR par_height = '' OR par_weight ISNULL OR par_date_of_birth ISNULL OR
     par_civil_status = '' OR  par_name_of_guardian = '' OR par_home_address = '' OR par_smoking = '' OR par_allergies = '' OR
     par_alcohol = '' OR par_medicationstaken = '' OR par_drugs = '' OR par_cough = '' OR par_dyspnea = '' OR par_hemoptysis = '' OR
     par_tb_exposure = '' OR par_frequency = '' OR par_flank_plan = '' OR par_discharge = '' OR par_dysuria = '' OR
     par_nocturia = '' OR par_dec_urine_amount = '' OR par_asthma = '' OR par_ptb = '' OR par_heart_problem = '' OR
     par_hepatitis_a_b = '' OR par_chicken_pox = '' OR par_mumps = '' OR par_typhoid_fever = '' OR par_chest_pain = '' OR
     par_palpitations = '' OR par_pedal_edema = '' OR par_orthopnea = '' OR par_nocturnal_dyspnea = '' OR par_headache = '' OR
     par_seizure = '' OR par_dizziness = '' OR par_loss_of_consciousness = ''
  THEN
    loc_res = 'Please fill up the required data';
  ELSIF
    loc_fname ISNULL AND loc_id ISNULL
    THEN
      INSERT INTO Personal_info (school_id, fname, mname, lname,  age, sex, department_id, patient_type_id, height, weight, date_of_birth, civil_status, name_of_guardian, home_address)
      VALUES (par_schoolId, par_fname, par_mname, par_lname, par_age, par_sex, par_department_id, par_patient_type_id, par_height, par_weight, par_date_of_birth, par_civil_status, par_name_of_guardian, par_home_address);
      INSERT INTO Personal_history (school_id, smoking, allergies, alcohol, medication_taken, drugs)
      VALUES (par_schoolId, par_smoking, par_allergies, par_alcohol, par_medicationstaken, par_drugs);
      INSERT INTO Pulmonary (school_id, cough, dyspnea, hemoptysis, tb_exposure)
      VALUES (par_schoolId, par_cough, par_dyspnea, par_hemoptysis, par_tb_exposure);
      INSERT INTO Gut (school_id, frequency, flank_plan, discharge, dysuria, nocturia, dec_urine_amount)
      VALUES (par_schoolId, par_frequency, par_flank_plan, par_discharge, par_dysuria, par_nocturia, par_dec_urine_amount);
      INSERT INTO Illness (school_id, asthma, ptb, heart_problem, hepatitis_a_b, chicken_pox, mumps, typhoid_fever)
      VALUES (par_schoolId, par_asthma, par_ptb, par_heart_problem, par_hepatitis_a_b, par_chicken_pox, par_mumps, par_typhoid_fever);
      INSERT INTO Cardiac (school_id, chest_pain, palpitations, pedal_edema, orthopnea, nocturnal_dyspnea)
      VALUES (par_schoolId, par_chest_pain, par_palpitations, par_pedal_edema, par_orthopnea, par_nocturnal_dyspnea);
      INSERT INTO Neurologic (school_id, headache, seizure, dizziness, loss_of_consciousness)
      VALUES (par_schoolId, par_headache, par_seizure, par_dizziness, par_loss_of_consciousness);
      INSERT INTO Patient (school_id, personal_info_id, personal_history_id, pulmonary_id, gut_id, illness_id, cardiac_id, neurologic_id, is_active)   
      VALUES (par_schoolId, par_schoolId, par_schoolId, par_schoolId, par_schoolId, par_schoolId, par_schoolId, par_schoolId, par_is_active);

      loc_res = 'OK';
  ELSE
    loc_res = 'Patient already EXISTED';
  END IF;
  RETURN loc_res;
END;
$$
LANGUAGE 'plpgsql';

--[GET] Get the specific patient
--Select show_patient(20131288);


CREATE OR REPLACE FUNCTION show_patient(IN par_schoolId INT, out TEXT, out TEXT, out TEXT, out INT,
                        out TEXT, out INT, out INT, out TEXT, out FLOAT,  
                        out DATE, out TEXT, out TEXT, out TEXT, out TEXT,  
                        out TEXT, out TEXT, out TEXT, out TEXT, out TEXT, 
                      out TEXT, out TEXT, out TEXT, out TEXT, out TEXT,  
                      out TEXT, out TEXT, out TEXT, out TEXT, out TEXT, 
                      out TEXT, out TEXT, out TEXT, out TEXT, out TEXT,
                      out TEXT, out  TEXT, out TEXT, out TEXT, out TEXT, 
                      out TEXT, out TEXT, out TEXT, out TEXT, out, TEXT, out BOOLEAN) RETURNS SETOF RECORD AS
$$

SELECT
    Patient.school_id, 
  Personal_info.fname,
  Personal_info.mname,
  Personal_info.lname,
  Personal_info.age,
  Personal_info.sex,
  Personal_info.department_id,
  Personal_info.patient_type_id,
  Personal_info.height,
  Personal_info.weight,
  Personal_info.date_of_birth,
  Personal_info.civil_status,
  Personal_info.name_of_guardian,
  Personal_info.home_address,
  Personal_history.smoking,
  Personal_history.allergies,
  Personal_history.alcohol,
  Personal_history.medication_taken,
  Personal_history.drugs,
  Pulmonary.cough,
  Pulmonary.dyspnea,
  Pulmonary.hemoptysis,
  Pulmonary.tb_exposure,
  Gut.frequency,
  Gut.flank_plan,
  Gut.discharge,
  Gut.dysuria,
  Gut.nocturia,
  Gut.dec_urine_amount,
  Illness.asthma,
  Illness.ptb,
  Illness.heart_problem,
  Illness.hepatitis_a_b,
  Illness.chicken_pox,
  Illness.mumps,
  Illness.typhoid_fever,
  Cardiac.chest_pain,
  Cardiac.palpitations,
  Cardiac.pedal_edema,
  Cardiac.orthopnea,
  Cardiac.nocturnal_dyspnea,
  Neurologic.headache,
  Neurologic.seizure,
  Neurologic.dizziness,
  Neurologic.loss_of_consciousness,
  Patient.is_active
FROM Patient, Personal_info, Personal_history, Pulmonary, Gut, Illness, Cardiac, Neurologic
Where Patient.school_id = par_schoolId AND Personal_info.school_id = Patient.personal_info_id AND Personal_history.school_id = Patient.personal_history_id AND Pulmonary.school_id = Patient.pulmonary_id AND Gut.school_id = Patient.gut_id AND
      Illness.school_id = Patient.illness_id AND Cardiac.school_id = Patient.cardiac_id AND Neurologic.school_id = Patient.neurologic_id;

$$
LANGUAGE 'sql';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


