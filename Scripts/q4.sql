--No. 4
WITH posnames AS (SELECT fielding.playerid as playerid,
				  	CONCAT(namefirst, ' ', namelast) as name,
				  	CASE WHEN fielding.pos = 'P' THEN 'Battery'
						WHEN fielding.pos = 'C' THEN 'Battery'
						WHEN fielding.pos = 'OF' THEN 'Outfield'
						ELSE 'Infield' END as position_type
				FROM fielding INNER JOIN people ON people.playerid = fielding.playerid
				WHERE fielding.yearid = 2016)
SELECT posnames.position_type as positions2016,
	COUNT(posnames.position_type) as n_position_types
FROM posnames
GROUP BY posnames.position_type;

--confirming our numbers match the total number of players in 2016.
SELECT COUNT(playerid)
FROM fielding
WHERE yearid = 2016;
--yes, they do. 938+661+354=1953