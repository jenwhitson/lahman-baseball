/*Question 1Find all players in the database who played at Vanderbilt University.
Create a list showing each player’s first and last names as well as the total salary
they earned in the major leagues. Sort this list in descending order by the total salary
earned. Which Vanderbilt player earned the most money in the majors?*/

Select DISTINCT(CONCAT(namefirst, ' ', namelast)) as player_name, Sum(salary) as total_majorleague_salary, sch.schoolname 
FROM people as p 
Left join salaries as s on p.playerid =s.playerid
left join collegeplaying as cp on p.playerid = cp.playerid
left join schools as sch on sch.schoolid = cp.schoolid
Where schoolname = 'Vanderbilt University'
and lgid is not null
Group by namefirst, namelast,schoolname
Order by total_majorleague_salary desc
--David Price was the highest paid Majorleage player with a salary of $245,553,888



