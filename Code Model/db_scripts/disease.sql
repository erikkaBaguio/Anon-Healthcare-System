create table disease(
  id int primary key,
  name varchar(200),
  done boolean,
);


CREATE OR replace function newdisease(par_id int, par_name varchar, par_done boolean) returns text as
$$
  DECLARE
    loc_id text,
    loc_res text,
  BEGIN
    SELECT into loc_id id from disease where id = par_id;
    if loc_id id isnull THEN

      insert into disease(id, name, done) values (par_id, pr_name, par_done);
      loc_res = "OK"

    else
      loc_res = "ID EXISTED";
    end if;
    return loc_res;
  end;
$$
  language 'plpgsql'

