--no. 7
SELECT *
FROM teams
LIMIT 10;

--Non-world series winner with the most wins.
SELECT yearid,
	name, 	
	wswin,
	w as wins
FROM teams
WHERE wswin <> 'Y'
AND yearid >= 1970
GROUP BY yearid, wswin, name, w
ORDER BY wins desc
LIMIT 1;

--2001 Seattle Mariners, but the above only gave me N values. Now looking adding nulls
SELECT yearid,
	name, 	
	wswin,
	w as wins
FROM teams
WHERE wswin IS NULL
OR wswin like 'N'
AND yearid >= 1970
GROUP BY yearid, wswin, name, w
ORDER BY wins desc;
--Still the 2001 Seattle Mariners with 116 wins. 

--Select world series winners, order them by ascending wins,limit to 1.
SELECT yearid,
	name, 	
	wswin,
	w as wins
FROM teams
WHERE wswin = 'Y'
AND yearid >= 1970
GROUP BY yearid, wswin, name, w
ORDER BY wins
LIMIT 1;
/*Lowest wins for world series winener is 1981 LA Dodgers at 63 wins. Why?
"The 1981 Major League Baseball season had a players' strike, which lasted 
from June 12 to July 31, 1981, and split the season in two halves. The 
All-Star Game was originally to be played on July 14, but was cancelled 
due to the strike. It was then brought back and played on August 9, as a 
prelude to the second half of the season, which began the following day."*/

--Remove 1981 from calc
SELECT yearid,
	name, 	
	wswin,
	w as wins
FROM teams
WHERE wswin = 'Y'
AND yearid >= 1970
AND yearid <> 1981
GROUP BY yearid, wswin, name, w
ORDER BY wins;
--Lowest now is the 2006 St Louis Cardinals with 83 wins. 

--calculating years where most winning team was also world series winning team.
WITH wsw AS (SELECT DISTINCT(yearid) as year,
				name, 	
				wswin,
				w as wins
			FROM teams
			WHERE wswin = 'Y'
			AND yearid >= 1970
			GROUP BY yearid, wswin, name, w),
ranks AS (SELECT RANK () OVER (PARTITION BY yearid ORDER BY w desc) as wrank,
		name,
		w,
	    yearid
	  	FROM teams
	  WHERE yearid >= 1970),
maxers AS (SELECT yearid,
		   name, 
		   wrank, 
		   ranks.w as wins
		   FROM ranks
		   WHERE wrank = 1),
totals as (SELECT DISTINCT(wsw.year),
			maxers.name as max_winner,
			maxers.wins as max_wins,
			wsw.name as wswinner,
			wsw.wins as wswinner_wins
		FROM wsw INNER JOIN maxers ON wsw.year = maxers.yearid)
SELECT totals.year,
	totals.wswinner,
	wswinner_wins
FROM totals
WHERE totals.max_winner = totals.wswinner;

--12 years. 25.5% of 47 years. This is the best I could do for a query.
WITH wsw AS (SELECT DISTINCT(yearid) as year,
				name, 	
				wswin,
				w as wins
			FROM teams
			WHERE wswin = 'Y'
			AND yearid >= 1970
			GROUP BY yearid, wswin, name, w),
ranks AS (SELECT RANK () OVER (PARTITION BY yearid ORDER BY w desc) as wrank,
		name,
		w,
	    yearid
	  	FROM teams
	  WHERE yearid >= 1970),
maxers AS (SELECT yearid,
		   name, 
		   wrank, 
		   ranks.w as wins
		   FROM ranks
		   WHERE wrank = 1),
totals as (SELECT DISTINCT(wsw.year),
			maxers.name as max_winner,
			maxers.wins as max_wins,
			wsw.name as wswinner,
			wsw.wins as wswinner_wins
		FROM wsw INNER JOIN maxers ON wsw.year = maxers.yearid),
bigtime AS (SELECT totals.year,
				totals.wswinner,
				wswinner_wins
			FROM totals
			WHERE totals.max_winner = totals.wswinner)
SELECT COUNT(bigtime.year) as years_match,
	COUNT(wsw.year) as total_years, 
	COUNT(bigtime.year) * 100 / (SELECT COUNT(wsw.year) FROM wsw) as Percentage
FROM bigtime FULL JOIN wsw ON wsw.year = bigtime.year;
