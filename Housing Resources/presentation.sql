--Create Tables
CREATE TABLE housing_price_table(
	FIPS INTEGER PRIMARY KEY,
	stateFIPS INTEGER,
	per_sqft NUMERIC,
    CountyName VARCHAR(255),
    StateName VARCHAR(255)    
)

CREATE TABLE us_fips(
    stname VARCHAR(255),
    stateFIPS INTEGER,
    stateAbbrv VARCHAR(255)
)

CREATE TABLE crime_rates_fips(
    county_name character varying (45) NOT NULL,
    crime_rate_per_100000 character varying (20) NOT NULL,
    index integer NOT NULL,
    edition integer NOT NULL,
    part integer NOT NULL,
    idno integer NOT NULL,
    cpoparst integer NOT NULL,
    cpopcrim integer NOT NULL,
    ag_arrst integer NOT NULL,
    ag_off integer NOT NULL,
    covind character varying (20) NOT NULL,
    indx integer NOT NULL,
    modindx integer NOT NULL,
    murder integer NOT NULL,
    rape integer NOT NULL,
    robbery integer NOT NULL,
    agasslt integer NOT NULL,
    burdlry integer NOT NULL,
    larceny integer NOT NULL,
    mvtheft integer NOT NULL,
    arson integer NOT NULL,
    population integer NOT NULL,
    fips_st integer NOT NULL,
    fips_cty integer NOT NULL,
    fips integer NOT NULL
);

--Import CSVs (EXTRACT!)

--Create second housing table as a working table (not seen here)

--Alter Tables
ALTER TABLE crime_rates_fips
DROP COLUMN crime_rate_per_100000,
DROP COLUMN covind,
DROP COLUMN county_name

ALTER TABLE housing_price_table
DROP COLUMN fips1,
DROP COLUMN countyname


--Create tables grouped by states
CREATE TABLE housing_states AS
	SELECT statefips, ROUND(AVG(per_sqft),2), statename FROM housing_price_table
	GROUP BY statefips, statename

CREATE TABLE crime_state AS
	Select fips_st, Round(AVG(indx),2) FROM crime_rates_fips
	GROUP BY fips_st

--Rename Column
ALTER TABLE crime_state
RENAME COLUMN round TO avg_index_rate

--Merge crime and housing stats
CREATE TABLE merge1 AS
	SELECT *
	FROM housing_states
	INNER JOIN crime_state
	ON housing_states.statefips=crime_state.fips_st

--Alter merged table
ALTER TABLE merge1
RENAME COLUMN round to average_price_per_sqft

ALTER TABLE merge1 
DROP COLUMN fips_st,
DROP COLUMN fips_cty,
DROP COLUMN fips,
DROP COLUMN county_name

--One more merge, to add state names (FINAL LOAD!)
CREATE TABLE presentation AS
	SELECT us_fips.stname, merge1.average_price_per_sqft, merge1.avg_index_rate FROM us_fips
	JOIN merge1 ON us_fips.statefips=merge1.statefips

SELECT * FROM presentation