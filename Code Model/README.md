GUIDE IN SETTING UP THE APPLICATION (linux)


Install virtual environment

1. open fresh terminal

2. install virtualenv: pip install virtualenv

3. install virtualwrapper: pip install virtualenvwrapper

4. then add the workspace: export WORKON_HOME=~/Envs (just paste it in terminal xD)
	4.1 after: source /usr/local/bin/virtualenvwrapper.sh (just paste)

5. then run mkvirtualenv venv
	<-- this will make a virtual environment named "venv" in Envs folder.

6. then run workon venv
	<-- venv is now activated.
	<-- to deactivate: run deactivate
	<-- to delete the environment: run rmvirtualenv venv

7. run deactivate


starting the project

1. open fresh terminal
2. make virtual environment named anoncareenv: steps 4 and  5 in "install virtual environment"
3. work on newly created environment: workon anocareenv (anyway anoncareenv will automatically activated after performing step 2 above.)
4. anoncareenv is activated right? ( somethng like this -> (anoncareenv) setsuna@ELUCIDATOR:~$ )
5. change directory: Documents/flaskprojects/anoncare
6. inside anocare: git init
7. then, git remote add origin https://github.com/erikkaBaguio/Anon-Healthcare-System-.git
8. after adding the remote: git pull origin master
9. change directory to: Code Model
10. run chmod +x db.py
11. run python db.py db init
12. run python db.py db migrate
13. run python db.py db upgrade

NOTE: Make sure you have user/role: anoncare with password: anoncare and database table acdb in postgres. If you don't have then make one xD. Then set user(anoncare) privileges to CREATEDB CREATEROLE, this will let your user create database tables and also users/roles.

You can try running the application: python run.py

steps summary:
open fresh terminal
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
workon anoncareenv
cd to Documents/flaskprojects/anocare/Code Models
python run.py

why use virtualenv wrapper?
well, just to set virtual environment in a clean way! hahaha
but if you want, you can suggest another style for a better working env. thanks.

-bals