create table Question_answer (
    id INT PRIMARY KEY,
    question_id INT FOREIGN KEY REFERENCES Question(id),
    answer_id INT FOREIGN KEY REFERENCES  Answer(id),
    chained_to_question INT FOREIGN KEY REFERENCES  Question(question)
);

