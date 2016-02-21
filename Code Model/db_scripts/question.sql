create table Question(
    id INT primary key,
    question VARCHAR (200),
    user_id INT FOREIGN KEY REFERENCES User(id),
    category_id INT FOREIGN KEY REFERENCES Question_category(id)
);

