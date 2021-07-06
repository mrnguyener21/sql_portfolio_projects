select  gold.century,
        gold."year",
        gold.gold_price,
        silver.silver_price
from gold
left join silver on gold."year"::numeric = silver."year"::numeric;
