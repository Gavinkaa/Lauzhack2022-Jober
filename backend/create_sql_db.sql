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

--create a table for the many-to-many relationship between users and skills
CREATE TABLE UserSkill (
    EMAIL varchar NOT NULL,
    skill varchar NOT NULL,
    PRIMARY KEY (EMAIL, skill),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);

--create a table for location which are strings
CREATE TABLE Location (
    location varchar NOT NULL,
    PRIMARY KEY (location)
);

--create a table for the many-to-one relationship between users and locations
CREATE TABLE UserLocation (
    EMAIL varchar NOT NULL,
    location varchar NOT NULL,
    PRIMARY KEY (EMAIL, location),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (location) REFERENCES Location(location)
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
    location varchar NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (location) REFERENCES Location(location)
);

-- create a Job table. JobId and company name forms the primary key. It has a location
CREATE TABLE Job (
    JobId int NOT NULL,
    name varchar NOT NULL,
    company varchar NOT NULL,
    location varchar NOT NULL,
    PRIMARY KEY (JobId, company),
    FOREIGN KEY (company) REFERENCES Company(name),
    FOREIGN KEY (location) REFERENCES Location(location)
);

-- create a table for the many-to-many relationship between jobs and skills
CREATE TABLE JobSkill (
    JobId int NOT NULL,
    company varchar NOT NULL,
    skill varchar NOT NULL,
    PRIMARY KEY (JobId, company, skill),
    FOREIGN KEY (JobId, company) REFERENCES Job(JobId, company),
    FOREIGN KEY (skill) REFERENCES Skill(skill)
);

-- create a table for the many-to-one relationship between jobs and location
CREATE TABLE JobLocation (
    JobId int NOT NULL,
    company varchar NOT NULL,
    location varchar NOT NULL,
    PRIMARY KEY (JobId, company, location),
    FOREIGN KEY (JobId, company) REFERENCES Job(JobId, company),
    FOREIGN KEY (location) REFERENCES Location(location)
);

-- create a table for the many-to-one relationship between jobs and experience
CREATE TABLE JobLevel (
    JobId int NOT NULL,
    company varchar NOT NULL,
    level varchar NOT NULL,
    PRIMARY KEY (JobId, company, level),
    FOREIGN KEY (JobId, company) REFERENCES Job(JobId, company),
    FOREIGN KEY (level) REFERENCES Level(level)
);

-- create a Matching table. It has a user email and Jobid are the primary key
CREATE TABLE Matching (
    EMAIL varchar NOT NULL,
    JobId int NOT NULL,
    company varchar NOT NULL,
    PRIMARY KEY (EMAIL, JobId),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (JobId, company) REFERENCES Job(JobId, company)
);

-- create a SwapRight table. It has a user email and Jobid are the primary key
CREATE TABLE SwapRight (
    EMAIL varchar NOT NULL,
    JobId int NOT NULL,
    company varchar NOT NULL,
    PRIMARY KEY (EMAIL, JobId),
    FOREIGN KEY (EMAIL) REFERENCES JobSeeker(EMAIL),
    FOREIGN KEY (JobId, company) REFERENCES Job(JobId, company)
);
