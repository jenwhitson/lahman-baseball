--Tinkering
SELECT *
FROM people
WHERE namefirst = 'Eddie'
AND namelast = 'Gaedel';

SELECT *
FROM teams
WHERE teamid = 'SLA'

SELECT *
FROM appearances
WHERE playerid = 'gaedeed01'

--Question 2
SELECT ppl.namefirst, ppl.namelast, app.g_all AS games, t.name AS team
FROM people AS ppl
LEFT JOIN appearances AS app
ON ppl.playerid = app.playerid
RIGHT JOIN teams AS t
ON app.teamid = t.teamid
WHERE ppl.height IN (SELECT MIN(height) FROM people)
AND t.yearid = '1951';
--Eddie Gaedel is the shortest player for St. Louis Browns and played in one game.



