---1
SELECT * FROM performance WHERE id = 4;
---2
SELECT * FROM performance WHERE age_limit < 18;
---3
SELECT * FROM performance WHERE age_limit < 18 AND genre = 'Comedy' ORDER BY age_limit;
---4
SELECT * FROM performance WHERE age_limit > 18 OR genre = 'Tradegy';
---5
SELECT * FROM actor WHERE NOT is_a_student;
---6
SELECT name, age_limit, timestamp 
FROM performance WHERE repertoire_month = 'December' AND NOT age_limit < 3 ORDER BY timestamp;
---7
SELECT COUNT(*) AS actors_count FROM actor;
---8
SELECT AVG(age_limit) AS average_age_limit FROM performance;
---9
SELECT * FROM performance WHERE repertoire_month IN ('December', 'January');
---10
SELECT * FROM performance WHERE age_limit BETWEEN 6 AND 12;
---11
SELECT * FROM performance WHERE name LIKE 'Alice%';
---12
SELECT * FROM performance WHERE name SIMILAR TO '%(in|on)%';
---13
SELECT * FROM performance WHERE artist_id IS NOT NULL;
---14
SELECT * FROM performance WHERE age_limit IS NULL;
---15
SELECT * FROM role WHERE actor_id IS NULL;
---16-17
SELECT * FROM (SELECT month FROM repertoire WHERE NOT month = 'January') AS new_table;
---18-19
SELECT * FROM actor WHERE EXISTS (SELECT * FROM performance WHERE age_limit < 3);
---20-21
SELECT * FROM actor WHERE id IN (SELECT actor_id FROM role WHERE actor_id IS NOT NULL);
---22-23
SELECT * FROM (SELECT name AS performance_name FROM performance) AS new_table CROSS JOIN genre;
---24
SELECT name, role, first_name, last_name 
FROM role JOIN actor ON role.actor_id = actor.id JOIN performance ON performance.id = role.performance_id;
---25
SELECT name, role, first_name, last_name 
FROM role JOIN actor ON role.actor_id = actor.id 
JOIN performance ON performance.id = role.performance_id AND performance.age_limit > 3;
---26
SELECT name AS contest_name, first_name, last_name FROM contest JOIN actor ON contest.actor_id = actor.id;
---27-28
SELECT first_name, last_name, understudy_first_name, understudy_last_name FROM (
  SELECT actor_id, first_name AS understudy_first_name, last_name AS understudy_last_name FROM understudy
) AS new_table JOIN actor ON new_table.actor_id = actor.id;
---29
SELECT role, name AS performance_name, first_name, last_name
FROM role LEFT JOIN actor ON role.actor_id = actor.id LEFT JOIN performance ON role.performance_id = performance.id;
---30
SELECT role, name AS performance_name, first_name, last_name 
FROM role RIGHT JOIN actor ON role.actor_id = actor.id RIGHT JOIN performance ON role.performance_id = performance.id;
---31-33
SELECT first_name, last_name, date_of_birth FROM actor 
UNION 
SELECT first_name, last_name, date_of_birth FROM understudy
UNION
SELECT first_name, last_name, date_of_birth FROM author;
--- Виправлення:
--- підзапит
SELECT concat(first_name, ' ', last_name) AS actor, (SELECT AVG(age_limit) AS avg_age_limit FROM
    (performance JOIN role ON role.performance_id = performance.id) WHERE role.actor_id = actor.id)
FROM actor;
SELECT (SELECT concat(first_name, ' ', last_name) AS actor
        FROM actor WHERE role.actor_id = actor.id) AS actor,
       (SELECT name FROM performance WHERE role.performance_id = performance.id) AS performance,
       role
FROM role;
--- EXISTS
SELECT * FROM actor WHERE NOT EXISTS (SELECT * FROM role WHERE role.actor_id = actor.id);
--- поєднання за рівністю
SELECT * FROM role, actor, performance
WHERE role.actor_id = actor.id AND role.performance_id = performance.id;
SELECT * FROM role, actor, performance
WHERE role.actor_id = actor.id AND role.performance_id = performance.id AND age_limit < 18;
