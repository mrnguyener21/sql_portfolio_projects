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

--What is the death to cases percentage ratio in 2020 and 2021
with cte_cases_and_deaths as (
    select  covid19_us_cases."State" "State", 
            covid19_us_cases."Date" "Date", 
            covid19_us_cases."Year" "Year",
            covid19_us_cases."Month" "Month", 
            covid19_us_cases.total_cases, 
            covid19_us_cases.new_cases, 
            covid19_us_deaths.total_deaths, 
            covid19_us_deaths.new_deaths
    from covid19_us_cases
    inner join covid19_us_deaths on covid19_us_cases."ID" = covid19_us_deaths."ID"
    order by covid19_us_cases."ID"
)

select "Year", (max(total_deaths)/max(total_cases))*100 total_death_to_total_cases_percentage_ratio
from cte_cases_and_deaths
group by "Year"
order by "Year"


--what is the monthly death to cases percentage ratio for 2020 and 2021
with cte_cases_and_deaths as (
    select  covid19_us_cases."State" "State", 
            covid19_us_cases."Date" "Date", 
            covid19_us_cases."Year" "Year",
            covid19_us_cases."Month" "Month", 
            covid19_us_cases.total_cases, 
            covid19_us_cases.new_cases, 
            covid19_us_deaths.total_deaths, 
            covid19_us_deaths.new_deaths
    from covid19_us_cases
    inner join covid19_us_deaths on covid19_us_cases."ID" = covid19_us_deaths."ID"
    order by covid19_us_cases."ID"
)

select "Month", "Year",(sum(new_deaths)/sum(new_cases)) * 100 monthly_total_deaths_to_total_cases_percentage_ratio
from cte_cases_and_deaths
group by "Month", "Year"
order by "Month","Year"
--what is the monthly death to cases percentage ratio for 2020 and 2021 for each state
with cte_cases_and_deaths as (
    select  covid19_us_cases."State" "State", 
            covid19_us_cases."Year" "Year",
            covid19_us_cases."Month" "Month", 
			case
				when covid19_us_cases.new_cases = 0 then 0
				else (sum(covid19_us_deaths.new_deaths)/sum(covid19_us_cases.new_cases)) * 100
				end as new_to_total_deaths_percentage_ratio
    from covid19_us_cases
    inner join covid19_us_deaths on covid19_us_cases."ID" = covid19_us_deaths."ID"
	group by covid19_us_cases."State", covid19_us_cases."Month", covid19_us_cases."Year"
    order by covid19_us_cases."ID"
)
select * from cte_cases


select "State", "Month", "Year",
		case
		when new_cases = 0 then 0
		else (new_deaths/total_cases) * 100
		end as new_to_total_deaths_percentage_ratio
from cte_cases_and_deaths
group by "State", "Month", "Year"
order by "State", "Month","Year"