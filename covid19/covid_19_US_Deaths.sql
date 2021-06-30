
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
--which states contained the least amount of new deaths in one day after 2021
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



--what is the new deaths to total deaths percentage for each month in each state(exclude rates that are 0)
with cte_deaths as (
	select "Month","Year","State",
		max(total_deaths) max_total_deaths, 
		sum(new_deaths) sum_new_deaths,
		(sum(new_deaths)/max(total_deaths)) * 100 as new_to_total_deaths_percentage_ratio
	from covid19_us_deaths
	group by "Month", "Year", "State"
	having sum(new_deaths) != 0
	order by "Month" asc, "State" asc, "Year" desc
)
select *
from cte_deaths

--what is the average total deaths per state
select "State", avg(total_deaths)
from covid19_us_deaths
group by "State"
order by "State"


-- which months had the most amount of new deaths in 2020
select "Month", "Year", sum(new_deaths) sum_new_deaths
from covid19_us_deaths
where "Year" = 2020
group by "Month","Year"
order by sum_new_deaths desc

-- which month had the most amount of new deaths in 2021
select "Month", "Year", sum(new_deaths) sum_new_deaths
from covid19_us_deaths
where "Year" = 2020
group by "Month","Year"
order by sum_new_deaths desc

-- Which month had the most new deaths for each state
with cte_deaths as (
	select "State","Month", "Year", sum(new_deaths) sum_new_deaths, row_number() over(partition by "State" order by sum(new_deaths) desc) "row_number"
	from covid19_us_deaths
	group by "State", "Month", "Year"
	order by "State", sum_new_deaths desc
)
select "State", "Month", "Year", sum_new_deaths
from cte_deaths
where "row_number" = 1 or "row_number" = 2
order by "State",sum_new_deaths


--What were the monthly average of new deaths for each month for each state in 2020
select "State", "Month", "Year", avg(new_deaths) average_new_deaths
from covid19_us_deaths
where "Year" = 2020
group by "State", "Month", "Year"
order by "State", "Month"

--What were the monthly average of new deaths for each month for each state in 2021 
select "State", "Month", "Year", avg(new_deaths) average_new_deaths
from covid19_us_deaths
where "Year" = 2021
group by "State", "Month", "Year"
order by "State", "Month"

--What was the monthly average for the United States in 2020
select "Month", "Year", avg(new_deaths) average_new_deaths
from covid19_us_deaths
group by "Month", "Year"
order by "Month"


--What are the yearly averages for new deaths for each State
select "State", "Year", avg(new_deaths) average_new_deaths
from covid19_us_deaths
group by "State", "Year"
order by "State"



