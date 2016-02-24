create table UserInfo (
	id int primary key,
	fname text,
	mname text,
	lname text,
	email text,
	password text,
	is_active boolean
);

create or replace function newuserinfo(par_id int, par_fname text, par_mname text, par_lname text,
                                par_email text, par_password text, par_is_active boolean) returns text
                                as
$$
    declare
        loc_id text;
        loc_res text;

    begin
        select into loc_id id from UserInfo where id = par_id;
        if loc_id isnull then

            insert into UserInfo(id, fname, mname, lname, email, password, is_active) values
                     (par_id, par_fname, par_mname, par_lname, par_email, par_password, par_is_active);
            loc_res = 'OK';
        else
            loc_res = 'ID EXISTED';
        end if;
        return loc_res;
    end;
$$
  language 'plpgsql';

create or replace function getuserinfo(out int, out text, out text, out text, out text,out boolean)
                                            returns setof record as
$$
    select id, fname, mname, lname, email, is_active from UserInfo;
$$
  language 'sql';

create or replace function getuserinfoid(in par_id int, out text, out text, out text, out text,
                                                 out boolean) returns setof record as
$$
    select fname, mname, lname, email, is_active from UserInfo where par_id = id;
$$
  language 'sql';
----------------------------------------------------------------------------------------------------

create table Symptom(
  id int primary key,
  symptom text(200)
);

	id INT PRIMARY KEY,
	fname varchar(45),
	mname varchar(45),
	lname varchar(45),
	email varchar(45),
	is_active boolean
);
-----------------------------------------------------------------------------------------------------
create table Schedule(
  id int primary key,
  date_time_year date,
  done boolean
);

create or replace function newschedule(par_id int, par_date_time_year date, par_done BOOLEAN) return text as
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
        end if
        return loc_res
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
  examination_name varchar(200)
  done BOOLEAN
);
-----------------------------------------------------------------------------------------------------------
create table Question_category (
    id int primary key,
    category text
);
------------------------------------------------------------------------------------------------------------
create table Disease(
  id int primary key,
  name text,
  done boolean
);

create or replace function newdisease(par_id int, par_name varchar, par_done boolean) returns text as
$$
  declare
    loc_id text,
    loc_res text,
  begin
    select into loc_id id from disease where id = par_id;
    if loc_id id isnull then

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

----------------------------------------------------------------------------------------------------

create table Symptom(
  id int primary key,
  symptom text
);

------------------------------------------------------------------------------------------------------------
create table Disease_Symptom(
  id int primary key,
  disease_id int references Disease(id),
  symptom_id int references Symptom(id),
  user_id int references UserInfo(id)
);
------------------------------------------------------------------------------------------------------------
create table Examination (
  id int primary key,
  user_id int references User(id),
  schedule_id int references Schedule(id),
  question_id int references Question(id),
  answer_id int references Answer(id),
  examination_name text,
  done BOOLEAN,
  user_id int references UserInfo(id)
);
------------------------------------------------------------------------------------------------------------
create table Question(
    id int primary key,
    question text,
    question text,
    user_id int references UserInfo(id),
    category_id int references Question_category(id)
);
------------------------------------------------------------------------------------------------------------
create table Question_answer (
    id int primary key,
    question_id int references Question(id),
    answer_id int references  Answer(id),
    chained_to_question int references  Question(question)
);
