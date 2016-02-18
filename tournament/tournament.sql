-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- drop any database that may exist which contains the tournament name
-- then create the tournament database and navigate to it
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament;

-- create playertracker table which holds registered players.
CREATE TABLE playertracker 
	(
		id SERIAL PRIMARY KEY, 
		name TEXT
	);

-- create matches table which holds the winner and loser as inputed by user.
CREATE TABLE matches 
	(
		matchid SERIAL PRIMARY KEY, 
		winner INTEGER REFERENCES playertracker(id), 
		loser INTEGER REFERENCES playertracker(id)
	);

-- create wintracker view which joins matches and playertracker tables to count wins for each player.
CREATE VIEW wintracker
AS 
	SELECT playertracker.id,
		playertracker.name,
		COUNT(matches.winner) AS wins
	FROM playertracker
		LEFT JOIN matches
			ON playertracker.id = matches.winner
	GROUP BY playertracker.id;

-- create matchtracker view which joins matches and playertracker tables to count the number of matches each player has played.
CREATE VIEW matchtracker 
AS 
	SELECT playertracker.id,
		playertracker.name, 
		COUNT(matches) AS matchesplayed
	FROM playertracker 
		LEFT JOIN matches 
			ON playertracker.id = matches.winner 
				OR playertracker.id = matches.loser 
	GROUP BY playertracker.id;

-- create standings view which joins wintracker and matchtracker to display a player's id, name, wins, and matches played.
-- this view is used to display player standings as well as to create new matchups based upon win totals.
CREATE VIEW standings 
AS
	SELECT wintracker.id, 
		wintracker.name, 
		wintracker.wins, 
		matchtracker.matchesplayed 
	FROM wintracker
		join matchtracker 
		ON wintracker.id = matchtracker.id;

