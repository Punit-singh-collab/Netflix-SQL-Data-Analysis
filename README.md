# Netflix-SQL-Data-Analysis
Netflix SQL Data Analysis
This project is a Netflix Catalog SQL Data Analysis script (netflix_sql project.sql) built around a netflix_db relational database and a single netflix catalog table. It explores catalog composition, release trends, content ratings, creator/cast/country breakdowns, and keyword-based description tagging.
Database & Schema OverviewDatabase & Table:
Creates netflix_db and defines the netflix table with show_id as the primary key alongside 11 descriptive fields (type, title, director, cast_members, country, date_added, release_year, rating, duration, listed_in, and description).
Multi-Dialect Approach: 
Most queries use MySQL functions (such as STR_TO_DATE, DATE_SUB, CURDATE, INSTR, and CAST(... AS UNSIGNED)),
while four later queries are marked for PostgreSQL using UNNEST(STRING_TO_ARRAY(...)) and EXTRACT(YEAR FROM CURRENT_DATE).
Key Analytical Areas CoveredCatalog Mix & Timelines:
Counts total titles, compares Movie vs.TV Show volume, filters movies by release year (such as 2020), and finds content added within the last 10 years.Duration & Season Filtering: Extracts numeric lengths from text duration strings to identify the longest movie and list TV shows with more than 5 seasons.People, Regions & Genres: Searches by director (such as Delhiprasad Deenadayalan), finds top release years for India, lists documentary movies, spots entries with blank director values, and—in the PostgreSQL section—splits comma-separated strings to rank top Indian actors, top countries, and genre counts.Ranking & Text Flagging: Uses a DENSE_RANK() window function to find the top rating per content type, and uses a CTE with CASE logic to label descriptions containing "kill" or "violence" as 'bad' versus 'good'.
Quick Polish Notes on the ScriptMinor Syntax/Column Mismatches:
The documentaries query has a trailing limi typo after from netflix, and the PostgreSQL actor queries reference casting rather than the cast_members column defined in the CREATE TABLE statement.Case & Null Handling: Using LOWER()/UPPER() consistently on description and checking for NULL alongside empty strings ('') or array elements can make filters more reliable across real-world datasets.
