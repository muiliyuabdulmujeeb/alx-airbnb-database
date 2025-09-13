-- Query ran before partitioning
EXPLAIN ANALYZE SELECT *
FROM bookings
WHERE start_date >= '2025-09-01' AND start_date < '2025-10-01'
ORDER BY start_date ASC;

-- Partitioning query
-- change the current table name
ALTER TABLE bookings RENAME TO old_bookings;

-- drop the current index table
DROP INDEX idx_bookings_booking_id;

-- create the new table with partition constraint
CREATE TABLE bookings (
	booking_id UUID NOT NULL,
	property_id UUID NOT NULL,
	user_id UUID NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	total_price DECIMAL NOT NULL,
	status booking_status NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY (booking_id, start_date),

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
)PARTITION BY RANGE (start_date);

-- create separate index for booking_id only for quick lookups
CREATE INDEX idx_bookings_booking_id ON bookings(booking_id);

-- create partition tables
CREATE TABLE jul2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');

CREATE TABLE aug2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');

CREATE TABLE sept2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');

CREATE TABLE oct2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');

CREATE TABLE nov2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');

CREATE TABLE dec2025_bookings PARTITION OF bookings
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

-- copy the old table into the new table
INSERT INTO bookings
SELECT * FROM old_bookings;

--drop the old table and all its constraints
DROP TABLE old_bookings CASCADE;


-- query ran after partitioning
EXPLAIN ANALYZE SELECT *
FROM bookings
WHERE start_date >= '2025-09-01' AND start_date < '2025-10-01'
ORDER BY start_date ASC;
