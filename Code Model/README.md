GUIDE IN SETTING UP THE APPLICATION (linux)


Install virtual environment

1. open fresh terminal

2. install virtualenv: pip install virtualenv

3. install virtualwrapper: pip install virtualenvwrapper

4. then add the workspace: export WORKON_HOME=~/Envs (just paste it in terminal xD)
	4.1 after export: source /usr/local/bin/virtualenvwrapper.sh (just paste)

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
