# PERFORMANCE REPORT

## INITIAL QUERY
SELECT b.*, u.*, p.*, pay.*
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;

### INITIAL QUERY REPORT
"Hash Join  (cost=24.28..45.48 rows=780 width=2002) (actual time=0.171..0.182 rows=12 loops=1)"
"  Hash Cond: (pay.booking_id = b.booking_id)"
"  ->  Seq Scan on payments pay  (cost=0.00..17.80 rows=780 width=76) (actual time=0.029..0.031 rows=12 loops=1)"
"  ->  Hash  (cost=24.13..24.13 rows=12 width=1926) (actual time=0.122..0.124 rows=12 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 12kB"
"        ->  Hash Join  (cost=12.36..24.13 rows=12 width=1926) (actual time=0.098..0.110 rows=12 loops=1)"
"              Hash Cond: (p.property_id = b.property_id)"
"              ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=648) (actual time=0.013..0.015 rows=14 loops=1)"
"              ->  Hash  (cost=12.21..12.21 rows=12 width=1278) (actual time=0.070..0.071 rows=12 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 11kB"
"                    ->  Hash Join  (cost=1.27..12.21 rows=12 width=1278) (actual time=0.050..0.060 rows=12 loops=1)"
"                          Hash Cond: (u.user_id = b.user_id)"
"                          ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=1178) (actual time=0.012..0.013 rows=15 loops=1)"
"                          ->  Hash  (cost=1.12..1.12 rows=12 width=100) (actual time=0.022..0.022 rows=12 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                ->  Seq Scan on bookings b  (cost=0.00..1.12 rows=12 width=100) (actual time=0.009..0.011 rows=12 loops=1)"
"Planning Time: 0.440 ms"
"Execution Time: 0.268 ms"

## REFACTOR PLAN
1. Select only needed columns, not all
2. Indexes on the FKs

## REFACTORED QUERY
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;

### REFACTOR QUERY REPORT

"Hash Join  (cost=24.28..45.48 rows=780 width=1032) (actual time=0.150..0.166 rows=12 loops=1)"
"  Hash Cond: (pay.booking_id = b.booking_id)"
"  ->  Seq Scan on payments pay  (cost=0.00..17.80 rows=780 width=52) (actual time=0.025..0.027 rows=12 loops=1)"
"  ->  Hash  (cost=24.13..24.13 rows=12 width=996) (actual time=0.117..0.119 rows=12 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Hash Join  (cost=12.36..24.13 rows=12 width=996) (actual time=0.091..0.105 rows=12 loops=1)"
"              Hash Cond: (p.property_id = b.property_id)"
"              ->  Seq Scan on properties p  (cost=0.00..11.20 rows=120 width=552) (actual time=0.014..0.016 rows=14 loops=1)"
"              ->  Hash  (cost=12.21..12.21 rows=12 width=476) (actual time=0.071..0.072 rows=12 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                    ->  Hash Join  (cost=1.27..12.21 rows=12 width=476) (actual time=0.051..0.064 rows=12 loops=1)"
"                          Hash Cond: (u.user_id = b.user_id)"
"                          ->  Seq Scan on users u  (cost=0.00..10.60 rows=60 width=452) (actual time=0.012..0.014 rows=15 loops=1)"
"                          ->  Hash  (cost=1.12..1.12 rows=12 width=56) (actual time=0.032..0.032 rows=12 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"                                ->  Seq Scan on bookings b  (cost=0.00..1.12 rows=12 width=56) (actual time=0.014..0.018 rows=12 loops=1)"
"Planning Time: 0.796 ms"
"Execution Time: 0.261 ms"
