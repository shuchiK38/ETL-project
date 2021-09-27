# Project2 - Extract, Transform, Load (ETL)

ETL - Extract Transform Load project - We will be creating consolidated movies database with streaming platforms information.

## **Table of Contents**

- [Background & General Info](https://github.com/meetk5/Team-Project2#background--general-info)
- [Technologies](https://github.com/meetk5/Team-Project2#technologies)
- [ETL Process](https://github.com/meetk5/Team-Project2#etl-process)
  - [Step 1: Extract](https://github.com/meetk5/Team-Project2#step-1-extract)
  - [Step 2: Transform](https://github.com/meetk5/Team-Project2#step-2-transform)
  - [Step 3: Load](https://github.com/meetk5/Team-Project2#step-3-load)
- [Schema](https://github.com/meetk5/Team-Project2#schema)
- [Sample Queries](https://github.com/meetk5/Team-Project2#sample-queries)
- [Considerations](https://github.com/meetk5/Team-Project2#considerations)
- [Status](https://github.com/meetk5/Team-Project2#status)
- [Team Members](https://github.com/meetk5/Team-Project2#team-members)

## **Background** & General Info

Streaming platforms have gained enormous popularity in recent years for offering high-value entertainment from the comfort of your couch. Since the pandemic, it has become one of the biggest sources of entertainment. It is often challenging to find out where a particular movie or a series is streaming with several streaming platforms in the market. Furthermore, a person cannot subscribe to every platform out there.

For this project, we are focusing on three streaming platforms - **Netflix, Disney Plus and Crackle**

**This is where our database will be helpful to a hypothetical user or a company -** 

- Our database will give all the information of movies & shows and their related streaming platforms to all the users in one place. This will save their time in searching for movies or shows on separate platforms.
- Using our database, an organization can run an analysis on which streaming platform is more popular based on the type and number of movies & shows it streams. It also helps an individual user to make an informed decision on which platform they should subscribe to.
- Users will also be able to filter out movies or shows based on their choice of language, highest rated IMDB movies, their favorite actors, year, country, etc.

**A list of data sources:**

- [OMDB API](http://www.omdbapi.com/)
- [Netflix streaming data](https://data.world/chasewillden/netflix-shows/workspace/file?filename=netflix.xlsx)
- [Disney Plus streaming data](https://www.kaggle.com/unanimad/disney-plus-shows?select=disney_plus_shows.csv)
- [Crackle streaming data](https://api-v2.crackle.com/browse/all?sortOrder=alpha-asc&pageNumber=1&pageSize=300)

## Technologies

- SQL
- PostgreSQL 11
- Pandas
- Python
- APIs
- Quick DBD
- Excel

## **ETL Process**

## Step 1: Extract

### Netflix Data Extraction

- Downloaded CSV file containing Netflix movie streaming data from data.world and converted into a dataframe
- Extracted movie titles into list to run an OMDB API query on movie titles to get a JSON response
- Converted this JSON response into a dataframe with required columns and removed duplicates based on Imdb ids
- Removed RT Ratings and Metacritic Ratings as most of them are none
- Imported this clean dataframe into a csv file for merge

### Disney Plus Data Extraction

- Downloaded CSV file containing Disney Plus movie streaming data from kaggle.com and converted into a dataframe
- Extracted Imdb ids after eliminating the blank rows to run an OMDB API query on those Imdb ids to get a JSON response
- Converted this JSON response into a dataframe with required columns
- Removed RT Ratings and Metacritic Ratings as most of them are none
- Replaced US/USA to United States and UK to United Kingdom

- Imported this clean dataframe into csv file for merge

### Crackle Data Extraction

- Crackle is one of the less known free add supported movie streaming service. They 

  support free API to access data described on https://api-v2-doc.crackle.com/.

- Run Crackle API query using link mentioned in the data sources to find title of the movie

- Run OMDB API query using movie titles to get Imdb id  in response and eliminate all rows where Imdb Id is not found

-  Removed parenthesis from the movie title and changed "&" to "and"

- Run OMDB API again on newly cleaned data to retrieve Imdb Id and other details for 16 more entries

- Replaced US/USA to United States and UK to United Kingdom

- Imported this clean dataframe into csv file for merge

## Step 2: Transform

### Merging Dataframes and Creating Junction Table

- After extracting and cleaning csv files for each streaming platform, we imported them into separate dataframes 
- We concatenated these dataframes and removed duplicate entries based on the Imdb id. This provided us with a movies and shows database which has data of all the unique movies and shows from the three streaming platforms.
- We created a new platform dataframe where we defined each streaming platform and its platform id in order to create a junction table
- Netflix, Disney Plus and Crackle csv files are read into a three different dataframes
- The dataframes are then checked for duplicates and Imdb_Ids are stored in respective lists (i.e. Netflix, Disney Plus and Crackle)
- Each list is then used to create a Dictionary with corresponding Platform ids.
- The dictionaries are used to create 3 Platform dataframes (one for each source) which has just two columns - Imdb Id and Platform Id
- The dataframes are arranged (transposed, column renamed, etc.)
- Finally, all the dataframes are concatenated (not merged) together to create Movie_Source dataframe. This serves as a junction table in our database which connects movies & shows table and platform table.
- The dataframe is then exported to the Movie_Source csv (to be used to create SQL table in our Postgres database.  

## Step 3: Load

- After extracting and transforming process, we had three dataframes: **movies_df** (containing all information about movies and shows), **platform_df** (containing information about streaming platforms and their platform id) and **moviesource_df** (acting as a junction dataframe for previous two dataframes)
- These 3 dataframes were loaded into a SQL database in pgAdmin 4.
- A database was created in pgAdmin4 called "movies_db"
- A table called "**moviesandshows**" was created to correspond with the **movies_df**, "**source_table**" corresponded to "**platform_df**" and a junction table "**moviesource**" corresponded to "**moviesource_df**"
- We used sqlalchemy to create engine and connection with our database in pgAdmin and then used t_sql command to load our dataframes into the table in the database

## **Schema**

We created our Entity Relationship Database using Quick DBD

![erd](https://github.com/meetk5/Team-Project2/blob/main/Images/erd.png)

## **Sample Queries**

In order to to see if our user can quickly search movies through the platforms, we ran a few queries to demonstrate the working of our relational database.

- **All movies and shows on Netflix**

![query1](https://github.com/meetk5/Team-Project2/blob/main/Images/query1.jpg)

- **Search movies or shows by their title and on which platform they are streaming**

![query2](https://github.com/meetk5/Team-Project2/blob/main/Images/query2.jpg)

- **Search movies or shows on all platforms for your favourite actor**

![query3](https://github.com/meetk5/Team-Project2/blob/main/Images/query3.jpg)

- **Search movies or shows on all platforms with combination of two actors**

![query4](https://github.com/meetk5/Team-Project2/blob/main/Images/query4.jpg)

![query5](https://github.com/meetk5/Team-Project2/blob/main/Images/query5.jpg)

- **Search 2020 movies or shows on all platforms**

![query6](https://github.com/meetk5/Team-Project2/blob/main/Images/query6.jpg)

- **Search highest rated movies or shows on all platforms**

![query7](https://github.com/meetk5/Team-Project2/blob/main/Images/query7.jpg)

- **Search movies which has both Italian and French languages on all platforms**

![query8](https://github.com/meetk5/Team-Project2/blob/main/Images/query8.jpg)

## Considerations

Our project is Scalable in future if we intend to add new sources and its movies/shows catalogue. For example, let's say if we want to add HBO Max and all the movies related to that in out database then that can be easily done.

- We will extract Imdb_ids and movie titles of HBO Max and see which titles are not there in moviesandshows table. These unique titles will be concatenated with our moviesandshows table.
- We will define one more entry in source_table for HBO Max along with its platform id
- We will use the same method to create a junction table for movies related to HBO max data
- Once ready, we will transfer all these data into our moviesource table and import them into our database.

## **Status**

*This project is complete.*

## **Team Members**

- [Dasa Simova](github.com/DasaSimo)
- [Jay Dhruv](github.com/jaybdhruv)
- [Meet K Kaur Sahni](github.com/meetk5)
- [Shuchi Khandelwal](github.com/shuchiK38)
