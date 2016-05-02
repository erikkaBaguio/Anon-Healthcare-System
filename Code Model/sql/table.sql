CREATE TABLE Role (
  id       SERIAL8 PRIMARY KEY,
  rolename TEXT
);

CREATE TABLE Userinfo (
  id           SERIAL8 PRIMARY KEY,
  fname        TEXT        NOT NULL,
  mname        TEXT        NOT NULL,
  lname        TEXT        NOT NULL,
  email        TEXT        NOT NULL,
  username     TEXT UNIQUE NOT NULL,
  password     TEXT        NOT NULL,
  role_id      INT REFERENCES Role (id)
);

CREATE TABLE College (
  id           SERIAL8 PRIMARY KEY,
  college_name TEXT NOT NULL,
  is_active    BOOLEAN DEFAULT TRUE
);

CREATE TABLE Department (
  id              SERIAL8 PRIMARY KEY,
  department_name TEXT NOT NULL,
  college_id      INT REFERENCES College (id),
  is_active       BOOLEAN DEFAULT TRUE
);

CREATE TABLE Vital_signs (
  id               INT PRIMARY KEY,
  temperature      FLOAT,
  pulse_rate       FLOAT,
  respiration_rate INT,
  blood_pressure   TEXT,
  weight           FLOAT
);

CREATE TABLE Assessment (
  id                      INT PRIMARY KEY,
  assessment_date         TIMESTAMP DEFAULT 'now',
  school_id               INT REFERENCES Patient (school_id),
  vital_signsID           INT REFERENCES Vital_signs (id),
  chiefcomplaint          TEXT,
  historyofpresentillness TEXT,
  medicationstaken        TEXT,
  diagnosis               TEXT,
  recommendation          TEXT,
  attendingphysician      INT REFERENCES Userinfo (id),
  is_done                 BOOLEAN  DEFAULT FALSE
);