select * from covid19_us_cases

-- 1. Which States contained the most amount of total cases overall
ALTER TABLE covid19_us_cases ALTER COLUMN total_cases TYPE float8;
select  "State", sum(total_cases) as sum_of_total_cases
from covid19_us_cases
group by "State"
order by sum_of_total_cases desc;
-- 2. which states contained the most amount of new cases in one day
ALTER TABLE covid19_us_cases ALTER COLUMN new_cases TYPE float8;
select "State", "Date", sum(new_cases) as sum_of_new_cases
from covid19_us_cases
group by "State", "Date"
order by sum_of_new_cases desc;

-- 3.  which states contains the least amount of total cases overall
ALTER TABLE covid19_us_cases ALTER COLUMN total_cases TYPE float8;
select "State", sum(total_cases) as sum_of_total_cases
from covid19_us_cases
group by "State"
order by sum_of_total_cases asc;

-- 4. which states contained the least amount of new cases in one day after 2021
ALTER TABLE covid19_us_cases ALTER COLUMN new_cases TYPE float8;
select "State", "Date", new_cases
from covid19_us_cases
where "Date" > '20201231`'and new_cases > 0
order by new_cases asc;

-- 5. what is the new cases to total cases percentage for each date in each state
ALTER TABLE covid19_us_cases ALTER COLUMN total_cases TYPE float8;
ALTER TABLE covid19_us_cases ALTER COLUMN new_cases TYPE float8;
select "State", "Date", total_cases, new_cases, 
	case
	when new_cases = 0 then NULL
	else (new_cases/total_cases) * 100
	end as new_to_total_cases_percentage_ratio
from covid19_us_cases

-- 6. what is the overall new cases to total cases percentage for each state 
ALTER TABLE covid19_us_cases ALTER COLUMN total_cases TYPE float8;
ALTER TABLE covid19_us_cases ALTER COLUMN new_cases TYPE float8;
select "State", sum(total_cases) sum_of_total_cases, sum(new_cases) sum_of_new_cases, 
	sum(new_cases)/sum(total_cases)*100 new_cases_to_total_cases_percentage_ratio
from covid19_us_cases
group by "State"
order by new_cases_to_total_cases_percentage_ratio desc;

-- 7. what is the average total cases per state
select "State", avg(total_cases) average_total_cases
from covid19_us_cases
group by "State"
order by average_total_cases desc;

--Adding Additional Year and Month column based on Date Columnn for Deeper Analysis

alter table covid19_us_cases
add "Year" int,
add "Month" int

update covid19_us_cases
set "Year" = date_part('month',  "Date")

update covid19_us_cases
set "Month" = date_part('month',  "Date")

-- 8. Which months had the most amount of new cases in 2020
select "Month", sum(new_cases)
from covid19_us_cases
where "Year" = '2020'
group by "Month"
order by sum(new_cases) desc;
-- 9. Which month had the most amount of new cases in 2021
select "Month", sum(new_cases)
from covid19_us_cases
where "Year" = '2021'
group by "Month"
order by sum(new_cases) desc;


-- 10. Which state had the most  new cases in month
select  "State", max(sum_new_cases) max_sum_new_cases
from (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases
	from covid19_us_cases 
	where "Year" = '2020'
	group by "State", "Year", "Month"
	) sum_covid_19_us_cases
group by "State"
order by max_sum_new_cases desc;

-- 11. Which state had the most  new cases in a month in 2021
select  "State", max(sum_new_cases) max_sum_new_cases
from (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases
	from covid19_us_cases 
	where "Year" = '2021'
	group by "State", "Year", "Month"
	) sum_covid_19_us_cases
group by "State"
order by max_sum_new_cases desc;

-- Which states had the most  new cases in a month in 2020
with cte_cases as (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases, row_number() over(partition by "State" order by sum(new_cases) desc) "row_number"
	from covid19_us_cases 
	where "Year" = '2020'
	group by "State", "Year", "Month"
 	order by  "sum_new_cases" desc
	)

select * 
from cte_cases
where "row_number" = 1

-- Which states had the most  new cases in a month in 2021
with cte_cases as (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases, row_number() over(partition by "State" order by sum(new_cases) desc) "row_number"
	from covid19_us_cases 
	where "Year" = '2021'
	group by "State", "Year", "Month"
 	order by "sum_new_cases" desc
	)
select * 
from cte_cases
where "row_number" = 1


-- Which states had the least  new cases in a month in 2020
with cte_cases as (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases, row_number() over(partition by "State" order by sum(new_cases) asc) "row_number"
	from covid19_us_cases 
	where "Year" = '2020'
	group by "State", "Year", "Month"
 	order by "State" asc, "sum_new_cases" asc
	)
	
select * 
from cte_cases
where "row_number" = 1
-- Which states had the least  new cases in a month in 2021
with cte_cases as (
	select "State", "Year", "Month", sum(new_cases) sum_new_cases, row_number() over(partition by "State" order by sum(new_cases) asc) "row_number"
	from covid19_us_cases 
	where "Year" = '2021'
	group by "State", "Year", "Month"
 	order by "sum_new_cases" asc
	)
	
select * 
from cte_cases
where "row_number" = 1


--What were the monthly averages for each month for each state in 2020(do not include averages that are 0)
with cte_cases as (
	select "State", "Year", "Month", avg(new_cases) avg_new_cases 
	from covid19_us_cases 
	where "Year" = '2020'
	group by "State", "Year", "Month"
	having avg(new_cases) > 0
 	order by "Month" asc
	)
	
select * 
from cte_cases

--What were the monthly averages for each month for each state in 2021
with cte_cases as (
	select "State", "Year", "Month", avg(new_cases) avg_new_cases 
	from covid19_us_cases 
	where "Year" = '2021'
	group by "State", "Year", "Month"
	having avg(new_cases) > 0
 	order by "Month" asc
	)
	
select * 
from cte_cases

--What was the monthly average for the United States in 2020(exclude months where the average is 0)
select "Year", "Month", avg(new_cases) avg_new_cases
from covid19_us_cases
where "Year" = 2020
group by "Year","Month"
having avg(new_cases) > 0
order by "Month" asc;

--What was the monthly average for the United States in 2021 so far (exclude months where the average is 0)
select "Year", "Month", avg(new_cases) avg_new_cases
from covid19_us_cases
where "Year" = 2021
group by "Year","Month"
having avg(new_cases) > 0
order by "Month" asc;


--What are the yearly averages for new cases for each State
select "Year", "State", avg(new_cases) avg_new_cases
from covid19_us_cases
group by "Year", "State"
order by "State" asc, "Year" asc;