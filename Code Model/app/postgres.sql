create table userinfo (
  	id serial8 primary key,
  	fname text,
  	mname text,
  	lname text,
  	email text,
  	password text,
  	is_active boolean
  );

create table College(
  id serial8 primary key,
  name text not null,
  is_active boolean default True
);

create table Department(
  id serial8 primary key,
  name text not null,
  college_id int references College(id),
  is_active boolean default True
);

create table Vital_signs  (
  id serial8 primary key,
  temperature float,
  pulse_rate float,
  respiration_rate text,
  blood_pressure text,
  weight float
);

create table Personal_history(
  id serial8 primary key,
  smoking text,
  allergies text,
  alcohol text,
  medication_taken text,
  drugs text,
  done BOOLEAN
);


create table Patient_type(
    id serial8 primary key,
    type text
);

create table Personal_info(
    id serial8 primary key,
    height text,
    weight float,
    date_of_birth date,
    civil_status text,
    name_of_guardian text,
    home_address text,
    is_active BOOLEAN default True
);

create table Patient(
    id serial8 primary key,
    fname text,
    mname text,
    lname text,
    age int,
    sex text,
    department_id int references Department(id),
    patient_type_id int references Patient_type(id),
    Personal_info_id int references Personal_info(id),
    is_active BOOLEAN default True

);

create table Pulmonary(
    cough text,
    dyspnea text,
    hemoptysis text,
    tb_exposure text
);

create table Gut(
    frequency text,
    flank_plan text,
    discharge text,
    dysuria text,
    nocturia text,
    dec_urine_amount text
);

create table Illness(
  id serial8 primary key,
  asthma text,
  ptb text,
  heart_problem text,
  hepatitis_a_b text,
  chicken_pox text,
  mumps text,
  typhoid_fever text,
  done BOOLEAN
);

create table Cardiac(
  id serial8 PRIMARY KEY,
  chest_pain text,
  palpitations text,
  pedal_edema text,
  orthopnea text,
  nocturnal_dyspnea text,
  done BOOLEAN
);

create table Neurologic(
  id serial8 UNIQUE PRIMARY KEY,
  headache text,
  seizure text,
  dizziness text,
  loss_of_consciousness text,
  done BOOLEAN
);

create table Assessment(
  id serial8 primary key,
  assessment_date timestamp default 'now',
  nameofpatient int references Patient(id),
  age int,
  department int references Department(id),
  vital_signs int references Vital_signs(id),
  chiefcomplaint text,
  historyofpresentillness text,
  medicationstaken text,
  diagnosis text,
  reccomendation text,
  attendingphysician int references userinfo(id),
  is_done boolean default False
);

insert into College values (1,'SCS');
insert into College values (2,'COE');
insert into College values (3,'CED');
insert into College values (4,'CASS');
insert into College values (5,'SET');
insert into College values (6,'CBAA');
insert into College values (7,'CON');
insert into College values (8,'CSM');

insert into Patient_type values (1,'Student');
insert into Patient_type values (2,'Faculty');
insert into Patient_type values (3,'Staff');
insert into Patient_type values (4,'Outpatient Department');

insert into Department values (1,'Computer Science',1);

create table Final_diagnosis(
  id serial8 primary key,
  assessment_id int references Assessment(id),
  doctor_id int references userinfo(id),
  description text
);

create table Notification(
  id serial8 primary key,
  assessment_id int references Assessment(id),
  doctor_id int references userinfo(id),
  is_read boolean default FALSE
);
-----------------------------------------------------------------------------------------------------------
-----STORED PROCEDURE FUNCTIONS-----
-----------------------------------------------------------------------------------------------------------

create or replace function checkauth(par_email text,par_password text) returns text as
$$
  declare
    loc_email text;
    loc_password text;
    loc_res text;
  begin
    select into loc_email email from userinfo where email = par_email and password = par_password;
       if loc_email isnull then
        loc_res = 'email';
       elseif loc_password isnull then
        loc_res = 'password!';
      else
        loc_res = 'OK';
      end if;
      return loc_res;
  end;
$$
  language 'plpgsql';

--select newuser('Jobee','Mcdo', 'Chowking', 'j@e.com', 'password');
create or replace function newuserinfo(par_fname text, par_mname text, par_lname text,
                                par_email text)
                                 returns text as
$$

    declare
        loc_res text;
        random_password text;
        username text;

    begin

        username := par_fname || '.' || par_lname;
        random_password := generate_password();

       insert into userinfo (fname, mname, lname, email, username, password)
                values (par_fname, par_mname, par_lname, par_email, username, random_password);


       loc_res = 'OK';
       return random_password;
  end;
$$
 language 'plpgsql';


  create or replace function generate_password() returns text as
 $$
    declare
        characters text;
        random_password text;
        len int4;
        placevalue int4;

    begin
        characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()+=';
        len := length(characters);
        random_password := '';


        while(length(random_password) < 16) loop

            placevalue := int4(random() * len);
            random_password := random_password || substr(characters, placevalue + 1, 1);

        end loop;

        return random_password;
    end;
$$

LANGUAGE 'plpgsql';



--select newuserinfo('Mary Grace', 'Pasco', 'Cabolbol', 'marygracecabolbol@gmail.com', 'password', 1, true);
--select newuserinfo('Ma.Erikka', 'P' , 'Baguio', 'ma.erikkabaguio@gmail.com', 'password' , 1, true);

create or replace function getuserinfo(out text, out text, out text, out text, out boolean)
                                              returns setof record as
$$
    select fname, mname, lname, email, is_active from UserInfo;
$$
  language 'sql';

--select * from getuserinfo();

create or replace function getuserinfoid(in par_id int, out text, out text, out text, out text,
                                                 out int, out boolean) returns setof record as
$$
    select fname, mname, lname, email, role, is_active from UserInfo where par_id = id;
$$
  language 'sql';

--select * from getuserinfoid(1);
----------------------------------------------------------------------------------------------------
create or replace function newrole(par_rolename  text) returns text as
$$
  declare
    loc_name text;
    loc_res text;
  begin

    select into loc_name role_name from roles where role_name = par_rolename;

    if loc_name isnull then
      insert into roles(role_name) values (par_rolename);
      loc_res = 'OK';

    else
      loc_res = 'EXISTED';

    end if;
      return loc_res;
  end;
$$
 language 'plpgsql';

----------------------------------------------------------------------------------------------------

create or replace function newpersonal_history(par_smoking text, par_allergies text, par_alcohol text,
                                               par_medication_taken text, par_drugs text, par_done boolean) returns text as
$$
 declare
   loc_id text;
   loc_res text;
 BEGIN
   #SELECT into loc_id id from Personal_history;
   if loc_id isnull THEN

       INSERT into Personal_history(smoking, allergies, alcohol, medication_taken, drugs, done) VALUES (par_smoking, par_allergies,
                                                par_alcohol, par_medication_taken, par_drugs, par_done);
       loc_res = 'OK';

   ELSE
       loc_res = 'ID EXISTED';
   END if;
   return loc_res;
 END;
$$
 language 'plpgsql';

---------------------------------------------------------------------------------------------------------------

CREATE  or replace function newcardiac(par_chest_pain text, par_palpitations text, par_pedal_edema text, par_orthopnea text, par_nocturnal_dyspnea text, par_done boolean) returns text as
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
    SELECT INTO  loc_id id from Cardiac;
    if loc_id isnull THEN

      INSERT into Cardiac(chest_pain, palpitations, pedal_edema, orthopnea, nocturnal_dyspnea, done) VALUES (par_chest_pain, par_palpitations, par_pedal_edema, par_orthopnea, par_nocturnal_dyspnea, par_done);
      loc_res = 'OK';

    ELSE
      loc_res = 'ID EXISTED';
    END if;
    return loc_res;
  END ;
$$
 LANGUAGE 'plpgsql';

----------------------------------------------------------------------------------------------------------------

create or replace function newneurologic(par_headache text, par_seizure text, par_dizziness text, par_loss_of_consciousness text, par_done boolean) returns text as
$$
 DECLARE
   loc_id text;
   loc_res text;
 BEGIN
   SELECT into loc_id id from Neurologic;
   if loc_id isnull THEN

     INSERT INTO Neurologic(headache, seizure, dizziness, loss_of_consciousness, done) values (par_headache, par_seizure, par_dizziness, par_loss_of_consciousness, par_done);
     loc_res = 'OK';

   ELSE
     loc_res = 'ID EXISTED';
   END if;
   return loc_res;
 END;
$$
 LANGUAGE  'plpgsql';

-----------------------------------------------------------------------------------------------------------------
--[GET] Retrieve list of colleges
--select getallcolleges();
create or replace function getallcolleges(out bigint, out text) returns setof record as
$$
	select id, name from College;
$$
	language 'sql';

--[GET] Retrieve specific college
--select getcollegeID(1);
create or replace function getcollegeID(in par_id int, out text) returns text as
$$
  select name from College where id = par_id;
$$
  language 'sql';

--[GET] Retrieve list of departments
--select getalldepartments();
create or replace function getalldepartments(out bigint, out text) returns setof record as
$$
	select id, name from Department;
$$
	language 'sql';

--[GET] Retrieve specific department
--select getdepartmentID(1);
create or replace function getdepartmentID(in par_id int, out text, out text) returns setof record as
$$
  select Department.name, College.name
  from Department, College
  where Department.id = par_id and College.id = Department.college_id;
$$
  language 'sql';


--------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function newpatient(par_fname text, par_mname text, par_lname text, par_age int, par_sex text, 
                                      par_department_id int, par_patient_type_id int, par_personal_info_id int, par_is_active boolean) returns text as
$$
  declare
      loc_fname text;
      loc_mname text;
      loc_lname text;
      loc_res text;

  begin
      SELECT INTO loc_fname fname from Patient where fname = par_fname AND mname = par_mname AND lname = par_lname;
      if loc_fname isnull THEN
         insert into Patient(fname, mname, lname, age, sex, department_id, patient_type_id, personal_info_id, is_active) values 
          (par_fname, par_mname, par_lname, par_age, par_sex, par_department_id, par_patient_type_id, par_personal_info_id par_is_active);

         loc_res = 'OK';
      else
        loc_res = 'Patient already EXISTED';
      end if;
      return loc_res;
    end;
$$
  language 'plpgsql';

--select newpatient('Mary Grace', 'Pasco', 'Cabolbol', '19', 'female', '1' , '1', '1', 'true');
create or replace function get_newpatient(out text, out text, out text, out int, out text, out int, out int, out int, out boolean) returns setof record as
$$
  select fname, mname, lname, age, sex, department_id, patient_type_id, personal_info_id, is_active from Patient;
$$
  language 'sql';

--select * from get_newpatient();

create or replace function get_newpatient_id(in par_id int, out text, out text, out text, out int, out text, out int, out int, out int, out boolean) returns setof record as
$$
  select fname, mname, lname, age, sex, department_id, patient_type_id, personal_info_id, is_active from Patient where par_id = id;
$$
  language 'sql';

--select * from get_newpatient_id(1);

------------------------------------------------------------------------------------------------------------------------------------------

create or replace function newpersonal_info(par_height text, par_weight float, par_date_of_birth date, par_civil_status text, par_name_of_guardian text, par_home_address text, is_active boolean) returns text as
$$
  declare
      loc_id text;
      loc_res text;
  begin
        insert into Personal_info(height, weight, date_of_birth, civil_status, name_of_guardian, home_address, is_active) values 
                                  (par_height , par_weight , par_date_of_birth , par_civil_status, par_name_of_guardian , par_home_address , is_active );                            
        loc_res = 'Ok';
     
  end;
$$
  language 'plpgsql';

--select newpersonal_info('4ft 11inch', '84', 'July 25, 1996', 'single', 'Marissa Cabolbol', 'Biga, Lugait, Misamis Oriental');

create or replace function get_newpersonal_info(out text, out float, out date, out text, out text, out text, out boolean) returns setof record as
$$
  select height, weight, date_of_birth, civil_status, name_of_guardian, home_address, is_active from Personal_info; 
$$
  language 'sql';


create or replace function get_newpersonal_info_id(in par_id int, out text, out float, out date, out text, out text, out text, out boolean) returns setof record as
$$  
  select height, weight, date_of_birth, civil_status, name_of_guardian, home_address, is_active from Personal_info where par_id = id;
$$
  language 'sql';


------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICATIONS

-- TRIGGER (notification) - if new assessment is created, automatically create new notification
create or replace function notify() RETURNS trigger AS '
  BEGIN
    IF tg_op = ''INSERT'' THEN
      INSERT INTO Notification (assessment_id, doctor_id)
          VALUES (new.id, new.attendingphysician);
    END IF;
  END
  ' LANGUAGE plpgsql;

CREATE TRIGGER notify_trigger AFTER INSERT ON Assessment FOR each ROW
EXECUTE PROCEDURE notify();

------------------------------------------------------------------------------------------------------------------------------------------
-- FINAL DIAGNOSIS

--CREATE FINAL DIAGNOSIS
create or replace function createFinalDiagnosis(par_assessment_id int, par_doctor_id int, par_description text) returns text as
$$
  declare
      loc_response text;
  begin
        insert into Final_diagnosis(assessment_id, doctor_id, description) values (par_assessment_id, par_doctor_id, par_description);
        loc_response = 'Ok';
        return loc_res;
  end;
$$
  language 'plpgsql';

-- GET FINAL DIAGNOSIS
--select getdepartmentID(1);
create or replace function getFinalDiagnosis(in par_id int, out int, out int, out text) returns text as
$$
  select * from Final_diagnosis where id = par_id;
$$
  language 'sql';
-----------------------------------------------------------------------------------------------------------------------------

-- [POST] Create new assessment
-- select new_assessment(1,18,1,1,'doc','history','medication','diagnosis', 'recccomendation', 1);
create or replace function new_assessment(par_nameofpatient int, par_age int, par_department int, par_vital_signs int,
par_chiefcomplaint text, par_historyofpresentillness text, par_medicationstaken text,
par_diagnosis text, par_reccomendation text, par_attendingphysician int) returns text as
 $$
  declare
    loc_id int;
    loc_res text;
  begin
    select into loc_id id from Assessment;
    if loc_id isnull then
      insert into Assessment ( nameofpatient, age, department,vital_signs ,chiefcomplaint ,
      historyofpresentillness ,medicationstaken ,diagnosis ,reccomendation ,attendingphysician )
      values ( par_nameofpatient, par_age, par_department, par_vital_signs,
      par_chiefcomplaint, par_historyofpresentillness, par_medicationstaken, par_diagnosis,
      par_reccomendation, par_attendingphysician);
      loc_res = 'OK';
    else
      loc_res = 'ID EXISTED';
    end if;
    return loc_res;
  end;
 $$
  language 'plpgsql';


--[GET] Retrieve specific Patient's assessment
--select getassessmentID(1);
create or replace function getassessmentID(in par_id int, out timestamp, out int,out int,out int,out int, out text,
out text,out text,out text,out text,out int) returns setof record as
$$
  select assessment_date, nameofpatient, age, department,vital_signs ,chiefcomplaint ,
      historyofpresentillness ,medicationstaken ,diagnosis ,reccomendation ,attendingphysician from Assessment where id = par_id;
$$
  language 'sql';

-- [GET] Retrieve all patients' assessment
--select getallassessment();
create or replace function getallassessment(out bigint,out timestamp, out int,out int,out int,out int, out text,
out text,out text,out text,out text,out int) returns setof record as
$$
  select * from Assessment;
$$
  language 'sql';

-----------------------------------------------------------------------------------------------------------------
--[POST] Add new patient's vital signs
--select addvitalsigns(10.1,20.1,'rr','50/50',45.5);
create or replace function addvitalsigns(par_temperature float,par_pulse_rate float,par_respiration_rate text,
par_blood_pressure text, par_weight float) returns text as
$$
  declare
    loc_id text;
    loc_res text;

  begin
    select into loc_id id from Vital_signs;

      if loc_id isnull then
        insert into Vital_signs(temperature,pulse_rate,respiration_rate,blood_pressure,weight)
        values (par_temperature,par_pulse_rate,par_respiration_rate,par_blood_pressure , par_weight );

        loc_res = 'OK';
      else
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  end;

$$
  language 'plpgsql';

--[GET] Retrieve patient's vital signs.
-- select getvitalsignsID(1);
create or replace function getvitalsignsID(in par_id int, out float, out float, out text ,out text ,out float) returns setof record as
$$
  select temperature,pulse_rate,respiration_rate,blood_pressure,weight from Vital_signs where id = par_id;
$$
  language 'sql';

------------------------------------------------------------------------------------------------------------------
--[GET] Retrieve the type of patient.
--select getpatienttypeID(1);
create or replace function getpatienttypeID(in par_id int, out text) returns text as
$$
  select type from Patient_type where id = par_id;
$$
  language 'sql';