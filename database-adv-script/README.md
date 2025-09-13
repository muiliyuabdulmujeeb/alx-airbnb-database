## JOINS
In the joins_queries.sql, I wrote the following queries:

An INNER JOIN to retrieve all bookings and the respective users who made those bookings.

A LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

A FULL OUTER JOIN coupled with a LEFT JOIN to retrieve all users and all bookings and the respective booked properties, even if the user has no booking or a booking is not linked to a user.

## SUBQUERIES
In the subqueries.sql file, i wrote the following queries:
A query to find all properties where the average rating is greater than 4.0 using a subquery.

A correlated subquery to find users who have made more than 3 bookings.

## AGGREATION AND FUNCTION WINDOW
In the aggregations_and_windows.sql file I wrote the following queries:

A query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

Used a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.