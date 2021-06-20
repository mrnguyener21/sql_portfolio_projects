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


