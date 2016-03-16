create table roles(
  id serial4 primary key,
  role_name text
);

create table userinfo (
  	id serial8 primary key,
  	fname text,
  	mname text,
  	lname text,
  	username text unique,
  	email text,
  	password text,
  	is_active BOOLEAN,
    role_id int references roles(id)
);

create table Symptom(
  id serial8 primary key,
  symptom text,
  done BOOLEAN
);

create table Schedule(
  id int primary key,
  date_time_year date,
  done boolean
);

create table Question_category (
    id serial8 primary key,
    category text,
    done BOOLEAN
);

create table Question(
    id serial8 primary key,
    question text,
    user_id int references UserInfo(id),
    category_id int references Question_category(id),
    is_active BOOLEAN
);

create table Examination (
  id int primary key,
  user_id int references UserInfo(id),
  schedule_id int references Schedule(id),
  question_id int references Question(id),
  --answer_id int references Answer(id),
  examination_name varchar(200),
  done BOOLEAN
);

create table Disease(
  id int primary key,
  name text,
  done boolean
);

create table Disease_Symptom(
  id int primary key,
  disease_id int references Disease(id),
  symptom_id int references Symptom(id),
  user_id int references UserInfo(id),
  done BOOLEAN
);


create table Question_answer (
    id serial8 primary key,
    question_id int references Question(id),
    --answer_id int references  Answer(id),
    chained_to_question int references  Question(id),
    done BOOLEAN
);

create table Patient_status (
  id int primary key,
  blood_pressure int,
  body_temp int,
  patient_id int references Examination(id),
  done BOOLEAN
);

create table Diagnosis (
  id int primary key,
  examination_id int references Examination(id),
  disease_id int references Disease(id),
  done BOOLEAN
);

create table Patient(
    id int primary key,
    fname text,
    mname text,
    lname text,
    date_of_birth date,
    age int,
    sex text,
    civil_status text,
    name_of_parent text,
    home_address text,
    height text,
    weight int
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

CREATE TABLE Illness(
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

CREATE TABLE Personal_history(
  id serial8 PRIMARY KEY,
  smoking text,
  allergies text,
  alcohol text,
  medication_taken text,
  drugs text,
  done BOOLEAN
);

CREATE TABLE Cardiac(
  id serial8 PRIMARY KEY,
  chest_pain text,
  palpitations text,
  pedal_edema text,
  orthopnea text,
  nocturnal_dyspnea text,
  done BOOLEAN
);

CREATE TABLE Neurologic(
  id serial8 UNIQUE PRIMARY KEY,
  headache text,
  seizure text,
  dizziness text,
  loss_of_consciousness text,
  done BOOLEAN
);



-----------------------------------------------------------------------------------------------------------
-----STORED PROCEDURE FUNCTIONS-----
-----------------------------------------------------------------------------------------------------------

--table userinfo

create or replace function newuserinfo(par_fname text, par_mname text, par_lname text,
                                par_email text, par_active boolean, par_role int)
                                 returns text as
$$

    declare
        loc_res text;
        random_password text;
        username text;

    begin

        username := par_fname || '.' || par_lname;
        random_password := generate_password();

       insert into userinfo (fname, mname, lname, username, email, password, is_active, role_id)
                values (par_fname, par_mname, par_lname, username, par_email, random_password, par_active, par_role);


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

--create or replace function getuserinfo(out text, out text, out text, out text, out int, out boolean)
create or replace function getuserinfo(out text, out text, out text, out text,
                                out text, out int, out boolean)
                                            returns setof record as
$$
    select fname, mname, lname, email, password, role_id, is_active from UserInfo;
$$
  language 'sql';

--select * from getuserinfo();

create or replace function getuserinfoid(in par_id int, out text, out text, out text, out text,
                                                 out int, out boolean) returns setof record as
$$
    select fname, mname, lname, email, role_id, is_active from UserInfo where par_id = id;
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

create or replace function newsymptom(par_id int, par_symptom text, par_done boolean) returns text AS
$$
  DECLARE
      loc_id text;
      loc_res text;
  BEGIN
      SELECT  INTO loc_id id Symptom where id = par_id;

      if loc_id isnull THEN
          insert INTO Symptom(id, symptom, done) values (par_id, par_symptom, par_done);
          loc_res = 'OK';

      else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
  end;
$$
  language 'plpgsql';

-----------------------------------------------------------------------------------------------------

create or replace function newschedule(par_id int, par_date_time_year date, par_done BOOLEAN) returns text as
$$
    declare
        loc_id text;
        loc_res text;
    begin
        select into loc_id id Schedule where id = par_id;

        if loc_id isnull then
            insert into Schedule(id, date_time_year, done) values (par_id, par_date_time_year, par_done);
            loc_res = 'OK';

        else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';

------------------------------------------------------------------------------------------------------------

CREATE or replace function newexamination(par_id int, par_user_id int, par_schedule_id int, par_question_id int,
                                          par_answer_id int, par_examination_name varchar, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
      SELECT INTO loc_id id from Examination WHERE id = par_id;
      if loc_id isnull THEN

        INSERT INTO Examination(id, user_id, schedule_id, question_id, answer_id, examination_name, done)
                        values (par_id, par_user_id, par_schedule_id, par_question_id)
                                                                                                                  par_answer_id, par_examination_name, par_done);
        loc_res = 'OK';

      else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';

-----------------------------------------------------------------------------------------------------------

create or replace function newquestion_category(par_category text, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     if loc_id isnull then

       insert into Question_category (category, done) values (par_category, par_done);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--select newquestion_category('moderate', false);
--select newquestion_category('severe', false);

create or replace function get_newquestion_category(out text, out boolean) returns setof record as
$$
  select category, done from Question_category;
$$
 language 'sql';

--select * from get_newquestion_category();

create or replace function get_newquestion_category_id(in par_id int, out text, out boolean) returns setof record as
$$
  select category, done from Question_category where par_id = id;
$$
 language 'sql';

--select * from get_newquestion_category_id(3);

------------------------------------------------------------------------------------------------------------

create or replace function newdisease(par_id int, par_name varchar, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
    select into loc_id id from disease where id = par_id;
    if loc_id isnull then

      insert into disease(id, name, done) values (par_id, pr_name, par_done);
      loc_res = "New disease data is added.";

    else
      loc_res = "ID EXISTED";
    end if;
    return loc_res;
  end;
$$
  language 'plpgsql';

create or replace function getdiseaseinfo(in par_id int, out text, out boolean) returns setof record as
$$
  select name, done from Disease where id = par_id;
$$
  language 'sql';

------------------------------------------------------------------------------------------------------------

CREATE  or replace function newdisease_symptom(par_id int, par_disease_id int, par_symptom_id int, par_user_id int, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;

  BEGIN
    SELECT INTO loc_id id FROM Disease_Symptom where id = par_id;
    if loc_id isnull THEN

      INSERT INTO Disease_Symptom(id, disease_id, symptom_id, user_id, done) VALUES (par_id, par_disease_id, par_symptom_id, par_user_id, par_done);
      loc_res = 'OK';

    else
       loc_res = 'ID EXISTED';
    end if;
    return loc_res;
  end;
$$
 language 'plpgsql';

------------------------------------------------------------------------------------------------------------

create or replace function newquestion(par_question text, par_user_id int, par_category_id int, par_is_active boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;

  begin
    if loc_id isnull then

      insert into Question( question, user_id, category_id, is_active) values (par_question, par_user_id, par_category_id, par_is_active);
       loc_res = 'OK';

    else
       loc_res = 'ID EXISTED';
    end if;
    return loc_res;
  end;
$$
 language 'plpgsql';

--select newquestion('What do you feel?', 1 , 1, false);
--select newquestion('How old are you?', 1 , 1 , false);
--select newquestion('Hoarseness or a problem with your voice', 1, 1, false);
create or replace function get_newquestion(out text, out int, out int, out boolean) returns setof record as
$$
  select question, user_id, category_id, is_active from Question;
$$
 language 'sql';

--select * from get_newquestion();

create or replace function get_newquestion_id(in par_id int, out text, out int, out par int, out boolean) returns setof record as
$$
  select question, user_id, category_id, is_active from Question where par_id = id;
$$
 language 'sql';

SELECT * from get_newquestion_id(1);
-----------------------------------------------------------------------------------------------------------

CREATE or replace function newquestion_answer(par_question_id int, par_answer_id int, par_chained_to_question int, done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from Question_answer;
     if loc_id isnull then
       insert into Question_answer (question_id, answer_id, chained_to_question, done) values (par_question_id, par_done);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';
---------------------------------------------------------------------------------------------------------------

CREATE or replace function newpatientstatus(par_id int, par_blood_pressure int, par_body_temp int, par_patiend_id int, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
      SELECT INTO loc_id id from Patient_status WHERE id = par_id;
      if loc_id isnull THEN

      INSERT INTO Patient_status(id, blood_pressure, body_temp, patient_id, done) values (par_id, par_blood_pressure, par_body_temp, par_patiend_id, par_done);
      loc_res = 'OK';

      else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';

-----------------------------------------------------------------------------------------------------------

CREATE or replace function newdiagnosis(par_examination_id int, par_disease_id int, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
      SELECT INTO loc_id id from Diagnosis;
      if loc_id isnull THEN

        INSERT INTO Diagnosis(par_examination_id, par_disease_id, done) values (par_examination_id, par_disease_id, par_done);
        loc_res = 'OK';

        else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';

-----------------------------------------------------------------------------------------------------------
create or replace function newillness(par_asthma text, par_ptb text, par_heart_problem text,
                                      par_hepatitis_a_b text, par_chicken_pox text, par_mumps text, par_typhoid_fever text, done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  BEGIN
     SELECT into loc_id id from Illness;
     if loc_id isnull THEN

         insert into Illness(asthma, ptb, heart_problem, hepatitis_a_b, chicken_pox, mumps, typhoid_fever, done) values (par_asthma, par_ptb, par_heart_problem,
                                                                                                    par_hepatitis_a_b, par_chicken_pox, par_mumps, par_typhoid_fever, par_done);
          loc_res = 'OK';

      else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';
--------------------------------------------------------------------------------------------------------------

create or replace function newpersonal_history(par_smoking text, par_allergies text, par_alcohol text,
                                               par_medication_taken text, par_drugs text, par_done boolean) returns text as
$$
 declare
   loc_id text;
   loc_res text;
 BEGIN
   SELECT into loc_id id from Personal_history;
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
