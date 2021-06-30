--what is the monthly death to cases percentage ratio for 2020 and 2021 for each state
with cte_cases_and_deaths as (
    select  covid19_us_cases."State" "State", 
            covid19_us_cases."Year" "Year",
            covid19_us_cases."Month" "Month", 
			covid19_us_cases.new_deaths,
			covid19_us_cases.new_case,
    from covid19_us_cases
    inner join covid19_us_deaths on covid19_us_cases."ID" = covid19_us_deaths."ID"
	group by covid19_us_cases."State", covid19_us_cases."Month", covid19_us_cases."Year"
    order by covid19_us_cases."ID"
)
select * from cte_cases;


-- select "State", "Month", "Year",
-- 		case
-- 		when new_cases = 0 then 0
-- 		else (new_deaths/total_cases) * 100
-- 		end as new_to_total_deaths_percentage_ratio
-- from cte_cases_and_deaths
-- group by "State", "Month", "Year"
-- order by "State", "Month","Year";