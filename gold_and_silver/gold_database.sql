--how much did the price of gold increase by 2020 along with the inflation rate;
select  min(gold_price) starting_gold_price,
        max(gold_price) current_gold_price,
        max(gold_price) - min(gold_price) total_increase_in_gold_price,
        concat(round((((max(gold_price) - min(gold_price)) / min(gold_price)) * 100):: numeric,2), '%') gold_price_inflation_rate
from gold;

--how much did gold go increase or decrease in price each year;


--what was growth rate of each year;


--what was the growth rate for each century;


--how much did the price of gold increase by 2020 in dollar and percentage amount;


--What was the average price of gold for each century;
select "century", avg(gold_price) average_gold_price
from gold
group by "century"
order by "century";

--what is the overal average price of gold;

