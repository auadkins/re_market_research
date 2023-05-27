CREATE DATABASE re_market_research;

USE re_market_research;


-- creating table for pre-cleaned rent data

DROP TABLE IF EXISTS rent_index_long;

CREATE TABLE rent_index_long
(
region_id INT,
size_rank INT,
region VARCHAR(100),
date DATE,
state_name VARCHAR(100),
population INT,
avg_rent_rate DECIMAL (10, 2)
);


-- testing to ensure all columns are present

SELECT *
FROM rent_index_long;


-- importing data into table

LOAD DATA INFILE 'rent_index_long.csv' INTO TABLE rent_index_long
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


-- testing to verify all data imported properly

SELECT *
FROM rent_index_long;


-- creating table for pre-cleaned home sales data

DROP TABLE IF EXISTS home_sales;

CREATE TABLE home_sales
(
region_id INT,
size_rank INT,
region VARCHAR(100),
date DATE,
avg_home_value INT,
avg_price_per_sf INT,
homes_sold INT,
days_on_market INT,
avg_sales_to_list DECIMAL (10, 2)
);


-- testing to ensure all columns are present

SELECT *
FROM home_sales;


-- importing data into table

LOAD DATA INFILE 'home_sales.csv' INTO TABLE home_sales
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


-- testing to verify all data imported properly

SELECT *
FROM home_sales;


SELECT
	SUM(population)
    FROM rent_index_long
    WHERE date = '2022-12-01' AND
    region <> 'United States';