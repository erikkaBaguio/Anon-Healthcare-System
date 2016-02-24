create table Question_answer (
<<<<<<< HEAD
  id                    INT PRIMARY KEY,
  question_id           INT FOREIGN KEY REFERENCES Question(id),
  answer_id             INT FOREIGN KEY REFERENCES  Answer(id),
  chained_to_question   INT FOREIGN KEY REFERENCES  Question(question),
  done                  Boolean
=======
    id int primary key,
    question_id int references Question(id),
    answer_id int references  Answer(id),
    chained_to_question int references  Question(question)
>>>>>>> d678e53ccd72812727f3227d8eb6aff1f2d218e5
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

