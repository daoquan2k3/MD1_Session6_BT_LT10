CREATE TABLE ss6_lt10.oldcustomers (
    id serial primary key ,
    name varchar(100),
    city varchar(50)
);

create table ss6_lt10.newcustomers (
    id serial primary key ,
    name varchar(100),
    city varchar(50)
);

--1
SELECT name, city FROM ss6_lt10.oldcustomers
UNION
SELECT name, city FROM ss6_lt10.newcustomers;

--2
SELECT name, city FROM ss6_lt10.oldcustomers
INTERSECT
SELECT name, city FROM ss6_lt10.newcustomers;

--3
SELECT city, COUNT(*) AS customer_count
FROM (
         SELECT city FROM ss6_lt10.oldcustomers
         UNION
         SELECT city FROM ss6_lt10.newcustomers
     ) all_customers
GROUP BY city;

--4
SELECT city, COUNT(*) AS cnt
FROM (
    SELECT city FROM ss6_lt10.oldcustomers
    UNION
    SELECT city FROM ss6_lt10.newcustomers
    ) all_cust
GROUP BY city
HAVING COUNT(*) = (
    SELECT MAX(c) FROM (
        SELECT COUNT(*) AS c
        FROM (
            SELECT city FROM ss6_lt10.oldcustomers
            UNION SELECT city FROM ss6_lt10.newcustomers
        ) x
        GROUP BY city
    ) m
);