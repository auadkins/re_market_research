USE re_market_research;


-- combining data from both tables to create a master view for Tableau

DROP VIEW IF EXISTS re_market_research_master;

CREATE VIEW re_market_research_master AS
SELECT 
	r.region_id,
	r.size_rank,
	r.region,
	r.date,
	r.state_name,
	r.population,
	r.avg_rent_rate,
	h.avg_home_value,
	h.avg_price_per_sf,
	h.homes_sold,
	h.days_on_market,
	h.avg_sales_to_list
FROM rent_index_long r
JOIN home_sales h ON r.region_id = h.region_id AND r.date = h.date
ORDER BY r.size_rank;

SELECT *
FROM re_market_research_master;


-- checking largest population

SELECT 
	region,
	population
FROM rent_index_long
WHERE region <> 'United States' AND
DATE = '2022-12-01'
ORDER BY population DESC;


-- checking highest rent rate for 2022-12-01

SELECT
	region,
    avg_rent_rate
FROM rent_index_long
WHERE DATE = '2022-12-01'
ORDER BY avg_rent_rate DESC;


-- checking highest rent rate for 2016-01-01

SELECT
	region,
    avg_rent_rate
FROM rent_index_long
WHERE DATE = '2016-01-01'
ORDER BY avg_rent_rate DESC;


-- checking average home value for 2022-12-01

SELECT
	region,
    avg_home_value
FROM home_sales
WHERE DATE = '2022-12-01'
ORDER BY avg_home_value DESC;


-- checking average home value for 2016-01-01

SELECT
	region,
    avg_home_value
FROM home_sales
WHERE DATE = '2016-01-01' AND
avg_home_value <> '0'
ORDER BY avg_home_value DESC;


-- checking for highest price per square foot for 2022-12-01

SELECT
	region,
    avg_price_per_sf
FROM home_sales
WHERE DATE = '2022-12-01' AND
avg_price_per_sf <> '0'
ORDER BY avg_price_per_sf DESC;


-- checking for highest price per square foot for 2016-01-01

SELECT
	region,
    avg_price_per_sf
FROM home_sales
WHERE DATE = '2016-01-01' AND
avg_price_per_sf <> '0'
ORDER BY avg_price_per_sf DESC;


-- checking number of homes sold for 2022-12-01

SELECT
	region,
    homes_sold
FROM home_sales
WHERE DATE = '2022-12-01'
ORDER BY homes_sold DESC;


-- checking number of homes sold for 2016-01-01

SELECT
	region,
    homes_sold
FROM home_sales
WHERE DATE = '2016-01-01'
ORDER BY homes_sold DESC;


-- looking into rent rate to home value ration by region. this will be an important one for visualization
-- creating a view

DROP VIEW IF EXISTS rent_ratio_by_region;

CREATE VIEW rent_ration_by_region AS
SELECT
	r.region_id,
    r.size_rank,
    r.region,
    r.date,
    state_name,
    population,
    avg_rent_rate,
    avg_home_value,
    SUM(avg_rent_rate / avg_home_value) AS rent_ratio
FROM rent_index_long r
JOIN home_sales h ON r.region_id = h.region_id AND r.date = h.date
GROUP BY r.region_id, r.size_rank, r.region, r.date, state_name, population, avg_rent_rate, avg_home_value
ORDER BY size_rank;
    
