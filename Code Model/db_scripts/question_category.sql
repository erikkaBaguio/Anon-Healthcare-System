create table Question_category (
    id       Int PRIMARY KEY,
    category_name VARCHAR(100),
    done     Boolean
);


create or replace function newquestion_category(par_id int, par_category varchar, par_done boolean) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from Question_category where id = par_id;
     if loc_id isnull then

       insert into Question_category (id, category, done) values (par_id, par_category, par_done);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

