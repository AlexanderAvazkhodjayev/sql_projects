CREATE TABLE users (
    email VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);



/*
Challenge 1 -- 
SELECT 
    DATE_FORMAT(MIN(created_at), "%M %D %Y") as earliest_date 
FROM users;

Challenge 2 --
SELECT 
    * 
FROM users 
WHERE created_at = (SELECT Min(created_at) FROM users); 

Challenge 3 --
SELECT 
  MONTHNAME(created_at) AS month,
  COUNT(*) as count
FROM users 
GROUP BY MONTHNAME(created_at)
ORDER BY count DESC;

Challenge 4 --
SELECT 
    COUNT(email) AS 'yahoo emails'
FROM users 
WHERE email LIKE '%@yahoo.com';

Challenge 6 --
SELECT 
    CASE
        WHEN email LIKE '%@gmail.com' THEN 'gmail'
        WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
        WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
        ELSE 'other'
    END AS provider,
    COUNT(*) AS total_users
FROM users
GROUP BY provider
ORDER BY total_users DESC;
*/