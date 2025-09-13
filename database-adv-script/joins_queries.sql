
-- INNER JOIN query to retrieve all bookings and the respective users who made those bookings
SELECT b.booking_id, b.property_id, u.first_name, u.last_name, b.start_date, b.end_date, b.total_price, b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id;

-- LEFT JOIN query to retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id, p.name, p.description, p.location, p.price_per_night, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
ORDER BY r.rating DESC NULLS LAST;

-- FULL OUTER JOIN query to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT u.first_name, u.last_name, p.name, p. description, p.location, p.price_per_night, b.start_date, b.end_date, b.total_price, b.status
FROM users u
FULL JOIN bookings b on u.user_id = b.user_id
LEFT JOIN properties p on b.property_id = p.property_id;