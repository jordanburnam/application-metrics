--Create a metrics table to house historical totals of stuff 
CREATE TABLE IF NOT EXISTS job_submission_metrics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATE,
    metric_name TEXT,
    metric_value TEXT
); 



-- Drop the tables 
DROP TABLE IF EXISTS job_submission;
DROP TABLE IF EXISTS numbers;
DROP VIEW IF EXISTS resume_counts; 
DROP VIEW IF EXISTS submission_total;
DROP VIEW IF EXISTS active_submissions;



--Create the job_submission table 
CREATE TABLE IF NOT EXISTS job_submission (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATE,
    company_name TEXT,
    job_title TEXT,
    resume TEXT,
    job_link TEXT,
    status TEXT,
    email_address TEXT
); 

-- Create the numbers table, I use this in a few queries for figuring out some data 
CREATE TABLE IF NOT EXISTS numbers (num INTEGER);


-- Populate the numbers table 
INSERT INTO numbers (num)
WITH RECURSIVE cnt(x) AS (
    SELECT 0
    UNION ALL
    SELECT x + 1
    FROM cnt
    LIMIT 10000
)
SELECT x FROM cnt;



--Create the resume counts view  to compare how resumes are doing
CREATE VIEW resume_counts AS
WITH RESUME_COUNTS AS (
    SELECT
        Resume,
        Status,
        COUNT(*)
    FROM
        job_submission
    GROUP BY
        Resume,
        STATUS
)
SELECT
    *
FROM
    RESUME_COUNTS
ORDER BY
    Resume,
    Status;


-- Create a totals view 
CREATE VIEW submission_total AS 
SELECT 
    "Status",
    COUNT(*)
FROM job_submission 
GROUP BY "Status";


CREATE VIEW active_submissions AS 
SELECT
    COUNT(*) AS viable_applications
FROM
    job_submission
WHERE
    status = 'SUBMITTED'
    AND timestamp >= DATE('now', '-14 days');