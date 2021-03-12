/*Question 6 Find the player who had the most success stealing bases in 2016, 
where success is measured as the percentage of stolen base attempts 
which are successful. (A stolen base attempt results either in a stolen base 
or being caught stealing.) Consider only players who attempted at least 20 stolen bases.*/

SELECT DISTINCT b.playerid, 
				CONCAT(p.namefirst,' ',p.namelast) AS player_name, 
				(b.sb) AS stolen_bases, 
				(b.cs) AS caught_stealing, 
				b.sb+b.cs AS sb_cs, 
				ROUND(CAST(float8 (b.sb/(b.sb+b.cs)::float*100) AS NUMERIC),2) AS successful_stolen_bases_percent
FROM batting AS b
LEFT JOIN people AS p 
ON b.playerid = p.playerid
WHERE b.yearid = '2016'
GROUP BY b.playerid, p.namefirst, p.namelast, b.sb, b.cs
HAVING SUM(b.sb+b.cs) >= 20
ORDER BY successful_stolen_bases_percent DESC
LIMIT 1;