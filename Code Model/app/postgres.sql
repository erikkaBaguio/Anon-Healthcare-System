create table UserInfo (
	id int primary key,
	fname varchar(45),
	mname varchar(45),
	lname varchar(45),
	email varchar(45),
	password varchar(45),
	is_active boolean
);

create or replace newuserinfo(par_id int, par_fname varchar, par_mname varchar, par_lname varchar,
                                par_email varchar, par_password varchar, par_is_active boolean) returns text
                                as
$$
    declare
        loc_id;
        loc_res;

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
----------------------------------------------------------------------------------------------------

create table Symptom(
  id int primary key,
  symptom varchar(200)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Schedule(
  id int primary key,
  date_time_year date,
  done boolean
);

create or replace newschedule(par_id int, par_date_time_year date, par_done BOOLEAN) return text as
$$
    declare
        loc_id TEXT;
        loc_res TEXT;
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

-----------------------------------------------------------------------------------------------------------

create table Question_category (
    id int primary key,
    category varchar(100)
);

------------------------------------------------------------------------------------------------------------
create table Disease(
  id int primary key,
  name varchar(200),
  done boolean
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
  examination_name varchar(200),
  done BOOLEAN
);
------------------------------------------------------------------------------------------------------------
create table Question(
    id int primary key,
    question varchar (200),
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
