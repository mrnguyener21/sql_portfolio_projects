--Create the base join table we will be using to work on
select  covid19_us_cases."State", 
		covid19_us_cases."Date", 
		covid19_us_cases."Year",
		covid19_us_cases."Month", 
		covid19_us_cases.total_cases, 
		covid19_us_cases.new_cases, 
		covid19_us_deaths.total_deaths, 
		covid19_us_deaths.new_deaths
from covid19_us_cases
inner join covid19_us_deaths on covid19_us_cases."ID" = covid19_us_deaths."ID"
order by covid19_us_cases."ID"

--What is the death to cases ratio in 2020

--what is the death to cases ratio so far in 2021

--what is the monthly death to cases ratio for 2020 and 2021

--what is the monthly death to cases ratio for 2020 and 2021 for each state
