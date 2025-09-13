# PARTITIONING

For previously created tables, it is not possible to partition them but there are two methods to make sure that the new table contains all the data from the old, depending on how much large the table is

### OPTION 1
**FOR LITTLE TABLES**
1. Rename the old table
2. Create a new table with the schema of the old and Set the partition constraints while creating the table(note that to enforce global uniqueness, composite primary key which consists of the initial pk and the partition by column must be used)
3. Create the child partitions from the new table
4. copy the data from the old table into the new table
5. drop the old table

### OPTION 2
**FOR LARGE TABLES THAT COPYING WOULD TAKE MUCH RESOURCES**
1. Rename the old table
2. Create a new table with the schema of the old and set the partition constraints while creating the table
3. Create the child partitions from the new table
4. Attach the old table as a partition of the new_table, if not possible, then any of the following can be done
   a. copy the old table into the new table by chunks (takes more time to complete)
   b. Parallelize the copyiny process(different sessions copying different chunk, this would be faster but takes more space)
5. Drop the old table

Since our table is small, I would use option 1

## PERFORMANCE TESTING
**BEFORE PARTITIONING**
**Query**: EXPLAIN ANALYZE SELECT *
FROM bookings
WHERE start_date >= '2025-09-01' AND start_date < '2025-10-01'
ORDER BY start_date ASC;

**OUTPUT**:
"Sort  (cost=1.19..1.19 rows=1 width=100) (actual time=0.087..0.088 rows=5 loops=1)"
"  Sort Key: start_date"
"  Sort Method: quicksort  Memory: 25kB"
"  ->  Seq Scan on bookings  (cost=0.00..1.18 rows=1 width=100) (actual time=0.053..0.058 rows=5 loops=1)"
"        Filter: ((start_date >= '2025-09-01'::date) AND (start_date < '2025-10-01'::date))"
"        Rows Removed by Filter: 7"
"Planning Time: 0.266 ms"
"Execution Time: 0.144 ms"

**AFTER PARTITIONING**
**Query**: EXPLAIN ANALYZE SELECT *
FROM bookings
WHERE start_date >= '2025-09-01' AND start_date < '2025-10-01'
ORDER BY start_date ASC;

**OUTPUT**:
"Sort  (cost=19.47..19.48 rows=3 width=100) (actual time=0.023..0.023 rows=5 loops=1)"
"  Sort Key: bookings.start_date"
"  Sort Method: quicksort  Memory: 25kB"
"  ->  Seq Scan on sept2025_bookings bookings  (cost=0.00..19.45 rows=3 width=100) (actual time=0.014..0.015 rows=5 loops=1)"
"        Filter: ((start_date >= '2025-09-01'::date) AND (start_date < '2025-10-01'::date))"
"Planning Time: 0.360 ms"
"Execution Time: 0.040 ms"

## OBSERVED IMPROVEMENTS

1. **SORT**: Before partitioning, Postgres estimated 1.19 units to find the first and all rows while it took 0.053 and 0.058 units to find the first and all rows respectively. After sorting, the estimated time by postgres shot up to 19.47 and 19.48 units to find the first and all for the same query while in actuality, it took lesser time than the time it took to run before partitioning which is 0.023 for both first and all.

2. **SEQ SCAN** Before partitioning, it took 0.053 to find the first row while it took 0.058 to find all rows in actual time but after partitioning, it took lesser time, 0.014 and 0.015 respectively. As for the estimated time by postgres, the before partitioning time is lesser than after partitioning.

3. **PLANNING AND EXECUTION TIME**: Before partitioning, the time was 0.266ms and 0.144ms but after partitioning, the time was 0.360ms and 0.040 ms forplanning and execution time respectively.
