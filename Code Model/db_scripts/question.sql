create table Question(
    id int primary key,
    question varchar (200),
    user_id int references User(id),
    category_id int references Question_category(id)
);

