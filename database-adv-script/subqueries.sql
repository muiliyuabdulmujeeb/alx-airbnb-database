-- query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT p.*
FROM properties p
WHERE p.property_id
IN (SELECT r.property_id FROM reviews r GROUP BY property_id HAVING AVG(rating)> 4);


-- 
SELECT u.*
FROM users u
WHERE u.user_id
IN (SELECT b.user_id FROM bookings b GROUP BY user_id HAVING COUNT(user_id) > 3);