CREATE TABLE Examination (
  id INT PRIMARY KEY,
  user_id INT REFERENCES User(id),
  schedule_id INT REFERENCES Schedule(id),
  question_id INT REFERENCES Question(id),
  answer_id INT REFERENCES Answer(id),
  examination_name VARCHAR(200)
  done BOOLEAN
);

CREATE OR REPLACE FUNCTION newexamination(par_id INT, par_user_id INT, par_schedule_id INT, par_question_id INT,
                                        par_answer_id INT, par_examination_name VARCHAR,
                                           par_done BOOLEAN) return TEXT as
$$
    declare
        loc_id TEXT;
        loc_res TEXT;

    begin
        SELECT INTO loc_id id FROM Examination WHERE id = par_id;
        if loc_id isnull THEN
            INSERT INTO Examination(id, user_id, schedule_id, question_id, answer_id examination_name, done)
                              VALUES (par_id, par_user_id, par_schedule_id, par_question_id, par_answer_id,
                                    par_examination_name, par_done);
            loc_res = 'OK';

         else
            loc_res = 'ID EXISTED';
         end if
         return loc_res;
    end;
$$
    language 'plpgsql';