CREATE TABLE Examination(
  id INT PRIMARY KEY,
  user_id INT REFERENCES User(id)
  schedule_id INT REFERENCES Schedule(id)
  question_id INT REFERENCES Question(id)
  answer_id INT REFERENCES Answer(id)
  examination_name VARCHAR(200)
);