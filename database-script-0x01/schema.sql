CREATE Type user_role AS ENUM ('guest', 'host', 'admin');

CREATE TABLE users (
	user_id UUID PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	password_hash VARCHAR(200) NOT NULL,
	phone_number VARCHAR(30),
	role user_role NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_users_email ON users(email);
CREATE TABLE properties(
	property_id UUID PRIMARY KEY,
	host_id UUID NOT NULL,
	name VARCHAR(100) NOT NULL,
	description text NOT NULL,
	location VARCHAR(150) NOT NULL,
	price_per_night DECIMAL NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_properties_host_id
	FOREIGN KEY (host_id)
	REFERENCES users(user_id) 
	ON UPDATE CASCADE
	ON DELETE CASCADE	
);

CREATE INDEX idx_properties_property_id ON properties(property_id);

CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');

CREATE TABLE bookings (
	booking_id UUID PRIMARY KEY,
	property_id UUID NOT NULL,
	user_id UUID NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	total_price DECIMAL NOT NULL,
	status booking_status NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),

	CONSTRAINT fk_bookings_property_id
	FOREIGN KEY (property_id)
	REFERENCES properties(property_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT fk_bookings_user_id
	FOREIGN KEY (user_id)
	REFERENCES users(user_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');

CREATE TABLE payments (
	payment_id UUID PRIMARY KEY,
	booking_id UUID NOT NULL,
	amount DECIMAL NOT NULL,
	payment_date TIMESTAMP DEFAULT NOW(),
	payment_method payment_method NOT NULL,

	CONSTRAINT fk_payments_booking_id
	FOREIGN KEY (booking_id)
	REFERENCES bookings(booking_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE INDEX idx_payments_payment_id ON payments(payment_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

CREATE TABLE reviews(
	review_id UUID PRIMARY KEY,
	property_id UUID NOT NULL,
	user_id UUID NOT NULL,
	rating INTEGER CHECK(rating >=1 AND rating <= 5) NOT NULL,
	comment TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),


	CONSTRAINT fk_reviews_property_id
	FOREIGN KEY (property_id)
	REFERENCES properties(property_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT fk_reviews_user_id
	FOREIGN KEY (user_id)
	REFERENCES users(user_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE INDEX idx_reviews_review_id ON reviews(review_id);

CREATE TABLE messages (
	message_id UUID PRIMARY KEY,
	sender_id UUID NOT NULL,
	reciepient_id UUID NOT NULL,
	message_body TEXT NOT NULL,
	sent_at TIMESTAMP DEFAULT NOW(),

	CONSTRAINT fk_messages_sender_id
	FOREIGN KEY (sender_id)
	REFERENCES users(user_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	
	CONSTRAINT fk_messages_reciepient_id
	FOREIGN KEY (reciepient_id)
	REFERENCES users(user_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);