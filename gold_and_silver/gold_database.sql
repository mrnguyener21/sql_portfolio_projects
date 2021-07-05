select * from gold;

--how much did the price of gold increase by 2020 along with the inflation rate;
select  min(gold_price) starting_gold_price,
        max(gold_price) current_gold_price,
        max(gold_price) - min(gold_price) total_increase_in_gold_price,
        concat(round((((max(gold_price) - min(gold_price)) / min(gold_price)) * 100):: numeric,2), '%') gold_price_inflation_rate
from gold;

-- how much did gold_price increase or decrease in price each year;
-- with cte_gold_price as (
--     select "id","year", gold_price previous_gold_price
--     from gold
--     where id != 1 
-- )

-- select * from cte_gold_price;

-- select  gold1."year", 
--         gold1.gold_price, 
--         gold2."year", 
--         gold2.gold_price previous_year_gold_price,
--         gold2.row_number() over(partition by "year") "row_number"
-- from gold gold1, gold gold2
-- where gold2.id != 1
-- alter table gold
-- add previous_year_gold_price float8;
--  update gold
--  set previous_year_gold_price = gold_price

--DELETE , REUPLOAD AND RECONNECT THE GOLD DATABASE
--LOOK INTO LAG FUNCTION AND FIX DATASET;

--what was the inflation rate of each year;


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

