/*no. 9: Which managers have won the TSN Manager of the Year award 
in both the National League (NL) and the American League (AL)? Give 
their full name and the teams that they were managing when they won 
the award.*/

WITH am AS (SELECT playerid, 
				yearid, 
				lgid,
				CONCAT(playerid, yearid) AS amid
			FROM awardsmanagers 
			WHERE awardid ilike '%tsn%'),
mid AS (SELECT CONCAT(playerid, yearid, teamid) as managerid, 
			CONCAT(playerid, yearid) AS amid,
			playerid,
			yearid,
			teamid,
			lgid
		FROM managers),
winner AS (SELECT DISTINCT am.playerid as playerid,
				CONCAT(people.namefirst, ' ', people.namelast) as name,
				am.yearid as yearid,
				am.lgid as league,
				am.amid as amid,
				mid.teamid as teamid,
				mid.managerid as managerid, 
				teams.name as team
			FROM am INNER JOIN mid ON am.amid = mid.amid
				INNER JOIN teams ON mid.teamid = teams.teamid
				INNER JOIN people ON am.playerid = people.playerid
			WHERE teams.yearid > 1980)
SELECT DISTINCT w1.name as name,
	w1.yearid as year1,
	w1.league as league1,
	w1.team as team1,
	w2.yearid as year2,
	w2.league as league2,
	w2.team as team2
FROM winner as w1 INNER JOIN winner as w2 ON w1.playerid = w2.playerid
WHERE w1.league = 'NL'
AND w2.league = 'AL'
ORDER BY year1;
