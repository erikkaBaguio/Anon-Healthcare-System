create table Question_answer (
  id                    INT PRIMARY KEY,
  question_id           INT FOREIGN KEY REFERENCES Question(id),
  answer_id             INT FOREIGN KEY REFERENCES  Answer(id),
  chained_to_question   INT FOREIGN KEY REFERENCES  Question(question),
  done                  Boolean
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

