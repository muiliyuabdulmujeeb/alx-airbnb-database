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

-- Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hash1', '1234567890', 'guest'),
(uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hash2', '9876543210', 'host'),
(uuid_generate_v4(), 'Charlie', 'Brown', 'charlie@example.com', 'hash3', '5551234567', 'host'),
(uuid_generate_v4(), 'Diana', 'Prince', 'diana@example.com', 'hash4', '4445556666', 'guest'),
(uuid_generate_v4(), 'Ethan', 'Hunt', 'ethan@example.com', 'hash5', '7778889999', 'guest'),
(uuid_generate_v4(), 'Fiona', 'Davis', 'fiona@example.com', 'hash6', '2223334444', 'host'),
(uuid_generate_v4(), 'George', 'Miller', 'george@example.com', 'hash7', '1112223333', 'guest'),
(uuid_generate_v4(), 'Hannah', 'Taylor', 'hannah@example.com', 'hash8', '6667778888', 'guest'),
(uuid_generate_v4(), 'Ian', 'Wright', 'ian@example.com', 'hash9', '9998887777', 'host'),
(uuid_generate_v4(), 'Admin', 'User', 'admin@example.com', 'hash10', '0001112222', 'admin');

-- Insert sample properties (linked to hosts)
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
VALUES
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Seaside Villa', 'Beautiful villa by the sea', 'Miami, FL', 250),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'charlie@example.com'), 'City Apartment', 'Modern apartment downtown', 'New York, NY', 180),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'fiona@example.com'), 'Mountain Cabin', 'Cozy cabin with a view', 'Denver, CO', 150),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'ian@example.com'), 'Luxury Penthouse', 'High-end penthouse suite', 'Los Angeles, CA', 500),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'charlie@example.com'), 'Country House', 'Quiet house in the countryside', 'Austin, TX', 120),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'fiona@example.com'), 'Beach Bungalow', 'Rustic bungalow on the beach', 'San Diego, CA', 200),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Lake House', 'Charming lakefront property', 'Seattle, WA', 220),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'ian@example.com'), 'Ski Lodge', 'Spacious lodge for winter holidays', 'Aspen, CO', 350),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'fiona@example.com'), 'Studio Loft', 'Minimalist loft studio', 'Chicago, IL', 140),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Desert Retreat', 'Unique desert escape', 'Phoenix, AZ', 175);

-- Insert sample bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Seaside Villa'), (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-09-20', '2025-09-25', 1250, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='City Apartment'), (SELECT user_id FROM users WHERE email='diana@example.com'), '2025-10-05', '2025-10-10', 900, 'pending'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Mountain Cabin'), (SELECT user_id FROM users WHERE email='ethan@example.com'), '2025-11-01', '2025-11-05', 600, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Luxury Penthouse'), (SELECT user_id FROM users WHERE email='george@example.com'), '2025-12-01', '2025-12-03', 1000, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Country House'), (SELECT user_id FROM users WHERE email='hannah@example.com'), '2025-09-15', '2025-09-20', 600, 'canceled'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Beach Bungalow'), (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-09-25', '2025-09-30', 1000, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Lake House'), (SELECT user_id FROM users WHERE email='diana@example.com'), '2025-10-01', '2025-10-07', 1320, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Ski Lodge'), (SELECT user_id FROM users WHERE email='ethan@example.com'), '2025-11-15', '2025-11-20', 1750, 'pending'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Studio Loft'), (SELECT user_id FROM users WHERE email='george@example.com'), '2025-12-10', '2025-12-12', 280, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Desert Retreat'), (SELECT user_id FROM users WHERE email='hannah@example.com'), '2025-09-18', '2025-09-22', 700, 'confirmed');

-- Insert sample payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=1250 LIMIT 1), 1250, 'credit_card'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=900 LIMIT 1), 900, 'paypal'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=600 AND status='confirmed' LIMIT 1), 600, 'stripe'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=1000 AND status='confirmed' LIMIT 1), 1000, 'credit_card'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=600 AND status='canceled' LIMIT 1), 600, 'paypal'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=1000 AND status='confirmed' LIMIT 1), 1000, 'stripe'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=1320 LIMIT 1), 1320, 'credit_card'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=1750 LIMIT 1), 1750, 'paypal'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=280 LIMIT 1), 280, 'stripe'),
(uuid_generate_v4(), (SELECT booking_id FROM bookings WHERE total_price=700 LIMIT 1), 700, 'credit_card');

-- Insert sample reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Seaside Villa'), (SELECT user_id FROM users WHERE email='alice@example.com'), 5, 'Amazing stay!'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='City Apartment'), (SELECT user_id FROM users WHERE email='diana@example.com'), 4, 'Very convenient location.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Mountain Cabin'), (SELECT user_id FROM users WHERE email='ethan@example.com'), 5, 'Perfect for a getaway.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Luxury Penthouse'), (SELECT user_id FROM users WHERE email='george@example.com'), 5, 'Luxury at its best.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Country House'), (SELECT user_id FROM users WHERE email='hannah@example.com'), 3, 'Too quiet, but nice house.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Beach Bungalow'), (SELECT user_id FROM users WHERE email='alice@example.com'), 4, 'Loved the beach view.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Lake House'), (SELECT user_id FROM users WHERE email='diana@example.com'), 5, 'Very relaxing.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Ski Lodge'), (SELECT user_id FROM users WHERE email='ethan@example.com'), 4, 'Great for skiing.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Studio Loft'), (SELECT user_id FROM users WHERE email='george@example.com'), 3, 'Too small for my liking.'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE name='Desert Retreat'), (SELECT user_id FROM users WHERE email='hannah@example.com'), 4, 'Unique experience!');

-- Insert sample messages
INSERT INTO messages (message_id, sender_id, reciepient_id, message_body)
VALUES
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='alice@example.com'), (SELECT user_id FROM users WHERE email='bob@example.com'), 'Hi, is Seaside Villa available?'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='bob@example.com'), (SELECT user_id FROM users WHERE email='alice@example.com'), 'Yes, it is available in September.'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='diana@example.com'), (SELECT user_id FROM users WHERE email='charlie@example.com'), 'Can I check in early at City Apartment?'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='charlie@example.com'), (SELECT user_id FROM users WHERE email='diana@example.com'), 'Sure, early check-in is fine.'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='ethan@example.com'), (SELECT user_id FROM users WHERE email='fiona@example.com'), 'Does Mountain Cabin have WiFi?'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='fiona@example.com'), (SELECT user_id FROM users WHERE email='ethan@example.com'), 'Yes, it has WiFi.'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='george@example.com'), (SELECT user_id FROM users WHERE email='ian@example.com'), 'Is parking available at Luxury Penthouse?'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='ian@example.com'), (SELECT user_id FROM users WHERE email='george@example.com'), 'Yes, free parking is included.'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='hannah@example.com'), (SELECT user_id FROM users WHERE email='fiona@example.com'), 'Can I bring my pet to the Studio Loft?'),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='fiona@example.com'), (SELECT user_id FROM users WHERE email='hannah@example.com'), 'Sorry, pets are not allowed.');
