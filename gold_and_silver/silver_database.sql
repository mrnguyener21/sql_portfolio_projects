select * from silver;

--how much did the price of silver increase by 2020 along with the inflation rate;
select  min(silver_price) starting_silver_price,
        max(silver_price) current_silver_price,
        round((max(silver_price) - min(silver_price)):: numeric,2) total_increase_in_silver_price,
        concat(round((((max(silver_price) - min(silver_price)) / min(silver_price)) * 100):: numeric,2), '%') silver_price_inflation_rate
from silver;

-- how much did silver_price increase or decrease in price each year along with the inflation rate for each year
with cte_silver as(
    select "year" current_year,
            silver_price current_silver_price,
            lag(year) over (order by "year") previous_year,
            lag(silver_price) over (order by "year") previous_year_silver_price
    from silver
)
select current_year,
        current_silver_price,
        previous_year,
        previous_year_silver_price,
        round((current_silver_price - previous_year_silver_price):: numeric,2) silver_price_difference,
        concat(round((((current_silver_price - previous_year_silver_price)/previous_year_silver_price)*100):: numeric,2),'%') inflation_rate_percentage
from cte_silver;

--How much did the price of silver increase for each century along with the inflation rate
select  "century",
        max(silver_price) - min(silver_price) total_increase_in_silver_price,
        concat(round((((max(silver_price) - min(silver_price)) / min(silver_price)) * 100):: numeric,2), '%') silver_price_inflation_rate
from silver
group by "century"
order by "century";


--What was the average price of silver for each century;
select "century", avg(silver_price) average_silver_price
from silver
group by "century"
order by "century";

--what is the overal average price of silver;
select round(avg(silver_price)::numeric,2) overall_average_price_of_silver
from silver;

