create table UserInfo (
	id int primary key,
	fname text,
	mname text,
	lname text,
	email text,
	password text,
	role int,
	is_active boolean
);

create or replace function newuserinfo(par_id int, par_fname text, par_mname text, par_lname text,
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

create table Symptom(
  id int primary key,
  symptom text,
  done BOOLEAN
);

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
    id int primary key,
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
    id int primary key,
    question text,
    user_id int references UserInfo(id),
    category_id int references Question_category(id),
    done BOOLEAN
);

create or replace function newquestion(par_id int, par_question text, par_user_id int, par_category_id int, par_done boolean) returns text as
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
------------------------------------------------------------------------------------------------------------
create table Question_answer (
    id int primary key,
    question_id int references Question(id),
    answer_id int references  Answer(id),
    chained_to_question int references  Question(question),
    done BOOLEAN
);

CREATE or replace function newquestion_answer(par_id int, par_question_id int, par_answer_id int, par_chained_to_question int, done boolean) returns text as
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

-----------------------------------------------------------------------------------------------------------