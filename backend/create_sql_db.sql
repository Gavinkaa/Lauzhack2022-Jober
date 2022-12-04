-- remove all value from the table
DROP TABLE JobSeeker cascade;
DROP TABLE Skill cascade;
DROP TABLE UserSkill cascade;
DROP TABLE Location cascade;
DROP TABLE UserLocation cascade;
DROP TABLE Level cascade;
DROP TABLE UserLevel cascade;
DROP TABLE Company cascade;
DROP TABLE Job cascade;
DROP TABLE JobSkill cascade;
DROP TABLE Matching cascade;
DROP TABLE SwapRight cascade;

CREATE TABLE JobSeeker (
    id uuid REFERENCES auth.users NOT NULL primary key,
    EMAIL VARCHAR(50) NOT NULL,
    salary int,
    firstname VARCHAR(20),
    lastname VARCHAR(20),
    age int
);

--create a table for skills which are strings
CREATE TABLE Skill (
    skill varchar PRIMARY KEY
);

--create a table for the many-to-one relationship between users and skills
CREATE TABLE UserSkill (
    userid uuid,
    skill varchar,
    PRIMARY KEY (userid, skill),
    FOREIGN KEY (userid) REFERENCES JobSeeker(id),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);

--create a table for locations which string with country and postal code
CREATE TABLE Location (
    country varchar(2),
    postalCode int CHECK (postalCode > 999 AND postalCode < 10000),
    PRIMARY KEY (country, postalCode)
);


--create a table for the many-to-one relationship between users and locations
CREATE TABLE UserLocation (
    userid uuid,
    country varchar NOT NULL,
    postalCode int NOT NULL,
    PRIMARY KEY (userid),
    FOREIGN KEY (userid) REFERENCES JobSeeker(id),
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

--create a table for the level of experience which are strings
CREATE TABLE Level (
    level varchar PRIMARY KEY
);

--create a table for the many-to-one relationship between users and experience
CREATE TABLE UserLevel (
    userid uuid,
    level varchar,
    PRIMARY KEY (userid, level),
    FOREIGN KEY (userid) REFERENCES JobSeeker(id),
    FOREIGN KEY (level) REFERENCES Level(level)
);

-- create a table for company. name is the primary key, it has a location
CREATE TABLE Company (
    id INTEGER PRIMARY KEY,
    name varchar NOT NULL,
    country varchar(2) NOT NULL,
    postalCode int NOT NULL,
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

-- create a Job table. JobId and company name forms the primary key. It has a location
CREATE TABLE Job (
    JobId INTEGER PRIMARY KEY,
    companyId INTEGER NOT NULL,
    name varchar NOT NULL,
    country varchar(2) NOT NULL,
    postalCode int NOT NULL,
    level varchar NOT NULL,
    description varchar NOT NULL,
    url varchar,
    FOREIGN KEY (level) REFERENCES Level(level),
    FOREIGN KEY (companyId) REFERENCES Company(id),
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

-- create a table for the many-to-many relationship between jobs and skills
CREATE TABLE JobSkill (
    JobId int,
    skill varchar,
    PRIMARY KEY (JobId, skill),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);


-- create a Matching table. It has a user email and Jobid are the primary key
CREATE TABLE Matching (
    userid uuid,
    JobId int,
    PRIMARY KEY (userid, JobId),
    FOREIGN KEY (userid) REFERENCES JobSeeker(id),
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);

-- create a SwapRight table. It has a user email and Jobid are the primary key
CREATE TABLE SwapRight (
    userid uuid,
    JobId int,
    PRIMARY KEY (userid, JobId),
    FOREIGN KEY (userid) REFERENCES JobSeeker(id),
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);
