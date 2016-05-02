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

------------------------------------------------------------ ASSESSMENT ------------------------------------------------------------
-- [POST] Create new assessment
-- select store_assessment(1,20130000, 37.1, 80, 19, '90/70', 48, 'complaint', 'history', 'medication1', 'diagnosis1','recommendation1', 1);
-- select store_assessment(2,20130001, 36.4, 70, 19, '100/80', 45, 'complaint', 'history', 'medication1', 'diagnosis1','recommendation1', 1);
CREATE OR REPLACE FUNCTION store_assessment(IN par_id                       INT,
                                          IN par_schoolID                 INT,
                                          IN par_temperature              FLOAT,
                                          IN par_pulse_rate               FLOAT,
                                          IN par_respiration_rate         INT,
                                          IN par_blood_pressure           TEXT,
                                          IN par_weight                   FLOAT,
                                          IN par_chiefcomplaint           TEXT,
                                          IN par_historyofpresentillness  TEXT,
                                          IN par_medicationstaken         TEXT,
                                          IN par_diagnosis                TEXT,
                                          IN par_recommendation           TEXT,
                                          IN par_attendingphysician       INT)
  RETURNS TEXT AS
$$
DECLARE
  loc_id1       INT;
  loc_id2       INT;
  loc_res       TEXT;
BEGIN
  SELECT INTO loc_id1 id
  FROM Assessment
  WHERE id = par_id;

  SELECT INTO loc_id2 id
  FROM Vital_signs
  WHERE id = par_id;

  IF loc_id1 ISNULL AND loc_id2 ISNULL
  THEN
    IF par_chiefcomplaint = '' OR
       par_chiefcomplaint ISNULL OR
       par_medicationstaken = '' OR
       par_medicationstaken ISNULL OR
       par_diagnosis = '' OR
       par_diagnosis ISNULL
    THEN
      loc_res = 'PLEASE FILL THE REQUIRE FIELDS';

    ELSE
        INSERT INTO Vital_signs(id, temperature, pulse_rate, respiration_rate, blood_pressure, weight)
        VALUES (par_id,par_temperature, par_pulse_rate, par_respiration_rate, par_blood_pressure, par_weight);

        INSERT INTO Assessment (id,school_id, vital_signsID, chiefcomplaint, historyofpresentillness,
                                medicationstaken, diagnosis, recommendation, attendingphysician)
        VALUES (par_id,par_schoolID, par_id, par_chiefcomplaint, par_historyofpresentillness, par_medicationstaken,
                par_diagnosis, par_recommendation, par_attendingphysician);

        loc_res = 'OK';

    END IF;
  ELSE
      loc_res = 'ID EXISTS';
  END IF;
  RETURN loc_res;

END;
$$
  LANGUAGE 'plpgsql';


--[GET] Retrieve assessment of a specific patient
--select show_assessment(20130000,1);
CREATE OR REPLACE FUNCTION show_assessment(IN par_schoolID INT,
                                           IN par_id INT,
                                           OUT INT,
                                           OUT TIMESTAMP,
                                           OUT INT,
                                           OUT INT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT INT,
                                           OUT BOOLEAN,
                                           OUT FLOAT,
                                           OUT FLOAT,
                                           OUT INT,
                                           OUT TEXT,
                                           OUT FLOAT,
                                           OUT TEXT,
                                           OUT TEXT)
  RETURNS SETOF RECORD AS
$$

select Assessment.*,
         Vital_signs.temperature,
         Vital_signs.pulse_rate,
         Vital_signs.respiration_rate,
         Vital_signs.blood_pressure,
         Vital_signs.weight,
         Userinfo.fname,
         Userinfo.lname
  FROM Assessment
  INNER JOIN Vital_signs ON (
    Assessment.vital_signsID = Vital_signs.id
    )
  INNER JOIN Userinfo ON (
    Assessment.attendingphysician = Userinfo.id
    )
  WHERE Assessment.id = par_id
  AND Assessment.school_id = par_schoolID

$$
  LANGUAGE 'sql';


-- [GET] Retrieve all assessment of a specific patient
--select show_allassessment(20130000);
CREATE OR REPLACE FUNCTION show_allassessment(IN par_schoolID INT,
                                           OUT INT,
                                           OUT TIMESTAMP,
                                           OUT INT,
                                           OUT INT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT TEXT,
                                           OUT INT,
                                           OUT BOOLEAN,
                                           OUT FLOAT,
                                           OUT FLOAT,
                                           OUT INT,
                                           OUT TEXT,
                                           OUT FLOAT,
                                           OUT TEXT,
                                           OUT TEXT)
  RETURNS SETOF RECORD AS
$$
  SELECT Assessment.*,
         Vital_signs.temperature,
         Vital_signs.pulse_rate,
         Vital_signs.respiration_rate,
         Vital_signs.blood_pressure,
         Vital_signs.weight,
         Userinfo.fname,
         Userinfo.lname
  FROM Assessment
  INNER JOIN Vital_signs ON (
    Assessment.vital_signsID = Vital_signs.id
    )
  INNER JOIN Userinfo ON (
    Assessment.attendingphysician = Userinfo.id
    )
  WHERE Assessment.school_id = par_schoolID
  ORDER BY id DESC;

$$
  LANGUAGE 'sql';


--[PUT] Update assessment of patient
--select update_assessment(1,20130000, 'medication1f', 'diagnosis11f','recommendation11', 1);
CREATE OR REPLACE FUNCTION update_assessment(IN par_id                 INT,
                                             IN par_schoolID           TEXT,
                                             IN par_medicationstaken   TEXT,
                                             IN par_diagnosis          TEXT,
                                             IN par_recommendation     TEXT,
                                             IN par_attendingphysician INT)
  RETURNS TEXT AS
$$
DECLARE
  loc_res TEXT;
BEGIN

  UPDATE Assessment
  SET
    diagnosis          = par_diagnosis,
    recommendation     = par_recommendation,
    attendingphysician = par_attendingphysician
  WHERE id = par_id
  AND school_id = par_schoolID;

  loc_res = 'Updated';
  RETURN loc_res;

END;
$$
  LANGUAGE 'plpgsql';

---------------------------------------------------------- END ASSESSMENT ----------------------------------------------------------
