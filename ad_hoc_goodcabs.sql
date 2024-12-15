-- Ad Hoc Business Request

-- City level trip and Fare Report
USE trips_db;

SELECT dim_city.city_name, 
	COUNT(trip_id) AS total_trips,
	ROUND(SUM(fare_amount) / SUM(distance_travelled_km), 2) AS avg_fare_per_km,
	ROUND(AVG(fare_amount), 2) AS avg_fare_per_trip,
	ROUND((COUNT(trip_id) / SUM(COUNT(trip_id)) OVER() * 100), 2) AS `%_contribution_to_total_trips`
FROM fact_trips
JOIN dim_city
	ON dim_city.city_id = fact_trips.city_id
GROUP BY dim_city.city_id
ORDER BY total_trips;

-- Monthly city level trips target report

WITH actualCTE AS 
	(SELECT monthname(date) AS months, city_id, COUNT(*) actual_trips FROM fact_trips
GROUP BY months, city_id)

SELECT city_name, 
	months AS month_name, 
    actual_trips, 
    total_target_trips AS target_trips, 
    IF(actual_trips > total_target_trips, "Above Target", "Below Target")  AS performance_status,
    ROUND(-(1 - (actual_trips / total_target_trips)) * 100, 2) AS `%_difference`
FROM actualCTE
JOIN targets_db.monthly_target_trips target_trips
	ON monthname(target_trips.month) = actualCTE.months
	AND target_trips.city_id = actualCTE.city_id
JOIN dim_city 
	ON actualCTE.city_id = dim_city.city_id;
    
-- City Level Repeat passenger trip frequency Report

SELECT * FROM dim_repeat_trip_distribution;

WITH tripCTE AS (SELECT
    city_id, 
    trip_count, 
    SUM(repeat_passenger_count) AS repeat_passenger_count
FROM dim_repeat_trip_distribution
GROUP BY city_id , trip_count),

city_reportCTE AS (SELECT city_name, 
	trip_count, 
    ROUND((repeat_passenger_count / SUM(repeat_passenger_count) OVER(PARTITION BY city_name)) * 100, 2) AS total_count
FROM tripCTE
JOIN dim_city 
	ON tripCTE.city_id = dim_city.city_id)

SELECT city_name,
	SUM(CASE WHEN trip_count = '2-Trips' THEN total_count END) AS '2-Trips',
    SUM(CASE WHEN trip_count = '3-Trips' THEN total_count END) AS '3-Trips',
    SUM(CASE WHEN trip_count = '4-Trips' THEN total_count END) AS '4-Trips',
    SUM(CASE WHEN trip_count = '5-Trips' THEN total_count END) AS '5-Trips',
    SUM(CASE WHEN trip_count = '6-Trips' THEN total_count END) AS '6-Trips',
    SUM(CASE WHEN trip_count = '7-Trips' THEN total_count END) AS '7-Trips',
    SUM(CASE WHEN trip_count = '8-Trips' THEN total_count END) AS '8-Trips',
    SUM(CASE WHEN trip_count = '9-Trips' THEN total_count END) AS '9-Trips',
    SUM(CASE WHEN trip_count = '10-Trips' THEN total_count END) AS '10-Trips'
FROM city_reportCTE
GROUP BY city_name;


-- Identify the cities with the highest and lowest numbers of new passengers

SELECT 
    city_name, 
    SUM(new_passengers) total_new_passengers,
    CASE
		WHEN RANK() OVER(ORDER BY SUM(new_passengers) DESC) <= 3 THEN "Top 3"
        WHEN RANK() OVER(ORDER BY SUM(new_passengers) ASC) <= 3 THEN "Bottom 3"
        ELSE "Average"
	END AS city_category
FROM fact_passenger_summary
JOIN dim_city 
	ON fact_passenger_summary.city_id = dim_city.city_id
GROUP BY city_name
ORDER BY total_new_passengers DESC;

-- Identify Month with highest Revenue for each City

WITH revenueCTE AS (
SELECT 
    city_id, 
    MONTHNAME(date) AS months, 
    SUM(fare_amount) AS revenue,
    RANK() OVER(PARTITION BY city_id ORDER BY SUM(fare_amount) DESC) AS ranks
FROM fact_trips
GROUP BY city_id, months
ORDER BY city_id, months, revenue),

city_revenueCTE AS (SELECT *, SUM(revenue) OVER(PARTITION BY city_id) AS city_revenue FROM revenueCTE)

SELECT city_name, 
	months AS highest_revenue_month,
    revenue,
    ROUND((revenue / city_revenue) * 100, 2) AS percentage_contribution
FROM city_revenueCTE
JOIN dim_city
	ON dim_city.city_id = city_revenueCTE.city_id
WHERE ranks = 1;

-- Repeat passenger rate analysis


SELECT 
	city_name, 
    monthname(month) AS month_name, 
    SUM(total_passengers) total_passengers,
    SUM(repeat_passengers) repeat_passengers,
    ROUND((SUM(repeat_passengers) / SUM(total_passengers) * 100), 2) AS monthly_repeat_passenger_rate,
    ROUND((SUM(SUM(repeat_passengers)) OVER(PARTITION BY d.city_id) / SUM(SUM(total_passengers)) OVER(PARTITION BY d.city_id)) * 100, 2)  AS city_repeat_passenger_rate
FROM fact_passenger_summary
JOIN dim_city d
	ON d.city_id = fact_passenger_summary.city_id
GROUP BY d.city_id, month_name
ORDER BY d.city_id;



