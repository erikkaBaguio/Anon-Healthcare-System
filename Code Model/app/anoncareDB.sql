create table User_info (
  user_id int primary key,
  fname text,
  lname text,
  mname text,
  role int,
  email text,
    is_authenticated boolean default True,
    is_active boolean default True,
    is_anonymous boolean default True,
    password text
);

-- [POST] - Add user info
-- insert into User_info values (2,'ako','ikaw','us',3, 'eb@gmail.com', TRUE, TRUE, TRUE, 'akogali');
  create or replace function newuserinfo(par_id serial8, par_fname text, par_mname text, par_lname text,
                                  par_email text, par_password text, par_role int, par_is_active boolean)
                                   returns text as
  $$
      declare
          loc_id text;
          loc_res text;

      begin
          select into loc_id id
          from UserInfo
          where id = par_id;

          if loc_id isnull then

              insert into UserInfo(id, fname, mname, lname, email, password, role, is_active) values
                   (par_id, par_fname, par_mname, par_lname, par_email, par_password, par_role, par_is_active);
              loc_res = 'OK';
          else
              loc_res = 'ID EXISTED';
          end if;
          return loc_res;
      end;
  $$
    language 'plpgsql';

-- [GET] Retrieve all the user info.
-- select get_all_users();
create or replace function get_all_users(out int, out text, out text, out text, out text, out text) returns setof record as
$$
	select user_id, fname, mname, lname, email, password from User_info;
$$
	language 'sql';

--[GET] Get a certain user.
--select get_user(1);
create function get_user(in par_id int, out int, out text, out text, out text, out text, out text) returns setof record as
$$
  select user_id, fname, mname, lname, email, password
  from User_info
  where  user_id = par_id;
$$
  language 'sql';


