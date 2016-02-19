CREATE TABLE Schedule(
  id INT PRIMARY KEY,
  date_time_year DATE,
  done BOOLEAN
);

CREATE OR REPLACE FUNCTION newschedule(par_id INT, par_date_time_year DATE, par_done BOOLEAN) return TEXT as
$$
    DECLARE
        loc_id TEXT;
        loc_res TEXT;
    BEGIN
        SELECT INTO loc_id id Schedule where id = par_id;

        if loc_id isnull THEN
            INSERT INTO Schedule(id, date_time_year, done) VALUES (par_id, par_date_time_year, par_done);
            loc_res = 'OK';

        else
            loc_res = 'ID EXISTED';
        end if
        return loc_res
    END;
$$
    language 'plpgsql';