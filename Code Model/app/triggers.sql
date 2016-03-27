-- NOTIFICATIONS

-- TRIGGER (notification) - if new assessment is created, automatically create new notification
create or replace function notify() RETURNS trigger AS '

  BEGIN

    IF tg_op = ''INSERT'' THEN
      INSERT INTO Notification (assessment_id, doctor_id)
          VALUES (new.id, new.attendingphysician);
    RETURN new;

    END IF;

  END
  ' LANGUAGE plpgsql;

create TRIGGER notify_trigger AFTER INSERT ON Assessment FOR each ROW
EXECUTE PROCEDURE notify();

create or replace function notify_update() RETURNS trigger AS '

  BEGIN

    IF tg_op = ''UPDATE'' THEN
      INSERT INTO Notification (assessment_id, doctor_id)
          VALUES (old.id, new.attendingphysician);
    RETURN new;

    END IF;

  END
  ' LANGUAGE plpgsql;

create TRIGGER notify_update_trigger AFTER UPDATE ON Assessment FOR each ROW
EXECUTE PROCEDURE notify_update();