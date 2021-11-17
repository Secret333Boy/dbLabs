DROP TABLE theatre.rank;
DROP TABLE theatre.musician;
ALTER TABLE theatre.contest DROP place;
INSERT INTO theatre.contest (name, actor_id) VALUES ('Zzzz', 1);
DELETE FROM theatre.contest * WHERE name = 'Zzzz';
