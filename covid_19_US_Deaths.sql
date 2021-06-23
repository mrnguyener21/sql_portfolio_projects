
--Adding Additional Year and Month column based on Date Columnn for Deeper Analysis
alter table covid19_us_deaths
add "Year" int,
add "Month" int

update covid19_us_deaths
set "Year" = date_part('month',  "Date")

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
--which states contains the least amount of total deaths overall


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



