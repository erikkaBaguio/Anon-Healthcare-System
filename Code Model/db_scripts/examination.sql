CREATE TABLE examination(
  id INT PRIMARY KEY,
  user_id INT REFERENCES user(id)
  schedule_id INT REFERENCES schedule(id)
  question_id INT REFERENCES question(id)
  answer_id INT REFERENCES answer(id)
  examination_name VARCHAR(200)
);