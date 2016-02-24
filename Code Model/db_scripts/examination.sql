create table Examination (
  id int primary key,
  user_id int references User(id),
  schedule_id int references Schedule(id),
  question_id int references Question(id),
  answer_id int references Answer(id),
  examination_name varchar(200)
  done BOOLEAN
);

create or REPLACE FUNCTION newexamination(par_id int, par_user_id int, par_schedule_id int, par_question_id int,
                                        par_answer_id int, par_examination_name varchar,
                                           par_done BOOLEAN) return TEXT as
$$
    declare
        loc_id TEXT;
        loc_res TEXT;

    begin
        select into loc_id id from Examination where id = par_id;

        if loc_id isnull then
            insert into Examination(id, user_id, schedule_id, question_id, answer_id examination_name, done)
                              values (par_id, par_user_id, par_schedule_id, par_question_id, par_answer_id,
                                    par_examination_name, par_done);
            loc_res = 'OK';

         else
            loc_res = 'ID EXISTED';
         end if
         return loc_res;
    end;
$$
    language 'plpgsql';