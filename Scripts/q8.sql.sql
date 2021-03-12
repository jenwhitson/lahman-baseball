/*q.8 Using the attendance figures from the homegames table, find the teams and parks which had the
top 5 average attendance per game in 2016 (where average attendance is defined as total attendance
divided by number of games). Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance. Repeat for the lowest 5 average
attendance.*/

/*Select (Sum(hg.attendance)/(count(hg.attendance))) AS avg_attendance, p.park_name, team, count(hg.attendance) as number_of_games, year
From homegames as hg left join parks as p on hg.park =p.park
Group by p.park, team, span_first, 
--HAVING count(hg.attendance)
Order by avg_attendance desc
Limit 5;*/

-- pt 1.realized was going the wrong way starting over  

SELECT p.park_name, hg.park, team, sum(attendance)/games as avg_attendance
FROM homegames as hg
LEFT JOIN parks AS p ON hg.park =p.park
Where games >= 10
and year = 2016
group by park_name, team, attendance, games, year, hg.park
order by avg_attendance desc
Limit 5;
--q8. think I figured this out? top 5 teams and parks with highest avg attendance 

SELECT p.park_name, hg.park, team, sum(attendance)/games as avg_attendance
FROM homegames as hg
LEFT JOIN parks AS p ON hg.park =p.park
Where games >= 10
and year = 2016
group by park_name, team, attendance, games, year, hg.park
order by avg_attendance 
Limit 5;
--q8 bottom 5 avg attendance teams and parks


Select team, park, games, attendance, attendance/games
From homegames
Where year = 2016
order by attendance desc





