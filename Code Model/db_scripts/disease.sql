create table disease(
  id int primary key,
  name varchar(200),
  done boolean,
);


create or delete replace function newdisease(par_id int, par_name varchar, par_done boolean) returns text as
$$
  declare
    loc_id text,
    loc_res text,
  begin
    select into loc_id id from disease where id = par_id;
    if loc_id id isnull then

      insert into disease(id, name, done) values (par_id, pr_name, par_done);
      loc_res = "New disease data is added."

    else
      loc_res = "ID EXISTED";
    end if;
    return loc_res;
  end;
$$
  language 'plpgsql'


