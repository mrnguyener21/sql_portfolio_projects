select * from gold;

--how much did the price of gold increase by 2020 along with the inflation rate;
select  min(gold_price) starting_gold_price,
        max(gold_price) current_gold_price,
        max(gold_price) - min(gold_price) total_increase_in_gold_price,
        concat(round((((max(gold_price) - min(gold_price)) / min(gold_price)) * 100):: numeric,2), '%') gold_price_inflation_rate
from gold;

-- how much did gold_price increase or decrease in price each year along with the inflation rate for each year
with cte_gold as(
    select "year" current_year,
            gold_price current_gold_price,
            lag(year) over (order by "year") previous_year,
            lag(gold_price) over (order by "year") previous_year_gold_price
    from gold
)
select current_year,
        current_gold_price,
        previous_year,
        previous_year_gold_price,
        round((current_gold_price - previous_year_gold_price):: numeric,2) gold_price_difference,
        concat(round((((current_gold_price - previous_year_gold_price)/previous_year_gold_price)*100):: numeric,2),'%') inflation_rate_percentage
from cte_gold;

--How much did the price of gold increase for each century along with the inflation rate
select  "century",
        max(gold_price) - min(gold_price) total_increase_in_gold_price,
        concat(round((((max(gold_price) - min(gold_price)) / min(gold_price)) * 100):: numeric,2), '%') gold_price_inflation_rate
from gold
group by "century"
order by "century";


--What was the average price of gold for each century;
select "century", avg(gold_price) average_gold_price
from gold
group by "century"
order by "century";

--what is the overal average price of gold;
select round(avg(gold_price)::numeric,2) overall_average_price_of_gold
from gold;

