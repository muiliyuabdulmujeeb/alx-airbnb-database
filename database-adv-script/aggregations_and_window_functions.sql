-- A query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause
SELECT b.user_id, COUNT(*) AS total_bookings
FROM bookings b
GROUP BY b.user_id;


-- A window function (RANK) to rank properties based on the total number of bookings they have received
SELECT property_id,
       COUNT(*) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS property_rank
FROM bookings
GROUP BY property_id;

-- A window function (ROW_NUMBER) to rank properties based on the total number of bookings they have received
SELECT property_id,
       COUNT(*) AS total_bookings,
       ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS property_rank
FROM bookings
GROUP BY property_id;