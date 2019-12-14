DROP DATABASE IF EXISTS ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone; 

CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);
--INSERT MASSIVE AMOUNT OF DATA FROM IG-CLONE-DATA.sql file
--QUERY DATA ACCORDING TO CHALLENGES


--Challenge 1
--Finding 5 oldest users
SELECT 
    id,
    username, 
    created_at 
FROM users 
ORDER BY created_at 
ASC LIMIT 5;

--Challenge 2
--Most Popular Registration Date
SELECT
    DAYNAME(created_at) AS day_created,
    COUNT(DAYNAME(created_at)) AS amount_registered
FROM users
GROUP BY day_created
ORDER BY amount_registered DESC
LIMIT 5;

--Challenge 3
--Identify Inactive Users (users with no photos)
SELECT
    username,
    image_url
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

--Challenge 4
--Identity most popular photo (and user who created it)
SELECT
    username,
    photos.id,
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 10;

--Challenge 5
--Calculate avg number of photos per user
SELECT
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

--Challenge 6
--Five Most Popular Hashtags
SELECT
    tags.tag_name,
    COUNT(tags.id) AS total
FROM tags
INNER JOIN photo_tags
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

--Challenge 7
--Finding the bots - the users who have liked every single photo
SELECT 
    users.id,
    users.username,
    COUNT(users.id) AS total_likes,
CASE 
    WHEN COUNT(users.id) = (SELECT COUNT(*) FROM photos) THEN 'POTENTIAL BOT'
    ELSE 'HUMAN'
END AS 'BOT DETECTION'
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
ORDER BY total_likes DESC
LIMIT 15;