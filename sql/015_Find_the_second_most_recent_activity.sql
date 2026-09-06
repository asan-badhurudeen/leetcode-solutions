/*
===============================================
Question: Find the second most recent activity, pick the recent if there only one activity
===============================================
*/


WITH base_query AS (
SELECT 
    username,
    activity,
    startDate,
    endDate
FROM problemsolving.complex.useractivity)

, Aggregation AS (
SELECT     
    username,
    activity,
    startDate,
    endDate,
    ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate DESC) rn,
    COUNT(*) OVER (PARTITION BY username) totalactivity
FROM base_query)

SELECT 
    username,
    activity,
    startDate,
    endDate,
    rn,
    totalactivity
FROM aggregation
WHERE CASE 
        WHEN totalactivity > 1 THEN rn = 2
        ELSE rn = 1
    END


/*
=====================
DDL
====================
*/

create table problemsolving.complex.UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into problemsolving.complex.UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');
