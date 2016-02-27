create table users (
	id int primary key,
	fname text,
	mname text,
	lname text,
	email text,
	password text,
	role int,
	is_active boolean
);

create or replace function newusers(par_fname text, par_mname text, par_lname text,
                                par_email text, par_password text, par_role int, par_is_active boolean)
                                 returns text as
$$
    declare
        loc_id text;
        loc_res text;

    begin

        insert into UserInfo(fname, mname, lname, email, password, role, is_active) values
          (par_fname, par_mname, par_lname, par_email, par_password, par_role, par_is_active);
          loc_res = 'OK';
        end if;
        return loc_res;

    end;
$$
  language 'plpgsql';

create or replace function getusers(out int, out text, out text, out text, out text, out int, out boolean)
                                            returns setof record as
$$
    select id, fname, mname, lname, email, role, is_active from users;
$$
  language 'sql';

create or replace function getuserbyid(par_id int, out text, out text, out text, out text,
                                                 out int, out boolean) returns setof record as
$$
    select fname, mname, lname, email, role, is_active from UserInfo where par_id = id;
$$
  language 'sql';

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

create or replace function getpassword(par_email text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password from users where email = par_email;
     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------