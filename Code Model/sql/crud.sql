--[POST] Insert role
--select store_role('admin');
CREATE OR REPLACE FUNCTION store_role(par_rolename TEXT)
  RETURNS TEXT AS
$$
DECLARE
  loc_name TEXT;
  loc_res  TEXT;
BEGIN

  SELECT INTO loc_name rolename
  FROM Role
  WHERE rolename = par_rolename;

  IF loc_name ISNULL
  THEN
    INSERT INTO Role (rolename) VALUES (par_rolename);
    loc_res = 'OK';

  ELSE
    loc_res = 'EXISTED';

  END IF;
  RETURN loc_res;
END;
$$
LANGUAGE 'plpgsql';


select store_role('admin');
select store_role('doctor');
select store_role('nurse');

--------------------------------------------------------------- USER ---------------------------------------------------------------
-- Check if user exists via username
-- return 'OK' if user does not exist
-- Otherwise, 'EXISTED'.
create or replace function check_username(in par_username text) returns text as
  $$ declare local_response text; local_id bigint;
    begin

      select into local_id id from Userinfo where username = par_username;

      if local_id isnull then
        local_response = 'OK';
      else
        local_response = 'EXISTED';

      end if;

      return local_response;

    end;
  $$
  language 'plpgsql';


-- Check if user exists via email
-- return 'OK' if user does not exist
-- Otherwise, 'EXISTED'.
create or replace function check_mail(in par_mail text) returns text as
  $$ declare local_response text; local_id bigint;
    begin

      select into local_id id from Userinfo where email = par_mail;

      if local_id isnull then
        local_response = 'OK';
      else
        local_response = 'EXISTED';

      end if;

      return local_response;

    end;
  $$
  language 'plpgsql';


-- [POST] Insert user
-- select store_user('remarc', 'espinosa', 'balisi', 'apps-user', 'admin', 'remarc.balisi@gmail.com', 2);
create or replace function store_user(in par_fname text, in par_mname text, in par_lname text, in par_username text, in par_password text, in par_email text, in par_role_id int8) returns text as
  $$ declare local_response text;
    begin

      insert into Userinfo(fname, mname, lname, username, password, email, role_id) values (par_fname, par_mname, par_lname, par_username, par_password, par_email, par_role_id);
      local_response = 'OK';
      return local_response;

    end;
  $$
  language 'plpgsql';


-- [GET] Get password of a specific user
--select get_password('apps-user');
create or replace function get_password(par_username text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password
     from Userinfo
     where username = par_username;

     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

------------------------------------------------------------- END USER -------------------------------------------------------------