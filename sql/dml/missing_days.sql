
WITH date_range AS (
        SELECT
            DATE('2024-07-09', '+' || num || ' days') AS date_part
        FROM
            numbers
        WHERE
            DATE('2024-07-09', '+' || num || ' days') <= DATE('2024-08-06')
            AND STRFTIME('%w', DATE(date_part)) NOT IN ('0', '6') -- Skip weekends
    )
SELECT
    date_part,
    js.date_only,
    js.Email_Address,
    js.total
FROM
    date_range AS dr
    LEFT JOIN (
        SELECT
            DATE(Timestamp) AS date_only,
            email_address,
            COUNT(*)  AS total
        FROM 
            job_submission
        WHERE
            email_address = "###email###"
        GROUP BY
            DATE(Timestamp),
            email_address
    ) AS js ON js.date_only = dr.date_part
WHERE
    date_only is null