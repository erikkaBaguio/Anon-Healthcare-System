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
