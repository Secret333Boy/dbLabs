INSERT INTO
  director (first_name, last_name, date_of_birth, phone)
VALUES
  ('Sergio', 'Sarver', '09.08.1978', '+111');
INSERT INTO
  repertoire (month, director_id)
VALUES
  ('November', 1);
INSERT INTO
  producer (first_name, last_name, date_of_birth, categorie)
VALUES
  ('Eugene', 'Kane', '08.12.1993', 'artist');
INSERT INTO
  producer (first_name, last_name, date_of_birth, categorie)
VALUES
  ('Gregor', 'Lane', '08.11.1992', 'conductor');
INSERT INTO
  producer (first_name, last_name, date_of_birth, categorie)
VALUES
  ('Dave', 'Johnson', '08.10.1995', 'director');
INSERT INTO
  genre (name)
VALUES
  ('comedy'), ('trategy');
INSERT INTO
  author (first_name, last_name, date_of_birth)
VALUES
  ('Kave', 'Lorenson', '09.11.1999');
INSERT INTO
  performance (
    name,
    timestamp,
    repertoire_month,
    genre,
    author_id,
    artist_id,
    conductor_id,
    director_id,
    age_limit,
    premiere_date
  )
VALUES
  (
    'Alice in Wonderland',
    '2020-11-30T10:00+3',
    'November',
    'comedy',
    1,
    1,
    2,
    3,
    NULL,
    '30.11.2020'
  );
INSERT INTO
  actor (first_name, last_name, date_of_birth)
VALUES
  ('Bethany', 'Cameron', '09.02.1996'), ('Henry', 'Canny', '08.06.2000');
INSERT INTO
  role (role, actor_id, performance_id) VALUES ('Alice', 1, 1), ('Cheshire Cat', 2, 1);
UPDATE actor SET first_name = 'Christine' WHERE  first_name = 'Bethany';