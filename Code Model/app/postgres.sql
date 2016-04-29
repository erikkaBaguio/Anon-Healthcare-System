CREATE TABLE Role (
  id       SERIAL8 PRIMARY KEY,
  rolename TEXT
);


CREATE TABLE Userinfo (
  id           SERIAL8 PRIMARY KEY,
  fname        TEXT        NOT NULL,
  mname        TEXT        NOT NULL,
  lname        TEXT        NOT NULL,
  email        TEXT        NOT NULL,
  username     TEXT UNIQUE NOT NULL,
  password     TEXT        NOT NULL,
  role_id      INT REFERENCES Role (id),
  is_available BOOLEAN
);

CREATE TABLE College (
  id           SERIAL8 PRIMARY KEY,
  college_name TEXT NOT NULL,
  is_active    BOOLEAN DEFAULT TRUE
);

CREATE TABLE Department (
  id              SERIAL8 PRIMARY KEY,
  department_name TEXT NOT NULL,
  college_id      INT REFERENCES College (id),
  is_active       BOOLEAN DEFAULT TRUE
);

CREATE TABLE Vital_signs (
  id               SERIAL8 PRIMARY KEY,
  temperature      FLOAT,
  pulse_rate       FLOAT,
  respiration_rate INT,
  blood_pressure   TEXT,
  weight           FLOAT
);

CREATE TABLE Patient_type (
  school_id   SERIAL8 PRIMARY KEY,
  type TEXT
);


CREATE TABLE Personal_info (
  school_id        SERIAL8 PRIMARY KEY,
  fname            TEXT,
  mname            TEXT,
  lname            TEXT,
  age              INT,
  sex              TEXT,
  department_id    INT REFERENCES Department (id),
  patient_type_id  INT REFERENCES Patient_type (school_id),
  height           TEXT,
  weight           FLOAT,
  date_of_birth    DATE,
  civil_status     TEXT,  
  name_of_guardian TEXT,
  home_address     TEXT
);

CREATE TABLE Personal_history (
  school_id        SERIAL8 PRIMARY KEY,
  smoking          TEXT,
  allergies        TEXT,
  alcohol          TEXT,
  medication_taken TEXT,
  drugs            TEXT
);

CREATE TABLE Pulmonary (
  school_id    SERIAL8 PRIMARY KEY,
  cough       TEXT,
  dyspnea     TEXT,
  hemoptysis  TEXT,
  tb_exposure TEXT
);

CREATE TABLE Gut (
  school_id               SERIAL8 PRIMARY KEY,
  frequency        TEXT,
  flank_plan       TEXT,
  discharge        TEXT,
  dysuria          TEXT,
  nocturia         TEXT,
  dec_urine_amount TEXT
);

CREATE TABLE Illness (
  school_id            SERIAL8 PRIMARY KEY,
  asthma        TEXT,
  ptb           TEXT,
  heart_problem TEXT,
  hepatitis_a_b TEXT,
  chicken_pox   TEXT,
  mumps         TEXT,
  typhoid_fever TEXT
);

CREATE TABLE Cardiac (
  school_id                SERIAL8 PRIMARY KEY,
  chest_pain        TEXT,
  palpitations      TEXT,
  pedal_edema       TEXT,
  orthopnea         TEXT,
  nocturnal_dyspnea TEXT
);

CREATE TABLE Neurologic (
  school_id                    SERIAL8 UNIQUE PRIMARY KEY,
  headache              TEXT,
  seizure               TEXT,
  dizziness             TEXT,
  loss_of_consciousness TEXT
);

CREATE TABLE Patient (
  school_id        SERIAL8 PRIMARY KEY,
  personal_info_id INT REFERENCES Personal_info (school_id),
  personal_history_id INT REFERENCES Personal_history(school_id),
  pulmonary_id     INT REFERENCES Pulmonary (school_id),
  gut_id           INT REFERENCES Gut (school_id),
  illness_id       INT REFERENCES Illness (school_id),
  cardiac_id       INT REFERENCES Cardiac (school_id),
  neurologic_id    INT REFERENCES Neurologic (school_id),
  is_active        BOOLEAN DEFAULT TRUE
);


CREATE TABLE Assessment (
  id                      SERIAL8 PRIMARY KEY,
  assessment_date         TIMESTAMP DEFAULT 'now',
  nameofpatient           INT REFERENCES Patient (id),
  age                     INT,
  department              INT REFERENCES Department (id),
  vital_signs             INT REFERENCES Vital_signs (id),
  chiefcomplaint          TEXT,
  historyofpresentillnes s TEXT,
  medicationstaken        TEXT,
  diagnosis               TEXT,
  recommendation          TEXT,
  attendingphysician      INT REFERENCES Userinfo (id),
  is_done                 BOOLEAN  DEFAULT FALSE
);

INSERT INTO Sex VALUES(1, 'Male');
INSERT INTO Sex VALUES(2, 'Female');

INSERT INTO College VALUES (1, 'SCS');
INSERT INTO College VALUES (2, 'COE');
INSERT INTO College VALUES (3, 'CED');
INSERT INTO College VALUES (4, 'CASS');
INSERT INTO College VALUES (5, 'SET');
INSERT INTO College VALUES (6, 'CBAA');
INSERT INTO College VALUES (7, 'CON');
INSERT INTO College VALUES (8, 'CSM');

INSERT INTO Patient_type VALUES (1, 'Student');
INSERT INTO Patient_type VALUES (2, 'Faculty');
INSERT INTO Patient_type VALUES (3, 'Staff');
INSERT INTO Patient_type VALUES (4, 'Outpatient Department');

INSERT INTO Department VALUES (1, 'Computer Science', 1);

CREATE TABLE Final_diagnosis (
  id            SERIAL8 PRIMARY KEY,
  assessment_id INT REFERENCES Assessment (id),
  doctor_id     INT REFERENCES Userinfo (id),
  description   TEXT
);

CREATE TABLE Notification (
  id            SERIAL8 PRIMARY KEY,
  assessment_id INT REFERENCES Assessment (id),
  doctor_id     INT REFERENCES Userinfo (id),
  is_read       BOOLEAN DEFAULT FALSE
);

------------------------------------
-----STORED PROCEDURE FUNCTIONS-----
------------------------------------

---------------------------------------------- User Accounts Maintenance ----------------------------------------------

--[POST] Check authentication of a user
--select checkauth('fname.lname', 'pass');
--select checkauth('josiah.regencia', 'josiaheleazareregencia');

CREATE OR REPLACE FUNCTION checkauth(IN par_username TEXT, IN par_password TEXT)
  RETURNS TEXT AS
$$
DECLARE
  loc_id       BIGINT;
  loc_username TEXT;
  loc_password TEXT;
  loc_response TEXT;
BEGIN

  SELECT INTO loc_username username
  FROM Userinfo
  WHERE username = par_username AND password = par_password;

  SELECT INTO loc_password password
  FROM Userinfo
  WHERE username = par_username AND password = par_password;

  IF loc_username ISNULL OR loc_password ISNULL OR loc_username = '' OR loc_password = ''
  THEN
    loc_response = 'Invalid Username or Password';
  ELSE
    loc_response = 'Successfully logged in.';
  END IF;
  RETURN loc_response;

END;
$$
LANGUAGE 'plpgsql';

--select getpassword('josiah.regencia');
CREATE OR REPLACE FUNCTION getpassword(par_username TEXT)
  RETURNS TEXT AS
$$
DECLARE
  loc_password TEXT;
BEGIN
  SELECT INTO loc_password password
  FROM Userinfo
  WHERE username = par_username;

  IF loc_password ISNULL
  THEN
    loc_password = 'null';
  END IF;
  RETURN loc_password;
END;
$$
LANGUAGE 'plpgsql';

 select newrole('doctor');
 select newrole('nurse');
 select newrole('system administrator');
CREATE OR REPLACE FUNCTION newrole(par_rolename TEXT)
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

--[POST] Create user info
--select newuserinfo('Josiah', 'Timonera', 'Regencia', 'jetregencia@gmail.com', 'josiah.regencia', 'k6bkW9nUoO8^&C+~', true);
CREATE OR REPLACE FUNCTION newuserinfo(par_fname    TEXT, par_mname TEXT, par_lname TEXT,
                                       par_email    TEXT, par_username TEXT,
                                       par_password TEXT, par_role INT, par_available BOOLEAN)
  RETURNS TEXT AS
$$

DECLARE
  loc_res TEXT;

BEGIN

  --        username := par_fname || '.' || par_lname;
  --        random_password := generate_password();

  INSERT INTO Userinfo (fname, mname, lname, email, username, password, role_id, is_available)
  VALUES (par_fname, par_mname, par_lname, par_email, par_username, par_password, par_role, par_available);


  loc_res = 'OK';
  RETURN loc_res;
END;
$$
LANGUAGE 'plpgsql';

<<<<<<< HEAD
--Generates password of a user
CREATE OR REPLACE FUNCTION generate_password()
  RETURNS TEXT AS
$$
DECLARE
  characters      TEXT;
  random_password TEXT;
  len             INT4;
  placevalue      INT4;

BEGIN
  characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()+=';
  len := length(characters);
  random_password := '';


  WHILE (length(random_password) < 16) LOOP

    placevalue := int4(random() * len);
    random_password := random_password || substr(characters, placevalue + 1, 1);

  END LOOP;

  RETURN random_password;
END;
$$
LANGUAGE 'plpgsql';
=======
>>>>>>> 4ba69d92f42558d649ffdb6cc3c8574978059833

--[GET] Retrieve information of users
--select * from getUserinfo();
CREATE OR REPLACE FUNCTION getuserinfo(OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT)
  RETURNS SETOF RECORD AS
$$
SELECT
  fname,
  mname,
  lname,
  email,
  username
FROM Userinfo;
$$
LANGUAGE 'sql';

--[GET] Retrieve information of a specific user
--select getuserinfoid(1);
CREATE OR REPLACE FUNCTION getuserinfoid(IN par_id INT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT,
                                         OUT       TEXT)
  RETURNS SETOF RECORD AS
$$
SELECT
  fname,
  mname,
  lname,
  email,
  username
FROM Userinfo
WHERE par_id = id;
$$
LANGUAGE 'sql';

--[PUT] Update password of a user
--select updatepassword(1,'pass1');
CREATE OR REPLACE FUNCTION updatepassword(IN par_id INT, IN par_new_password TEXT)
  RETURNS TEXT AS
$$
DECLARE
  response TEXT;

BEGIN
  UPDATE Userinfo
  SET password = par_new_password
  WHERE id = par_id;
  response := 'OK';

  RETURN response;
END;
$$
LANGUAGE 'plpgsql';


create or replace function getuserroleid(in par_username text, in par_pass text) returns int as
  $$
    declare
      user_role_id int;
    begin
      select into user_role_id role_id from Userinfo where username = par_username and password = par_pass;

      return user_role_id;
    end;
  $$
  language 'plpgsql';

---------------------------------------------- END of User Accounts Maintenance ----------------------------------------------



-------------------------------------------------------- Patient File -----------------------------------------------------
--[POST] Create patient file
-- Select * from store_patient(20131288, 'David', 'Lopez', 'Guzman', 20, 'male' , 1, 1, '5 ft 5 inches' , 50 , 'January 30, 1996', 'single', 'Maria Lopez', 'Davao City', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', 'none', TRUE);

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

--[GET] patient file
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

--[GET] Retrieve the type of patient.
--select getpatienttypeID(1);
CREATE OR REPLACE FUNCTION getpatienttypeID(IN par_id INT, OUT TEXT)
  RETURNS TEXT AS
$$
SELECT type
FROM Patient_type
WHERE id = par_id;
$$
LANGUAGE 'sql';

-----------------------------------------------------END of Patient File --------------------------------------------------


-------------------------------------------------------- Assessment -------------------------------------------------------

--[GET] Retrieve the id number of a patient
--select retrievePatientID('Josiah','Timonera','Regencia');
CREATE OR REPLACE FUNCTION retrievePatientID(IN par_fname TEXT, IN par_mname TEXT, IN par_lname TEXT)
  RETURNS BIGINT AS
$$
DECLARE
  loc_id BIGINT;
BEGIN
  SELECT INTO loc_id id
  FROM Patient
  WHERE lower(fname) = lower(par_fname) AND lower(mname) = lower(par_mname) AND lower(lname) = lower(par_lname);
  RETURN loc_id;
END;
$$
LANGUAGE 'plpgsql';

-- [POST] Create new assessment
-- select new_assessment(1,'Josiah','Timonera','Regencia', 19, 1, 37.1, 80, '19 breaths/minute', '90/70', 48, 'complaint', 'history', 'medication1', 'diagnosis1','recommendation1', 1);
CREATE OR REPLACE FUNCTION new_assessment(IN par_id                 INT, IN par_fname TEXT, IN par_mname TEXT,
                                          IN par_lname              TEXT, IN par_age INT, IN par_department INT,
                                          IN par_temperature        FLOAT, IN par_pulse_rate FLOAT,
                                          IN par_respiration_rate   TEXT, IN par_blood_pressure TEXT,
                                          IN par_weight             FLOAT,
                                          IN par_chiefcomplaint     TEXT, IN par_historyofpresentillness TEXT,
                                          IN par_medicationstaken   TEXT,
                                          IN par_diagnosis          TEXT, IN par_recommendation TEXT,
                                          IN par_attendingphysician INT)
  RETURNS TEXT AS
$$
DECLARE
  loc_id1       INT;
  loc_id2       INT;
  loc_res       TEXT;
  loc_patientID BIGINT;
BEGIN
  SELECT INTO loc_id1 id
  FROM Vital_signs
  WHERE id = par_id;
  SELECT INTO loc_id2 id
  FROM Assessment
  WHERE id = par_id;

  IF par_fname = '' OR
     par_mname = '' OR
     par_lname = '' OR
     par_chiefcomplaint = '' OR
     par_medicationstaken = '' OR
     par_diagnosis = ''
  THEN
    loc_res = 'ERROR';

  ELSIF loc_id1 ISNULL AND loc_id2 ISNULL
    THEN
      INSERT INTO Vital_signs (id, temperature, pulse_rate, respiration_rate, blood_pressure, weight)
      VALUES (par_id, par_temperature, par_pulse_rate, par_respiration_rate, par_blood_pressure, par_weight);

      loc_patientID := retrievepatientID(par_fname, par_mname, par_lname);

      INSERT INTO Assessment (id, nameofpatient, age, department, vital_signs, chiefcomplaint,
                              historyofpresentillness, medicationstaken, diagnosis, recommendation, attendingphysician)
      VALUES (par_id, loc_patientID, par_age, par_department, par_id,
                      par_chiefcomplaint, par_historyofpresentillness, par_medicationstaken, par_diagnosis,
                      par_recommendation, par_attendingphysician);

      loc_res = 'OK';

  ELSE
    loc_res = 'ID EXISTS';

  END IF;
  RETURN loc_res;

END;
$$
LANGUAGE 'plpgsql';

--[GET] Retrieve assessment of a specific patient
--select getassessmentID(1);
CREATE OR REPLACE FUNCTION getassessmentID(IN par_id INT, OUT BIGINT, OUT TIMESTAMP, OUT INT, OUT INT, OUT INT, OUT INT,
                                            OUT TEXT, OUT TEXT, OUT TEXT,OUT TEXT, OUT TEXT,
                                            OUT INT, OUT BOOLEAN, OUT FLOAT, OUT FLOAT, OUT INT, OUT TEXT, OUT FLOAT,
                                            OUT TEXT, OUT TEXT)
  RETURNS SETOF RECORD AS
$$

select Assessment.*,
         Vital_signs.temperature,
         Vital_signs.pulse_rate,
         Vital_signs.respiration_rate,
         Vital_signs.blood_pressure,
         Vital_signs.weight,
         Userinfo.fname,
         Userinfo.lname
  FROM Assessment
  INNER JOIN Vital_signs ON (
    Assessment.vital_signs = Vital_signs.id
    )
  INNER JOIN Userinfo ON (
    Assessment.attendingphysician = Userinfo.id
    )
  WHERE Assessment.id = par_id;

$$
LANGUAGE 'sql';

-- [GET] Retrieve assessments of all patients
--select getallassessment();
CREATE OR REPLACE FUNCTION getallassessment(OUT BIGINT, OUT TIMESTAMP, OUT INT, OUT INT, OUT INT, OUT INT,
                                            OUT TEXT, OUT TEXT, OUT TEXT,OUT TEXT, OUT TEXT,
                                            OUT INT, OUT BOOLEAN, OUT FLOAT, OUT FLOAT, OUT INT, OUT TEXT, OUT FLOAT,
                                            OUT TEXT, OUT TEXT)
  RETURNS SETOF RECORD AS
$$

select Assessment.*,
         Vital_signs.temperature,
         Vital_signs.pulse_rate,
         Vital_signs.respiration_rate,
         Vital_signs.blood_pressure,
         Vital_signs.weight,
         Userinfo.fname,
         Userinfo.lname
  FROM Assessment
  INNER JOIN Vital_signs ON (
    Assessment.vital_signs = Vital_signs.id
    )
  INNER JOIN Userinfo ON (
    Assessment.attendingphysician = Userinfo.id
    )

$$
LANGUAGE 'sql';

-- [GET] Retrieve all assessment of a specific patient
--select getallassessmentID(1);
CREATE OR REPLACE FUNCTION getallassessmentID(IN par_id INT, OUT TIMESTAMP, OUT INT, OUT INT, OUT INT, OUT FLOAT,
                                              OUT       FLOAT, OUT TEXT, OUT TEXT, OUT FLOAT, OUT TEXT, OUT TEXT,
                                              OUT       TEXT, OUT TEXT, OUT TEXT, OUT INT)
  RETURNS SETOF RECORD AS
$$
SELECT
  assessment_date,
  nameofpatient,
  age,
  department,
  temperature,
  pulse_rate,
  respiration_rate,
  blood_pressure,
  weight,
  chiefcomplaint,
  historyofpresentillness,
  medicationstaken,
  diagnosis,
  recommendation,
  attendingphysician
FROM Assessment, Vital_signs
WHERE Assessment.nameofpatient = par_id AND Assessment.id = Vital_signs.id

$$
LANGUAGE 'sql';

--[PUT] Update assessment of patient
--select update_assessment(1,'Josiah','Timonera','Regencia', 19, 1, 37.1, 80, '19 breaths/minute', '90/70', 48, 'complaint', 'history', 'medication1', 'diagnosis11','recommendation11', 1);
CREATE OR REPLACE FUNCTION update_assessment(IN par_id                 INT, IN par_fname TEXT, IN par_mname TEXT,
                                             IN par_lname              TEXT, IN par_age INT, IN par_department INT,
                                             IN par_temperature        FLOAT, IN par_pulse_rate FLOAT,
                                             IN par_respiration_rate   TEXT, IN par_blood_pressure TEXT,
                                             IN par_weight             FLOAT,
                                             IN par_chiefcomplaint     TEXT, IN par_historyofpresentillness TEXT,
                                             IN par_medicationstaken   TEXT,
                                             IN par_diagnosis          TEXT, IN par_recommendation TEXT,
                                             IN par_attendingphysician INT)
  RETURNS TEXT AS
$$
DECLARE
  loc_res TEXT;
BEGIN

  UPDATE Assessment
  SET
    diagnosis          = par_diagnosis,
    recommendation     = par_recommendation,
    attendingphysician = par_attendingphysician
  WHERE id = par_id;

  loc_res = 'Updated';
  RETURN loc_res;

END;
$$
LANGUAGE 'plpgsql';

<<<<<<< HEAD
--[POST] Add vital signs
--select add_vital_signs(37.1,80,19,'90/70',48 );
create or replace function add_vital_signs(par_temperature float, par_pulse_rate float, par_respiration_rate int, par_blood_pressure text, par_weight float) returns text as
  $$
    declare
      loc_res text;
    begin
      if par_temperature isnull or
         par_pulse_rate isnull or
         par_respiration_rate isnull or
         par_blood_pressure isnull or
         par_blood_pressure = '' or
         par_weight isnull THEN
        loc_res = 'Please fill up the required fields';
      ELSE
        INSERT INTO Vital_signs (temperature, pulse_rate, respiration_rate, blood_pressure, weight)
        VALUES (par_temperature, par_pulse_rate, par_respiration_rate, par_blood_pressure, par_weight);
        loc_res = 'OK';
      end if;
      return loc_res;
    end;
  $$
    language 'plpgsql';
=======

-- add is_accepted column to define if the doctor can finalize the assessment or not.
alter table assessment add is_accepted boolean default 'FALSE';

create or replace function accept_assessment(in par_assessment_id int, in par_doctor_id int) returns text as
  $$
    declare loc_response text;
    begin
      update Assessment set is_accepted = 'TRUE' where id = par_assessment_id and attendingphysician = par_doctor_id;
      loc_response = 'UPDATED';
      return loc_response;
    end;
  $$
    language 'plpgsql';

create or replace function check_if_accepted(in par_assessment_id int, out int8, out int, out boolean) returns setof record as
  $$
    select id, attendingphysician, is_accepted from Assessment where id = par_assessment_id;
  $$
    language 'sql'

>>>>>>> 4ba69d92f42558d649ffdb6cc3c8574978059833
------------------------------------------------------ END Assessment -----------------------------------------------------


------------------------------------------------------- Notifications -----------------------------------------------------
--[POST] Create notification
-- select createnotify(2, 1);
CREATE OR REPLACE FUNCTION createnotify(par_assessment_id INT, par_doctor_id INT)
  RETURNS TEXT AS
$$
<<<<<<< HEAD
DECLARE
  loc_response TEXT;
  loc_id       INT;
BEGIN
  SELECT INTO loc_id assessment_id
  FROM Notification
  WHERE assessment_id = par_assessment_id;
  IF loc_id ISNULL
  THEN
    INSERT INTO Notification (assessment_id, doctor_id) VALUES (par_assessment_id, par_doctor_id);
    loc_response = 'OK';

  ELSE
    loc_response = 'ID EXISTED';
  END IF;
  RETURN loc_response;
END;
=======
  declare
      loc_response text;
      loc_id int;
  begin
        select into loc_id assessment_id from Notification where assessment_id = par_assessment_id and doctor_id = par_doctor_id;
        if loc_id isnull then
          insert into Notification(assessment_id, doctor_id) values (par_assessment_id, par_doctor_id);                            
          loc_response = 'OK';

        else
          loc_response = 'ID EXISTED';
        end if;
        return loc_response;
  end;
>>>>>>> 4ba69d92f42558d649ffdb6cc3c8574978059833
$$
LANGUAGE 'plpgsql';

--[GET] get specific notification
CREATE OR REPLACE FUNCTION getnotify(IN  par_assessment_id INT, IN par_doctor_id INT, OUT par_assessment_id INT,
                                     OUT par_doctor_id     INT, OUT par_is_read BOOLEAN)
  RETURNS SETOF RECORD AS
$$
SELECT
  doctor_id,
  assessment_id,
  is_read
FROM Notification
WHERE assessment_id = par_assessment_id AND doctor_id = par_doctor_id;
$$
LANGUAGE 'sql';


CREATE OR REPLACE FUNCTION update_notification(IN par_assessment_id INT, IN par_doctor_id INT)
  RETURNS TEXT AS
$$
DECLARE
  loc_response TEXT;

BEGIN

  UPDATE notification
  SET is_read = 'TRUE'
  WHERE assessment_id = par_assessment_id AND doctor_id = par_doctor_id;
  loc_response = 'UPDATED';
  RETURN loc_response;
END;

<<<<<<< HEAD
$$
LANGUAGE 'plpgsql';
=======
  $$
    language 'plpgsql';


create or replace function update_assessment_attendingphysician(in par_attendingphysician int, in par_assessment_id int, in par_prev_doctor int) returns text as
  $$
    declare
      loc_response text;

    begin
      update Assessment set attendingphysician = par_attendingphysician where id = par_assessment_id and attendingphysician = par_prev_doctor;
      loc_response = 'UPDATED';
      return loc_response;
    end;

  $$
    language 'plpgsql';
>>>>>>> 4ba69d92f42558d649ffdb6cc3c8574978059833
-----------------------------------------------------END Notifications ----------------------------------------------------

