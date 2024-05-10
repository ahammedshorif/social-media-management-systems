CREATE DATABASE social_media_management_system;
USE social_media_management_system;

-- 1. Users table.

CREATE TABLE users(
    user_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    username varchar(255) UNIQUE NOT NULL,
    profile_photo_url varchar(255),
    bio varchar(255),
    created_at TIMESTAMP,
    email varchar(30) NOT NULL,
);

-- 2. photos table.

CREATE TABLE photos(
    photo_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    photo_url varchar(255) NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP,
    size float CHECK (size>4)
);

--3.videos table.

CREATE TABLE videos(
    video_id INT PRIMARY KEY IDENTITY(1,1),
    video_url varchar(255) NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP,
    size FLOAT CHECK (size<10)
);

--4.post table.

CREATE TABLE post(
    post_id INT  PRIMARY KEY IDENTITY(1,1),
    photo_id INT,
    video_id INT,
    user_id INT NOT NULL,
    caption VARCHAR(200), 
    location VARCHAR(50) ,
    created_at TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(photo_id) REFERENCES photos(photo_id),
    FOREIGN KEY(video_id) REFERENCES videos(video_id)
);

--5.comments table.

CREATE TABLE comments (
    comment_id INT PRIMARY KEY IDENTITY(1,1) ,
    comment_text VARCHAR(255) NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP,
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

--6. post likes table.

CREATE TABLE post_likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    PRIMARY KEY(user_id, post_id)
);

--7. comment likes table.

CREATE TABLE comment_likes (
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    created_at TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(comment_id) REFERENCES comments(comment_id),
    PRIMARY KEY(user_id, comment_id)
);

--8. follower table.

CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP,
    FOREIGN KEY(follower_id) REFERENCES users(user_id),
    FOREIGN KEY(followee_id) REFERENCES users(user_id),
    PRIMARY KEY(follower_id, followee_id)
);

--9.hashtags table.

CREATE TABLE hashtags (
  hashtag_id INT PRIMARY KEY IDENTITY(1, 1),
  hashtag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP
);

--10.hashtags follow table.

CREATE TABLE hashtag_follow (
	user_id INT NOT NULL,
    hashtag_id INT NOT NULL,
    created_at TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(user_id, hashtag_id)
);

--11.bookmarks table.

CREATE TABLE bookmarks (
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP,
  FOREIGN KEY(post_id) REFERENCES post(post_id),
  FOREIGN KEY(user_id) REFERENCES users(user_id),
  PRIMARY KEY(user_id, post_id)
);

-- 12. login table.

CREATE TABLE login (
  login_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  user_id INT NOT NULL,
  ip VARCHAR(50) NOT NULL,
  login_time TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
