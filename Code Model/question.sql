create table question(
    id primary key,
    question string(200),
    category_id FOREIGN KEY,
    user_id FOREIGN KEY
);

