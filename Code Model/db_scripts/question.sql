create table Question(
<<<<<<< HEAD
    id          INT primary key,
    question    VARCHAR (200),
    user_id     INT FOREIGN KEY REFERENCES Users(id),
    category_id INT FOREIGN KEY REFERENCES Question_category(id),
    done        Boolean
=======
    id int primary key,
    question varchar (200),
    user_id int references User(id),
    category_id int references Question_category(id)
>>>>>>> d678e53ccd72812727f3227d8eb6aff1f2d218e5
);

create or replace function newquestion(par_id int, par_question varchar, par_user_id int, par_category_id int, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;

  begin
    select into loc_id id from Question where id = par_id;
    if loc_id isnull then

      insert into Question(id, question, user_id, category_id, done) values (par_id, par_question, par_user_id, par_category_id, par_done);
       loc_res = 'OK';

    else
       loc_res = 'ID EXISTED';
    end if;
    return loc_res;
  end;
$$
 language 'plpgsql';