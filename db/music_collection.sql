DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS albums;


CREATE TABLE artists (

id serial8 primary key,
name VARCHAR(255)

);

CREATE TABLE albums (

  id serial8 primary key,
  title VARCHAR(255),
  genre VARCHAR(255),
  artists_id INT4 references artists(id)

);
