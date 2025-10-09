USE Homework_1;

SELECT * FROM architects;
SELECT * FROM interchanges;
SELECT * FROM Station_architects;
SELECT * FROM Stations;
SELECT * FROM Tunnels;

WITH 2_stations as (
	SELECT architect_id, COUNT(*) AS CNT
    FROM station_architects
    GROUP BY (architect_id)
    HAVING CNT > 1
)
SELECT s.station_id, s.station_name as 'Назва станції', s.depth_meters as 'Глибина станції', 
s.opening_year as 'Рік відкриття', t.line_name as 'На якій гілці', i.hub_name_2 as 'Пересадка на',
GROUP_CONCAT(a.architect_name SEPARATOR ', ') AS 'Архітектори станції'
FROM architects as a
JOIN 2_stations as s2 ON a.architect_id = s2.architect_id 
JOIN station_architects AS star ON a.architect_id = star.architect_id
JOIN stations as s ON s.station_id = star.station_id
JOIN Tunnels as t ON t.line_id = s.line_id
LEFT JOIN interchanges as i ON i.hub_name_1 = s.station_name
WHERE s.depth_meters > (
	SELECT AVG(depth_meters)
    FROM stations
)
GROUP BY s.station_name
ORDER BY s.opening_year                                                                                                                        