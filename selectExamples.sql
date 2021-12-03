SELECT * FROM performance;
SELECT * FROM performance WHERE age_limit < 18;
SELECT * FROM performance WHERE age_limit < 18 AND genre = 'Comedy' ORDER BY age_limit;
SELECT * FROM performance WHERE age_limit > 18 OR genre = 'Trategy';
SELECT * FROM actor WHERE NOT is_a_student;
SELECT name, age_limit, timestamp FROM performance WHERE repertoire_month = 'December' AND NOT age_limit < 3 ORDER BY timestamp;
SELECT COUNT(*) AS actors_count FROM actor;
SELECT AVG(age_limit) AS average_age_limit FROM performance;
SELECT * FROM performance WHERE repertoire_month IN ('December', 'January');
SELECT * FROM performance WHERE age_limit BETWEEN 6 AND 12;
SELECT * FROM performance WHERE name LIKE 'Alice%';
SELECT * FROM performance WHERE name SIMILAR TO '%(in|on)%';
SELECT * FROM performance WHERE artist_id IS NOT NULL;


---
SELECT * FROM (SELECT month FROM repertoire WHERE NOT month = 'January') AS new_table;
SELECT * FROM actor WHERE EXISTS (SELECT * FROM performance WHERE age_limit < 3);
SELECT * FROM actor WHERE id IN (SELECT actor_id FROM role WHERE actor_id IS NOT NULL);
SELECT * FROM (SELECT name AS performance_name FROM performance) AS new_table CROSS JOIN genre;
SELECT name, role, first_name, last_name FROM role JOIN actor ON role.actor_id = actor.id JOIN performance ON performance.id = role.performance_id;
SELECT name, role, first_name, last_name FROM role JOIN actor ON role.actor_id = actor.id JOIN performance ON performance.id = role.performance_id AND performance.age_limit > 3;
SELECT name AS contest_name, first_name, last_name FROM contest JOIN actor ON contest.actor_id = actor.id;
SELECT * FROM role LEFT JOIN actor ON role.actor_id = actor.id;
SELECT * FROM role RIGHT JOIN actor ON role.actor_id = actor.id;
SELECT first_name, last_name, date_of_birth FROM actor 
UNION 
SELECT first_name, last_name, date_of_birth FROM understudy;