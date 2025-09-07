CREATE EXTENSION IF NOT EXISTS "pgcrypto";

INSERT INTO users(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
(gen_random_uuid(), 'Adekunle', 'cole', 'adekunle@email.com', 'hashed_adekunle', '+23481432432432', 'host', NOW()),
(gen_random_uuid(), 'Tobiloba', 'smith', 'tobiloba@email.com', 'hashed_tobiloba', '+2348012345678', 'guest', NOW()),
(gen_random_uuid(), 'Samson', 'johnson', 'samson@email.com', 'hashed_samson', '+2348098765432', 'guest', NOW()),
(gen_random_uuid(), 'Adewale', 'Ifechukwu', 'ifechukwu@email.com', 'hashed_adewale', '+23480000987009', 'admin', NOW()),
(gen_random_uuid(), 'Abdullahi', 'Adamu', 'adamu@email.com', 'hashed_abdullahi', '+2348111122234', 'host', NOW());

INSERT INTO properties(property_id, host_id, name, description, location, price_per_night, created_at, updated_at)
VALUES
(gen_random_uuid(), (SELECT user_id FROM users WHERE first_name = 'Adekunle'), 'Front water garden', '2-bedroom flat with fountain', 'Lagos, Nigeria', 45000, NOW(), NOW()),
(gen_random_uuid(), (SELECT user_id FROM users WHERE first_name = 'Abdullahi'), 'Inshallahu House', '3-bedroom flat in a serene estate', 'Kwara, Nigeria', 25000, NOW(), NOW()),
(gen_random_uuid(), (SELECT user_id FROM users WHERE first_name = 'Adekunle'), 'Lekki Beach House', ' Luxury 2-bedroom flat near the sea', 'Lagos, Nigeria', 80000, NOW(), NOW()),
(gen_random_uuid(), (SELECT user_id FROM users WHERE first_name = 'Adekunle'), 'Osun City Apartment', '2 bedroom flat with constant electricity', 'Osogbo, Nigeria', 20000, NOW(), NOW());

INSERT INTO bookings(booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
(gen_random_uuid(), (SELECT property_id FROM properties WHERE name = 'Osun City Apartment'), (SELECT user_id FROM users WHERE first_name = 'Tobiloba'), '01-07-2025', '08-07-2025', 140000, 'confirmed', NOW()),
(gen_random_uuid(), (SELECT property_id FROM properties WHERE name = 'Lekki Beach House'), (SELECT user_id FROM users WHERE first_name = 'Samson'), '03-09-2025', '06-09-2025', 240000, 'confirmed', NOW());

INSERT INTO payments(payment_id, booking_id, amount, payment_date, payment_method)
VALUES
(gen_random_uuid(), (SELECT booking_id FROM bookings WHERE total_price = 240000), 240000, '05-09-2025', 'stripe'),
(gen_random_uuid(), (SELECT booking_id FROM bookings WHERE total_price = 140000), 140000, '01-07-2025', 'paypal');

INSERT INTO reviews(review_id, property_id, user_id, rating, comment, created_at)
VALUES
(gen_random_uuid(), (SELECT property_id FROM properties WHERE name = 'Osun City Apartment'), (SELECT user_id FROM users WHERE first_name = 'Tobiloba'), 4, 'classy service provided', NOW()),
(gen_random_uuid(), (SELECT property_id FROM properties WHERE name = 'Lekki Beach House'), (SELECT user_id FROM users WHERE first_name = 'Samson'), 5, 'Everything screems quality', NOW());

