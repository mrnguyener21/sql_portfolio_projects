
--Adding Additional Year and Month column based on Date Columnn for Deeper Analysis
alter table covid19_us_deaths
add "Year" int,
add "Month" int

update covid19_us_deaths
set "Year" = date_part('"Year"',  "Date")

update covid19_us_deaths
set "Month" = date_part('month',  "Date")

select * from covid19_us_cases

--Which States contained the most amount of total deaths overall
select "State", max(total_deaths) max_total_deaths
from covid19_us_deaths
group by "State"
order by max_total_deaths desc;

--which states contained the most amount of new deaths in one day
with cte_deaths as (
	select "State", "Date", new_deaths, row_number() over(partition by "State" order by new_deaths desc) "row_number"
	from covid19_us_deaths
	order by "State" asc, new_deaths desc
)

select * from cte_deaths
where row_number = 1
order by new_deaths desc;

--which states contained the most amount of new deaths in one day in 2020
with cte_deaths as (
	select "State","Year", "Date", new_deaths, row_number() over(partition by "State" order by new_deaths desc) "row_number"
	from covid19_us_deaths
	where "Year" = 2020
	order by "State" asc, new_deaths desc
)

select * from cte_deaths
where row_number = 1
order by new_deaths desc;

--which states contained the most amount of new deaths in one day in 2021
with cte_deaths as (
	select "State","Year", "Date", new_deaths, row_number() over(partition by "State" order by new_deaths desc) "row_number"
	from covid19_us_deaths
	where "Year" = 2021
	order by "State" asc, new_deaths desc
)

select * from cte_deaths
where row_number = 1
order by new_deaths desc;

--what is the new deaths to total deaths percentage for each date in each state (exclude pecentage ratios that are 0)
ALTER TABLE covid19_us_deaths ALTER COLUMN total_deaths TYPE float8;
ALTER TABLE covid19_us_deaths ALTER COLUMN new_deaths TYPE float8;

with cte_deaths as(
	select "Date", "State", total_deaths, new_deaths,
	case
	when new_deaths = 0 then 0
	else (new_deaths/total_deaths) * 100
	end as new_to_total_deaths_percentage_ratio
from covid19_us_deaths
order by "Date" asc, "new_to_total_deaths_percentage_ratio" desc
)

select * 
from cte_deaths
where new_to_total_deaths_percentage_ratio != 0
order by "Date" asc, "new_to_total_deaths_percentage_ratio" desc

--which states contained the least amount of new deaths in one day after 2021


--what is the new deaths to total deaths percentage for each date in each state


--what is the overall new deaths to total deaths percentage for each state 


--what is the average total deaths per state



-- 8. Which months had the most amount of new deaths in 2020

-- 9. Which month had the most amount of new deaths in 2021


-- 10. Which state had the most  new deaths in month


-- 11. Which state had the most  new deaths in a month in 2021


-- Which states had the most  new deaths in a month in 2020


-- Which states had the most  new deaths in a month in 2021


-- Which states had the least  new deaths in a month in 2020

-- Which states had the least  new deaths in a month in 2021


--What were the monthly averages for each month for each state in 2020(do not include averages that are 0)


--What were the monthly averages for each month for each state in 2021


--What was the monthly average for the United States in 2020(exclude months where the average is 0)


--What was the monthly average for the United States in 2021 so far (exclude months where the average is 0)



--What are the yearly averages for new deaths for each State



