# Case Study 02: Investigating Metics Spikes

use project03;
# table 01 users
create table users (
user_id int not null,
created_at varchar(20),	
company_id int not null,
language varchar(20),	
activated_at varchar(20),
state varchar(20) );

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"

 into table users
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows;

select * from users;

alter table users add column temp_created_at datetime ;

 #  update users set temp_created_at = str_to_date(created_at, '%d-%m-%y %h:%i');   'yaha pr H = 24 hr format , h = 12 hr format , Y = for year' 
SET SQL_SAFE_UPDATES = 0;

UPDATE users SET temp_created_at = STR_TO_DATE(created_at,'%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 1;

alter table users drop created_at;
alter table users change column temp_created_at created_at datetime;



alter table users add column temp_activated_at datetime ;  #  update users set temp_created_at = str_to_date(created_at, '%d-%m-%y %h:%i');   'yaha pr H = 24 hr format , h = 12 hr format , Y = for year' 
SET SQL_SAFE_UPDATES = 0;

UPDATE users SET temp_activated_at = STR_TO_DATE(activated_at,'%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 1;

alter table users drop activated_at;
alter table users change column temp_activated_at activated_at datetime;




# table events
##user_id	occurred_at	event_type	event_name	location	device	user_type
drop table events ;
create table events (
user_id int not null,
occurred_at varchar(20),	
event_type varchar(50),
event_name varchar(50),	
location varchar(50),
device varchar(50),
user_type int  );

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"

 into table events
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows;

select * from events; 

alter table events add column temp_occured_at datetime ;  #  update users set temp_created_at = str_to_date(created_at, '%d-%m-%y %h:%i');   'yaha pr H = 24 hr format , h = 12 hr format , Y = for year' 
SET SQL_SAFE_UPDATES = 0;

UPDATE events SET temp_occured_at = STR_TO_DATE(occurred_at,'%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 1;

alter table events drop occurred_at;
alter table events change column temp_occured_at occurred_at datetime;



# table email_events
##user_id	occurred_at	action	user_type

drop table email_events ;
create table email_events (
user_id int not null,
occurred_at varchar(20),	
`action` varchar(50),
user_type int  );

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"

 into table email_events
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows;

select * from email_events; 

alter table email_events add column temp_occured_at datetime ;  #  update users set temp_created_at = str_to_date(created_at, '%d-%m-%y %h:%i');   'yaha pr H = 24 hr format , h = 12 hr format , Y = for year' 
SET SQL_SAFE_UPDATES = 0;

UPDATE email_events SET temp_occured_at = STR_TO_DATE(occurred_at,'%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 1;

alter table email_events drop occurred_at;
alter table email_events change column temp_occured_at occurred_at datetime;



select * from users;
select * from events;
select * from email_events;



# task 01  weekly engagment
SELECT 
    WEEK(occurred_at) AS week,
    COUNT(DISTINCT user_id) AS active_users
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY week
ORDER BY week;


# task 02

WITH `Monthly Users` AS (
SELECT 
  EXTRACT(MONTH FROM created_at) AS Month,
  COUNT(activated_at) AS Users
FROM 
  users
WHERE 
  activated_at IS NOT NULL
GROUP BY 
   EXTRACT(MONTH FROM created_at)  
   )
SELECT
   Month, Users,
   ROUND((Users - LAG(Users, 1) OVER (ORDER BY Month)) * 100.0 / 
	LAG(Users, 1) OVER (ORDER BY Month), 2) AS "Growth in %"
FROM
   `Monthly Users`
ORDER BY 
    Month;
    
# task 03
 
 SELECT 
    first AS "Week Numbers", 
    SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS "Week 0", 
    SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS "Week 1", 
    SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS "Week 2", 
    SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS "Week 3", 
    SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS "Week 4", 
    SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS "Week 5", 
    SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS "Week 6", 
    SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS "Week 7", 
    SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS "Week 8", 
    SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS "Week 9", 
    SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS "Week 10", 
    SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS "Week 11", 
    SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS "Week 12", 
    SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS "Week 13", 
    SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS "Week 14", 
    SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS "Week 15", 
    SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS "Week 16", 
    SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS "Week 17", 
    SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS "Week 18"
FROM (
    SELECT 
        m.user_id, m.login_week, n.first, 
        (m.login_week - first) AS week_number 
    FROM (
        SELECT 
            user_id, 
            EXTRACT(WEEK FROM occurred_at) AS login_week 
        FROM 
          events 
        GROUP BY 1, 2
    ) m
    JOIN (
        SELECT 
            user_id, 
            MIN(EXTRACT(WEEK FROM occurred_at)) AS first 
        FROM 
          events 
        GROUP BY 1
    ) n
    ON m.user_id = n.user_id
) sub 
GROUP BY first 
ORDER BY first;
 
 
 
 
# TASK 04
SELECT 
    CONCAT(YEAR(occurred_at),
            '-',
            LPAD(WEEK(occurred_at, 0), 2, '0')) AS `Year - week no.`,
    device,
    COUNT(DISTINCT user_id) AS active_users
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY CONCAT(YEAR(occurred_at),
        '-',
        LPAD(WEEK(occurred_at, 0), 2, '0')) , device
ORDER BY `Year - week no.` , device;


# task 05
SELECT 
    Week,
    ROUND((weekly_digest / total * 100), 2) AS 'Weekly Digest Rate',
    ROUND((email_opens / total * 100), 2) AS 'Email Open Rate',
    ROUND((email_clickthroughs / total * 100), 2) AS 'Email Clickthrough Rate',
    ROUND((reengagement_emails / total * 100), 2) AS 'Reengagement Email Rate'
FROM
    (SELECT 
        EXTRACT(WEEK FROM occurred_at) AS Week,
            COUNT(CASE
                WHEN action = 'sent_weekly_digest' THEN user_id
                ELSE NULL
            END) AS weekly_digest,
            COUNT(CASE
                WHEN action = 'email_open' THEN user_id
                ELSE NULL
            END) AS email_opens,
            COUNT(CASE
                WHEN action = 'email_clickthrough' THEN user_id
                ELSE NULL
            END) AS email_clickthroughs,
            COUNT(CASE
                WHEN action = 'sent_reengagement_email' THEN user_id
                ELSE NULL
            END) AS reengagement_emails,
            COUNT(user_id) AS total
    FROM
        email_events
    GROUP BY week) sub
GROUP BY week
ORDER BY week; 
