CREATE TABLE Schedule(
  id int primary key,
  date_time_year date,
  done boolean
);

create or replace newschedule(par_id int, par_date_time_year date, par_done BOOLEAN) return text as
$$
    declare
        loc_id TEXT;
        loc_res TEXT;
    begin
        select into loc_id id Schedule where id = par_id;

        if loc_id isnull then
            insert into Schedule(id, date_time_year, done) values (par_id, par_date_time_year, par_done);
            loc_res = 'OK';

        else
            loc_res = 'ID EXISTED';
        end if
        return loc_res
    end;
$$
    language 'plpgsql';