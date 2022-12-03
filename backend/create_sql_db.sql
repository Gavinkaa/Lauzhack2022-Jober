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
DROP TABLE JobLocation cascade;
DROP TABLE JobLevel cascade;
DROP TABLE Matching cascade;
DROP TABLE SwapRight cascade;

CREATE TABLE JobSeeker (
    EMAIL varchar NOT NULL,
    salary int,
    PRIMARY KEY (EMAIL)
);

--create a table for skills which are strings
CREATE TABLE Skill (
    skill varchar NOT NULL,
    PRIMARY KEY (skill)
);

--create a table for the many-to-one relationship between users and skills
CREATE TABLE UserSkill (
    id int NOT NULL,
    EMAIL varchar NOT NULL,
    skill varchar NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);

--create a table for locations which string with country and postal code
CREATE TABLE Location (
    country varchar NOT NULL,
    postalCode int NOT NULL,
    PRIMARY KEY (country, postalCode)
);

--create a table for location which are strings
-- CREATE TABLE Location (
--     location varchar NOT NULL,
--     PRIMARY KEY (location)
-- );

--create a table for the many-to-one relationship between users and locations
CREATE TABLE UserLocation (
    EMAIL varchar NOT NULL,
    country varchar NOT NULL,
    postalCode int NOT NULL,
    PRIMARY KEY (EMAIL, country, postalCode),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

--create a table for the level of experience which are strings
CREATE TABLE Level (
    level varchar NOT NULL,
    PRIMARY KEY (level)
);

--create a table for the many-to-one relationship between users and experience
CREATE TABLE UserLevel (
    EMAIL varchar NOT NULL,
    level varchar NOT NULL,
    PRIMARY KEY (EMAIL, level),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (level) REFERENCES Level(level)
);

-- create a table for company. name is the primary key, it has a location
CREATE TABLE Company (
    name varchar NOT NULL,
    country varchar NOT NULL,
    postalCode int NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

-- create a Job table. JobId and company name forms the primary key. It has a location
CREATE TABLE Job (
    JobId INTEGER NOT NULL PRIMARY KEY,
    company varchar NOT NULL,
    name varchar NOT NULL,
    country varchar NOT NULL,
    postalCode int NOT NULL,
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

-- create a table for the many-to-many relationship between jobs and skills
CREATE TABLE JobSkill (
    JobId int NOT NULL,
    skill varchar NOT NULL,
    PRIMARY KEY (JobId, skill),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);

-- create a table for the many-to-one relationship between jobs and location
CREATE TABLE JobLocation (
    JobId int NOT NULL,
    country varchar NOT NULL,
    postalCode int NOT NULL,
    PRIMARY KEY (JobId, country, postalCode),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (country, postalCode) REFERENCES Location(country, postalCode)
);

-- create a table for the many-to-one relationship between jobs and experience
CREATE TABLE JobLevel (
    JobId int NOT NULL,
    level varchar NOT NULL,
    PRIMARY KEY (JobId, level),
    FOREIGN KEY (JobId) REFERENCES Job(JobId),
    FOREIGN KEY (level) REFERENCES Level(level)
);

-- create a Matching table. It has a user email and Jobid are the primary key
CREATE TABLE Matching (
    EMAIL varchar NOT NULL,
    JobId int NOT NULL,
    company varchar NOT NULL,
    PRIMARY KEY (EMAIL, JobId),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);

-- create a SwapRight table. It has a user email and Jobid are the primary key
CREATE TABLE SwapRight (
    EMAIL varchar NOT NULL,
    JobId int NOT NULL,
    company varchar NOT NULL,
    PRIMARY KEY (EMAIL, JobId),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);
