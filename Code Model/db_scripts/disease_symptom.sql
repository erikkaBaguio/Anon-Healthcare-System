CREATE TABLE Disease_Symptom(
  id INT PRIMARY KEY,
  disease_id INT REFERENCES Disease(id),
  symptom_id INT REFERENCES Symptom(id),
  user_id INT REFERENCES User(id),
);