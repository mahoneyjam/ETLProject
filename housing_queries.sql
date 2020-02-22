--Data From: https://www.kaggle.com/zillow/zecon

CREATE TABLE cities_crosswalk(
    Unique_City_ID VARCHAR(255) PRIMARY KEY ,
    City VARCHAR(255),
    County VARCHAR(255),
    US_State VARCHAR(2)
)

CREATE TABLE county_time_series(
    ID SERIAL PRIMARY KEY,
    Date_ DATE,
    RegionName VARCHAR(5),
    per_sqft NUMERIC,
    one_bedroom NUMERIC,
    two_bedroom NUMERIC,
    three_bedroom NUMERIC,
    four_bedroom NUMERIC,
    five_bedroom NUMERIC,
    all_homes NUMERIC,
    bottom_tier NUMERIC,
    condo_coop NUMERIC,
    middle_tier NUMERIC,
    single_family NUMERIC,
    top_tier NUMERIC
)

CREATE TABLE County_CrossWalk(
	ID SERIAL PRIMARY KEY,
    CountyName VARCHAR(255),
    StateName VARCHAR(255),
    StateFips VARCHAR(2),
    CountyFips VARCHAR(3),
    MetroName VARCHAR(255),
    CBSAName VARCHAR(255),
    CountyRegionID VARCHAR(6),
    MetroRegionID VARCHAR(6),
    FIPS VARCHAR(5),
    CBSACode VARCHAR(5)
)

DROP TABLE IF EXISTS County_CrossWalk

SELECT * FROM cities_crosswalk
SELECT COUNT(date_) FROM county_time_series WHERE EXTRACT(YEAR FROM date_)=2016
SELECT * FROM County_CrossWalk
SELECT * FROM county_prices
	
ALTER TABLE county_time_series ALTER COLUMN RegionName TYPE VARCHAR (5)

CREATE TABLE county_prices AS
	SELECT County_CrossWalk.FIPS, county_time_series.per_sqft, county_time_series.bottom_tier,
	county_time_series.middle_tier, county_time_series.top_tier, County_CrossWalk.CountyName, County_CrossWalk.StateName
	FROM County_CrossWalk
	INNER JOIN county_time_series 
	ON county_time_series.RegionName=County_CrossWalk.FIPS

CREATE TABLE final_housing_db AS
	SELECT County_CrossWalk.FIPS, County_CrossWalk.statefips, ROUND(AVG(county_time_series.per_sqft),2), County_CrossWalk.CountyName, County_CrossWalk.StateName
	FROM county_time_series
	INNER JOIN County_CrossWalk
	ON county_time_series.RegionName=County_CrossWalk.FIPS
	WHERE EXTRACT(YEAR FROM county_time_series.date_)>2016 AND county_time_series.per_sqft IS NOT NULL
	GROUP BY County_CrossWalk.FIPS, County_CrossWalk.statefips, County_CrossWalk.CountyName, County_CrossWalk.StateName

CREATE TABLE housing_price_table(
    ID SERIAL PRIMARY KEY,
    FIPS VARCHAR(5),
    CountyName VARCHAR(255),
    StateName VARCHAR(255),
    per_sqft NUMERIC,
)