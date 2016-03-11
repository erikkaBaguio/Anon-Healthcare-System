-- sequence will make the id (pk) auto increment.
CREATE SEQUENCE user_id_seq;
create table UserInfo (
	id serial8 primary key not null DEFAULT nextval('user_id_seq'),
	fname text,
	mname text,
	lname text,
	email text,
	password text,
	role int,
	is_active boolean
);
ALTER SEQUENCE user_id_seq OWNED BY userInfo.id;

create or replace function newuserinfo(par_id serial8, par_fname text, par_mname text, par_lname text,
                                par_email text, par_password text, par_role int, par_is_active boolean)
                                 returns text as
$$
    declare
        loc_id text;
        loc_res text;

    begin
        select into loc_id id from UserInfo where id = par_id;
        if loc_id isnull then

            insert into UserInfo(id, fname, mname, lname, email, password, role, is_active) values
                 (par_id, par_fname, par_mname, par_lname, par_email, par_password, par_role, par_is_active);
            loc_res = 'OK';
        else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
  language 'plpgsql';

create or replace function getuserinfo(out int, out text, out text, out text, out text, out int, out boolean)
                                            returns setof record as
$$
    select id, fname, mname, lname, email, role, is_active from UserInfo;
$$
  language 'sql';

create or replace function getuserinfoid(in par_id int, out text, out text, out text, out text,
                                                 out int, out boolean) returns setof record as
$$
    select fname, mname, lname, email, role, is_active from UserInfo where par_id = id;
$$
  language 'sql';
----------------------------------------------------------------------------------------------------
CREATE SEQUENCE symtom_id_seq;
create table Symptom(
  id int primary key not null DEFAULT nextval('symtom_id_seq'),
  symptom text,
  done BOOLEAN
);
ALTER SEQUENCE symtom_id_seq OWNED BY Symptom.id;

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
create table Schedule(
  id int primary key,
  date_time_year date,
  done boolean
);

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
create table Examination (
  id int primary key,
  user_id int references UserInfo(id),
  schedule_id int references Schedule(id),
  question_id int references Question(id),
  answer_id int references Answer(id),
  examination_name varchar(200),
  done BOOLEAN
);

CREATE or replace function newexamination(par_id int, par_user_id int, par_schedule_id int, par_question_id int,
                                          par_answer_id int, par_examination_name varchar, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
      SELECT INTO loc_id id from Examination WHERE id = par_id;
      if loc_id isnull THEN

        INSERT INTO Examination(id, user_id, schedule_id, question_id, answer_id, examination_name, done) values (par_id, par_user_id, par_schedule_id, par_question_id,
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
create table Question_category (
    id serial8 primary key,
    category text,
    done BOOLEAN
);

create or replace function newquestion_category(par_id int, par_category text, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from Question_category where id = par_id;
     if loc_id isnull then

       insert into Question_category (id, category, done) values (par_id, par_category, par_done);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';


------------------------------------------------------------------------------------------------------------
create table Disease(
  id int primary key,
  name text,
  done boolean
);

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
  language 'sql'

------------------------------------------------------------------------------------------------------------
create table Disease_Symptom(
  id int primary key,
  disease_id int references Disease(id),
  symptom_id int references Symptom(id),
  user_id int references UserInfo(id),
  done BOOLEAN
);

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
create table Question(
    id serial8 primary key,
    question text,
    user_id int references UserInfo(id),
    category_id int references Question_category(id),
    done BOOLEAN
);

create or replace function newquestion(par_id serial8, par_question text, par_user_id int, par_category_id int, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;

  begin
    select into loc_id id from Question where id = par_id;
    if loc_id isnull then

      insert into Question(id, question, user_id, category_id, done) values (par_id, par_question, par_user_id, par_category_id, par_done);
       loc_res = 'OK';

    else
       loc_res = 'ID EXISTED';
    end if;
    return loc_res;
  end;
$$
 language 'plpgsql';

--select newquestion(1,'What do you feel?',2013-1288, '1', false);

create or replace function get_newquestion(out serial8, out text, out int, out int, out boolean) returns setof record as
$$
  select id, question, user_id, category_id, done from Question;
$$
 language 'sql';

--select * from get_newquestion();

create or replace function get_newquestion_id(in par_id serial8, out text, out int, out int, out boolean) returns setof record as
$$
  select question, user_id, category_id, done from Question where id = par_id;
$$

--select * from get_newquestion_id(1);
------------------------------------------------------------------------------------------------------------
create table Question_answer (
    id serial8 primary key,
    question_id int references Question(id),
    answer_id int references  Answer(id),
    chained_to_question int references  Question(question),
    done BOOLEAN
);

CREATE or replace function newquestion_answer(par_id serial8, par_question_id int, par_answer_id int, par_chained_to_question int, done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from Question_answer where id = par_id;
     if loc_id isnull then
       insert into Question_answer (id, question_id, answer_id, chained_to_question, done) values (par_id, par_question_id, par_done);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';
---------------------------------------------------------------------------------------------------------------

create table Patient_status (
  id int primary key,
  blood_pressure int,
  body_temp int,
  patient_id int references Examination(id),
  done BOOLEAN
);

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

create table Diagnosis (
  id int primary key,
  examination_id int references Examination(id),
  disease_id int references Disease(id),
  done BOOLEAN
);

CREATE or replace function newdiagnosis(par_id int, par_examination_id int, par_disease_id int, par_done boolean) returns text AS
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
      SELECT INTO loc_id id from Diagnosis WHERE id = par_id;
      if loc_id isnull THEN

        INSERT INTO Diagnosis(id, par_examination_id, par_disease_id, done) values (par_id, par_examination_id, par_disease_id, par_done);
        loc_res = 'OK';

        else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
    language 'plpgsql';

-----------------------------------------------------------------------------------------------------------
create table Patient(
    id int primary key,
    fname text,
    mname text,
    lname test,
    date_of_birth date,
    age int,
    sex text,
    civil_status text,
    name_of_parent text,
    home_address text,
    height text,
    weight int,
  );

---------------------------------------------------------------------------------------------------------------
create table Pulmonary(
    cough text,
    dyspnea text,
    hemoptysis text,
    tb_exposure text
);

create table Gut(
    frequency text,
    flank plan text,
    discharge text,
    dysuria text,
    nocturia text,
    dec_urine_amount text,
);

---------------- ---------------------------------------------------------------------------------------------

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

create or replace function newillness(par_id serial8, par_asthma text, par_ptb text, par_heart_problem text
                                      par_hepatitis_a_b text, par_chicken_pox text, par_mumps text, par_typhoid_fever text, done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  BEGIN
     SELECT into loc_id id from Illness where id = par_id;
     if loc_id isnull THEN

         insert into Illness(id, asthma, ptb, heart_problem, hepatitis_a_b, chicken_pox, mumps, typhoid_fever, done) values (par_id, par_asthma, par_ptb, par_heart_problem,
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

CREATE TABLE Personal_history(
  id serial8 PRIMARY KEY,
  smoking text,
  allergies text,
  alcohol text,
  medication_taken text,
  drugs text,
  done BOOLEAN
);

create or replace function newpersonal_history(par_id serial8, par_smoking text, par_allergies text, par_alcohol text,
                                               par_medication_taken text, par_drugs text, par_done boolean) returns text as
$$
 declare
   loc_id text;
   loc_res text;
 BEGIN
   SELECT into loc_id id from Personal_history where id = par_id;
   if loc_id isnull THEN

       INSERT into Personal_history(id, smoking, allergies, alcohol, medication_taken, drugs, done) VALUES (par_id, par_smoking, par_allergies,
                                                par_alcohol, par_medication_taken, par_drugs, par_done);
       loc_res = 'OK';

   ELSE
       loc_res = 'ID EXISTED';
   END if;
   return loc_res;
 END;
$$
 language 'plpsql';

---------------------------------------------------------------------------------------------------------------

CREATE TABLE Cardiac(
  id serial8 PRIMARY KEY,
  chest_pain text,
  palpitations text,
  pedal_edema text,
  orthopnea text,
  nocturnal_dyspnea text,
  done BOOLEAN
);

CREATE  or replace function newcardiac(par_id serial8, par_chest_pain text, par_palpitations text, par_pedal_edema text, par_orthopnea text, par_nocturnal_dyspnea text, par_done boolean) returns text as
$$
  DECLARE
    loc_id text;
    loc_res text;
  BEGIN
    SELECT INTO  loc_id id from Cardiac where id = par_id;
    if loc_id isnull THEN

      INSERT into Cardiac(id, chest_pain, palpitations, pedal_edema, orthopnea, nocturnal_dyspnea, done) VALUES (par_id, par_chest_pain, par_palpitations, par_pedal_edema, par_orthopnea, par_nocturnal_dyspnea, par_done);
      loc_res = 'OK';

    ELSE
      loc_res = 'ID EXISTED';
    END if;
    return loc_res;
  END ;
$$
 LANGUAGE 'plpgsql';

----------------------------------------------------------------------------------------------------------------

CREATE TABLE Neurologic(
  id serial8 PRIMARY KEY,
  headache text,
  seizure text,
  dizziness text,
  loss_of_consciousness text,
  done BOOLEAN
);

create or replace function newneurologic(par_id serial8, par_headache text, par_seizure text, par_dizziness text, par_loss_of_consciousness text, par_done boolean) returns text as
$$
 DECLARE
   loc_id text;
   loc_res text;
 BEGIN
   SELECT into loc_id id from Neurologic where id = par_id;
   if loc_id isnull THEN

     INSERT INTO Neurologic(id, headache, seizure, dizziness, loss_of_consciousness, done) values (par_id, par_headache, par_seizure, par_dizziness, par_loss_of_consciousness, par_done);
     loc_res = 'OK';

   ELSE
     loc_res = 'ID EXISTED';
   END if;
   return loc_res;
 END;
$$
 LANGUAGE  'plpgsql';

-----------------------------------------------------------------------------------------------------------------