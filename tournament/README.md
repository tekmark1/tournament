Content of "tournament":

 - tournament.sql:
 	- contains the statements which will be used by vagrant/psql to create tables and views.

 - tournament.py:
 	- this python file contains the import to psycopg2 command as well as the connection to the psql "tournament" database.
 	- within this file are the statements (which are connected to the database via python psycopg2) needed to delete/add to/extract from the tournament database in order to create a successful tournament app.

 - tournament_test.py:
 	- this python file runs the functions created in tournament.py
 	- this file also tests the functions created in tournament.py and throws an error if any of those functions do not return the intended output.

Running "tournament":

 1. Navigate to vagrant/tournament in commandline
 2. Run vagrant (vagrant up and then vagrant ssh)
 3. Import tournament.sql (\i tournament.sql) to create database "tournament", as well as the tables and views in the "tournament" database
 4. Navigate back to /vagrant/tournament (\q) and run tournament_test.py (python tournamnet_test.py)