CREATE TABLE moviesandshows(
       imdb_id VARCHAR(10) NOT NULL PRIMARY KEY,
       title VARCHAR NOT NULL,
	   year VARCHAR(10),
	   rated VARCHAR (10),
	   released VARCHAR(15),
	   runtime VARCHAR,
	   genre VARCHAR,
	   director VARCHAR,
	   writer VARCHAR,
	   actors VARCHAR,
	   language VARCHAR,
	   country VARCHAR,
	   imdb_rating VARCHAR,
	   type VARCHAR NOT NULL
	         

);

SELECT * FROM moviesandshows

	
CREATE TABLE source_table (
	platform_id  VARCHAR (4)NOT NULL PRIMARY KEY,
	platform_name VARCHAR(15) NOT NULL
 );
SELECT * FROM source_table

CREATE TABLE moviesource(
        imdb_id VARCHAR(10) NOT NULL,
	    platform_id VARCHAR(4) NOT NULL,
	    PRIMARY KEY (imdb_id , platform_id),
	    FOREIGN KEY (imdb_id)REFERENCES moviesandshows (imdb_id),
	    FOREIGN KEY (platform_id)REFERENCES source_table (platform_id)

);

SELECT * FROM moviesource 
