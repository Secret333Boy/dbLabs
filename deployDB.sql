CREATE TABLE director (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  first_name VARCHAR (20) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone VARCHAR (50)
);
CREATE TABLE repertoire (
  month VARCHAR (50) PRIMARY KEY NOT NULL UNIQUE,
  director_id BIGINT,
  FOREIGN KEY (director_id) REFERENCES director,
  CONSTRAINT month_valid CHECK (
    month IN (
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    )
  )
);
CREATE TABLE genre (
  name VARCHAR (50) PRIMARY KEY NOT NULL UNIQUE
);
CREATE TABLE author (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  first_name VARCHAR (20) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  date_of_birth DATE NOT NULL
);
CREATE TABLE producer (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  first_name VARCHAR (20) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  date_of_birth DATE NOT NULL,
  categorie VARCHAR (50) NOT NULL
);
CREATE TABLE performance (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  timestamp TIMESTAMP WITH TIME ZONE,
  name VARCHAR (50) NOT NULL,
  repertoire_month VARCHAR (50),
  genre VARCHAR (50) NOT NULL,
  age_limit SMALLINT,
  premiere_date DATE,
  director_id BIGINT,
  conductor_id BIGINT,
  artist_id BIGINT,
  author_id BIGINT,
  FOREIGN KEY (repertoire_month) REFERENCES repertoire,
  FOREIGN KEY (genre) REFERENCES genre,
  FOREIGN KEY (director_id) REFERENCES producer,
  FOREIGN KEY (conductor_id) REFERENCES producer,
  FOREIGN KEY (artist_id) REFERENCES producer,
  FOREIGN KEY (author_id) REFERENCES author,
  CONSTRAINT age_limit_valid CHECK (
    age_limit > 0
    AND age_limit <= 18
  )
);
CREATE TABLE actor (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  first_name VARCHAR (20) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  date_of_birth DATE NOT NULL,
  is_a_student BOOLEAN DEFAULT false
);
CREATE TABLE student (
  grade_book_number BIGINT PRIMARY KEY NOT NULL UNIQUE,
  actor_id BIGINT NOT NULL UNIQUE,
  FOREIGN KEY (actor_id) REFERENCES actor
);
CREATE TABLE rank (
  name VARCHAR (50) PRIMARY KEY NOT NULL UNIQUE,
  date DATE NOT NULL,
  actor_id BIGINT NOT NULL,
  FOREIGN KEY (actor_id) REFERENCES actor
);
CREATE TABLE contest (
  name VARCHAR (50) PRIMARY KEY NOT NULL UNIQUE,
  place VARCHAR (50),
  actor_id BIGINT NOT NULL,
  FOREIGN KEY (actor_id) REFERENCES actor
);
CREATE TABLE understudy (
  id BIGSERIAL PRIMARY KEY NOT NULL UNIQUE,
  first_name VARCHAR (20) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  date_of_birth DATE NOT NULL,
  actor_id BIGINT NOT NULL,
  FOREIGN KEY (actor_id) REFERENCES actor
);
CREATE TABLE role (
  role VARCHAR (50) PRIMARY KEY NOT NULL UNIQUE,
  actor_id BIGINT NOT NULL,
  performance_id BIGINT NOT NULL,
  FOREIGN KEY (actor_id) REFERENCES actor,
  FOREIGN KEY (performance_id) REFERENCES performance
);