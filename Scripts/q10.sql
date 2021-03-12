/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major 
leagues. Use whatever metric for success you like - number of players, number of games, salaries, world 
series wins, etc.*/
--Q.10 example by salaries 

with cs as (Select Distinct(CONCAT(namefirst, ' ', namelast)) as player_name, schoolname, 
						Sum(salary::int::money) 
						Over(partition by schoolname,CONCAT(namefirst, ' ', namelast)) as total_salaries 
						From schools as sch 
						Left Join collegeplaying as cp using (schoolid)
						Left join people as p using(playerid)
						Left Join salaries as s using(playerid)
						Where schoolstate = 'TN'
						and salary is not null
						and schoolname ='Vanderbilt University'
						Order by total_salaries desc)
Select schoolname, Sum(cs.total_salaries) as total_school_salaries
From schools as sch 
Left Join cs using (schoolid)
group by schoolname
order by total_school_salaries desc;


--Order by salary desc
--Group by schoolname, (CONCAT(namefirst, ' ', namelast)),  salary::int::money 


--Q.10 example by number of games 
--Q.10 example by world series wins 
--Q.10 example by number of players 


/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major 
leagues. Use whatever metric for success you like - number of players, number of games, salaries, world 
series wins, etc.*/
--Q.10 example by salaries 

Select distinct(schoolname), Sum(salary::int::money) Over(partition by schoolname) as total_salaries 
From schools as sch 
Left Join collegeplaying as cp using (schoolid)
Left join people as p using(playerid)
Left Join salaries as s using(playerid)
Where schoolstate = 'TN'
and salary is not null
Order by total_salaries desc

