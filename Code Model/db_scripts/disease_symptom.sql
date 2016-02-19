CREATE TABLE Disease_Symptom(
  id int primary key,
  disease_id int references Disease(id),
  symptom_id int references Symptom(id),
  user_id int references User(id),
);