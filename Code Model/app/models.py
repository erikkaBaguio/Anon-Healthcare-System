from sqlalchemy import create_engine
import os

class DBconn:
    def __init__(self):
<<<<<<< HEAD
        engine = create_engine("postgresql://anoncare:anoncare@127.0.0.1:5432/acdb")
=======
        engine = create_engine("postgresql://flask:flasker@127.0.0.1:5432/acdb")
>>>>>>> 038788590d75a2c0de89dea79e06e4a71b71f72f
        self.conn = engine.connect()
        self.trans = self.conn.begin()

    def getcursor(self):
        cursor = self.conn.connection.cursor()
        return cursor

    def dbcommit(self):
        self.trans.commit()
