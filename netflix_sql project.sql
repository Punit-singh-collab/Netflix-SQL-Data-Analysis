-- netflix_db -project- 
-- creating my project database
-- queries left 2,4
create database if not exists  netflix_db;
use  netflix_db;
-- create the base table
cREATE TABLE
 netflix ( show_id VARCHAR(10) PRIMARY KEY,
 type VARCHAR(10),
 title VARCHAR(255),
 director VARCHAR(550),
 cast_members TEXT, 
 country VARCHAR(250),
 date_added VARCHAR(50),
 release_year INT,
 rating VARCHAR(20), 
 duration VARCHAR(20),
 listed_in VARCHAR(255),
 description TEXT );
 
 
 select  count(*)
 from netflix ;
 
 --  Count Movies vs TV Shows. 
 
 select type, count(*) as total_number
 from netflix
 group by type ;
 
 
 -- List all movies released in a specific year (e.g., 2020)
 select *
 from netflix
where type = 'movie' and release_year=2020;


--  Identify the longest movie on Netflix 
-- data type casting
select * , cast(substring(duration,1,instr(duration, ' ' )-1) as  unsigned) as duration_integer
from netflix
where type = 'movie'
order by duration_integer desc limit 1 ; 

/* subquary method */
SELECT *, substring(duration,1,instr(duration,' ')-1)
 FROM NETFLIX
 WHERE TYPE='Movie';
select *
from netflix where cast(substring(duration,1,instr(duration,' ')-1) as unsigned) =(SELECT max(cast(substring(duration,1,instr(duration,' ')-1) as unsigned)) as duration_int
 FROM NETFLIX
WHERE TYPE='Movie');


 -- List all TV shows with more than 5 seasons
 with my_cte as
 (select * , cast(substring(duration,1,instr(duration, ' ' )-1) as  unsigned) as duration_integer
from netflix
where type = 'TV Show' )
select*
from my_cte
where   duration_integer>5 ;

-- Find content added in the last 10 years.
select *
from netflix 
where str_to_date(date_added,'%M %d, %Y')>date_sub(curdate(),interval 10 year);

-- Find all movies/TV shows by director 'Delhiprasad Deenadayalan'.

select *
from netflix 
where trim( upper(director)) like '%DELHIPRASAD DEENADAYALAN%';

--  Find each year and the average numbers of content release in India, return top 5 years.

select release_year,  count(*) as total_release
from netflix 
where  trim( upper(country)) like '%INDIA%'
group by release_year 
order by total_release desc limit 5 ;

--  List all movies that are documentaries
select * 
from netflix limi 
where type = 'movie' and trim(upper(listed_in)) like '%DOCUMENTARIES%' ;

-- Find all content without a director.
select*
from netflix
where director = '';

-- Categorize content as 'Bad' if description contains 'kill'/'violence', else 'Good'. Count items

with my_cte as
(select *,
case when description like '%kill%' or description like '%violence%' then  'bad'else 'good' end as category
from netflix)
select category ,count(*)
from my_cte 
group by category ;

--  Find the most frequent rating for movies and TV shows.
with my_rank as
(select type , rating ,count(*),
dense_rank() over (partition by  type order by count(*)desc) as my_rank
from netflix
group by type  , rating 
order by  type,rating  )
select *
from my_rank where my_rank=1; 



-- Find how many movies actor 'Salman Khan' appeared in in the last 10 years.
-- run tis quary onlt on postgresql

select *
from netflix
where type = 'Movie'
and trim(upper(casting)) like '%SALMAN KHAN%'
and release_year>  extract(year from current_date)-10;


-- find the top 10 indian actors
-- run tis quary onlt on postgresql
select unnest(string_to_array(casting,', ')) as actors, count(*) as contant
from netflix 
where trim(upper(country)) like '%INDIA%'
group by actors
order by contant desc  LIMIT 10 ;


-- : Find the top 5 countries with the most content.
-- run tis quary onlt on postgresql
select unnest(string_to_array(country,', ')) as country_masterlistt, count(*) as content
from netflix 
group by country_masterlistt
order by content desc  LIMIT 5 ;

-- : Count the number of items in each genre.
-- run tis quary onlt on postgresql

select unnest(string_to_array(listed_in,', ')) as genre_masterlist, count(*) as content
from netflix 
group by genre_masterlist
order by content desc   ;
