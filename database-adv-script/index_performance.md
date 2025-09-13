##

### QUERY 1

SELECT b.booking_id, b.property_id, u.first_name, u.last_name, b.start_date, b.end_date, b.total_price, b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id;

#### BEFORE INDEXING

"Hash Join  (cost=11.35..29.34 rows=630 width=512) (actual time=0.043..0.048 rows=12 loops=1)"
"  Hash Cond: (b.user_id = u.user_id)"
"  ->  Seq Scan on bookings b  (cost=0.00..16.30 rows=630 width=92) (actual time=0.013..0.014 rows=12 loops=1)"
"  ->  Hash  (cost=10.60..10.60 rows=60 width=452) (actual time=0.016..0.016 rows=15 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=452) (actual time=0.008..0.010 rows=15 loops=1)"
"Planning Time: 0.258 ms"
"Execution Time: 0.076 ms"

#### AFTER INDEXING

"Hash Join  (cost=1.27..12.21 rows=12 width=512) (actual time=0.034..0.041 rows=12 loops=1)"
"  Hash Cond: (u.user_id = b.user_id)"
"  ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=452) (actual time=0.012..0.013 rows=15 loops=1)"
"  ->  Hash  (cost=1.12..1.12 rows=12 width=92) (actual time=0.014..0.014 rows=12 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Seq Scan on bookings b  (cost=0.00..1.12 rows=12 width=92) (actual time=0.007..0.010 rows=12 loops=1)"
"Planning Time: 0.396 ms"
"Execution Time: 0.066 ms"


### QUERY 2

SELECT p.property_id, p.name, p.description, p.location, p.price_per_night, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id

#### BEFORE INDEXING

"Hash Right Join  (cost=12.70..31.32 rows=680 width=652) (actual time=0.061..0.077 rows=14 loops=1)"
"  Hash Cond: (r.property_id = p.property_id)"
"  ->  Seq Scan on reviews r  (cost=0.00..16.80 rows=680 width=52) (actual time=0.010..0.011 rows=12 loops=1)"
"  ->  Hash  (cost=11.20..11.20 rows=120 width=616) (actual time=0.041..0.041 rows=14 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=616) (actual time=0.027..0.031 rows=14 loops=1)"
"Planning Time: 0.212 ms"
"Execution Time: 0.117 ms"

#### AFTER INDEXING

"Hash Left Join  (cost=1.27..13.04 rows=120 width=652) (actual time=0.026..0.034 rows=14 loops=1)"
"  Hash Cond: (p.property_id = r.property_id)"
"  ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=616) (actual time=0.010..0.011 rows=14 loops=1)"
"  ->  Hash  (cost=1.12..1.12 rows=12 width=52) (actual time=0.012..0.012 rows=12 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        ->  Seq Scan on reviews r  (cost=0.00..1.12 rows=12 width=52) (actual time=0.005..0.008 rows=12 loops=1)"
"Planning Time: 0.342 ms"
"Execution Time: 0.050 ms"

### QUERY 3

SELECT u.first_name, u.last_name, p.name, p. description, p.location, p.price_per_night, b.start_date, b.end_date, b.total_price, b.status
FROM users u
FULL JOIN bookings b on u.user_id = b.user_id
LEFT JOIN properties p on b.property_id = p.property_id;

#### BEFORE INDEXING

"Hash Left Join  (cost=13.97..25.07 rows=60 width=1080) (actual time=0.055..0.070 rows=20 loops=1)"
"  Hash Cond: (b.property_id = p.property_id)"
"  ->  Hash Full Join  (cost=1.27..12.21 rows=60 width=496) (actual time=0.033..0.043 rows=20 loops=1)"
"        Hash Cond: (u.user_id = b.user_id)"
"        ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=452) (actual time=0.006..0.007 rows=15 loops=1)"
"        ->  Hash  (cost=1.12..1.12 rows=12 width=76) (actual time=0.019..0.019 rows=12 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              ->  Seq Scan on bookings b  (cost=0.00..1.12 rows=12 width=76) (actual time=0.012..0.014 rows=12 loops=1)"
"  ->  Hash  (cost=11.20..11.20 rows=120 width=616) (actual time=0.014..0.015 rows=14 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=616) (actual time=0.006..0.009 rows=14 loops=1)"
"Planning Time: 0.311 ms"
"Execution Time: 0.101 ms"

#### AFTER INDEXING

"  ->  Hash Full Join  (cost=1.27..12.21 rows=60 width=496) (actual time=0.043..0.055 rows=20 loops=1)"
"        Hash Cond: (u.user_id = b.user_id)"
"        ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=452) (actual time=0.007..0.008 rows=15 loops=1)"
"        ->  Hash  (cost=1.12..1.12 rows=12 width=76) (actual time=0.025..0.025 rows=12 loops=1)"
"              Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"              ->  Seq Scan on bookings b  (cost=0.00..1.12 rows=12 width=76) (actual time=0.015..0.017 rows=12 loops=1)"
"  ->  Hash  (cost=11.20..11.20 rows=120 width=616) (actual time=0.021..0.021 rows=14 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=616) (actual time=0.006..0.009 rows=14 loops=1)"
"Planning Time: 0.206 ms"
"Execution Time: 0.127 ms"



