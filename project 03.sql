# Case Study 01 "Operation Analytics"
 use project03;
 
create table job_data (
ds varchar(50),
job_id int  not null,
actor_id int not null,	
event varchar(50) not null,	
language	varchar(50) not null,
time_spent	int not null,
org char(5) 
);



insert into job_data ( ds,	job_id,actor_id,	event,	language,	time_spent,	org)
values ('2020-11-30',	21,	1001,	'skip'	 ,  'English',	15,	'A' ),
('2020-11-30',	22,	1006,	'transfer',	'Arabic',	25,	'B'),
('2020-11-29',	23,	1003,	'decision',	'Persian',	20,	'C'),
('2020-11-28',	23,	1005,	'transfer',	'Persian',	22,  'D'),
('2020-11-28',	25,	1002,	'decision',	'Hindi'	,   11,  'B'),
('2020-11-27',	11,	1007,	'decision',	'French',   104, 'D'),
('2020-11-26',	23,	1004,	'skip'	 ,  'Persian',	56,	'A'),
('2020-11-25',	20,	1003,	'transfer',	'Italian',	45,	'C');

# select * from job_data;


#Task 01
SELECT 
  ds AS Dates,
  ROUND((COUNT(job_id)/SUM(time_spent))*3600) 
  AS `job review per Hour per Day`
FROM 
  job_data 
WHERE 
  ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY 
  ds
order by 
  Dates asc; 

#Task 02
SELECT 
    ROUND(COUNT(event)/SUM(time_spent),2)
    AS `Weekly Throughput`
FROM 
    job_data ; 

SELECT ds AS Dates,
    ROUND((COUNT(event)/SUM(time_spent)),2)
    AS `daily throughput`
FROM job_data 
GROUP BY ds
order by Dates ; 


select count(*) as total from job_data;

#Task 03
SELECT 
    language AS `Languages`,
    ROUND((COUNT(language) / total) * 100, 3)
    AS percentage
FROM 
    job_data
CROSS JOIN 
    (SELECT COUNT(*) AS total FROM job_data) sub
GROUP BY 
    language,total;
  
#Task 04
SELECT 
    actor_id, 
    COUNT(actor_id) as dublicate
from
    job_data
GROUP BY 
    actor_id 
HAVING 
    dublicate >1;


select * from job_data;