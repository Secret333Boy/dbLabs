CREATE OR REPLACE PROCEDURE procedureA ()
AS
    $$
        BEGIN
            CREATE TEMP TABLE temp_table (a int, b int);
            INSERT INTO temp_table(a, b) VALUES ((SELECT name FROM performance WHERE id = 1),
                                                 (SELECT timestamp FROM performance WHERE id = 1));
            --useful staff
            DROP TABLE temp_table;
        END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureA();
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureB (idd int)
AS
    $$
    BEGIN
        IF ((SELECT is_a_student FROM actor WHERE id = idd))
            THEN BEGIN
                RAISE NOTICE 'TRUE';
            END;
            ELSE RAISE NOTICE 'FALSE';
        END IF;
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureB(1);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureC ()
AS
    $$
    DECLARE a int;
    BEGIN
        a = 3;
        WHILE NOT a = 0
            LOOP
                RAISE NOTICE '%', (SELECT concat(first_name, ' ', last_name) FROM actor WHERE id = a);
                a = a - 1;
            END LOOP;
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureC();
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureD (f varchar, l varchar, d date)
AS
    $$
    BEGIN
    INSERT INTO actor(first_name, last_name, date_of_birth) VALUES (f, l, d);
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureD('Henry', 'Simmens', '23.12.2001');
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureE (a int)
AS
    $$
    BEGIN
    --useful staff
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureE(1);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureF (a int)
AS
    $$
    BEGIN
        IF (a < 0) THEN RETURN;
        END IF;
        --useful staff
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureF(1);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureG (idd int, d date)
AS
    $$
    BEGIN
        UPDATE performance SET timestamp = d WHERE performance.id = idd;
    END
    $$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE procedureH()
AS
    $$
    DECLARE r record;
    BEGIN
        SELECT INTO r * FROM performance ORDER BY timestamp LIMIT 1;
        RAISE NOTICE 'Next performance: %', r.name;
    END;
    $$
LANGUAGE plpgsql;
DO
$$
    BEGIN
        CALL procedureH();
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcA (idd int) RETURNS date
AS
    $$
        BEGIN
            RETURN (SELECT timestamp FROM performance WHERE id = idd);
        END;
    $$
LANGUAGE plpgsql;
SELECT funcA(1);

CREATE OR REPLACE FUNCTION funcB (idd int) RETURNS RECORD
AS
    $$
        DECLARE record RECORD;
        BEGIN
            SELECT INTO record (SELECT name from performance WHERE id = idd)::varchar,
                               (SELECT age_limit FROM performance WHERE id = idd)::int,
                               (SELECT timestamp FROM performance WHERE id = idd)::date;
            RETURN record;
        END;
    $$
LANGUAGE plpgsql;
SELECT * FROM funcB(1) AS (name varchar, age int, date date);

CREATE OR REPLACE FUNCTION funcC () RETURNS TABLE (name varchar, age_limit smallint)
AS
    $$
        DECLARE record RECORD;
        BEGIN
        CREATE TEMP TABLE temp (
            name varchar,
            age_limit smallint
        );
        FOR record IN (SELECT * FROM performance)
            LOOP
                INSERT INTO temp(name, age_limit) VALUES (record.name, record.age_limit);
            END LOOP;
        RETURN QUERY (SELECT * FROM temp);
        DROP TABLE temp;
        END;
    $$
LANGUAGE plpgsql;
SELECT * FROM funcC();

CREATE OR REPLACE PROCEDURE curs ()
AS
    $$
        DECLARE curs CURSOR FOR SELECT * FROM performance;
        BEGIN
            FOR perf IN curs
                LOOP
                    IF perf.timestamp < now() THEN
                        DELETE FROM role WHERE role.performance_id = perf.id;
                        DELETE FROM performance WHERE CURRENT OF curs;
                    END IF;
                END LOOP;
        END;
    $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION openCurs () RETURNS refcursor
AS
    $$
        DECLARE
            curs refcursor;
            understudy record;
        BEGIN
            OPEN curs FOR SELECT * FROM actor;
            CLOSE curs;
            OPEN curs FOR SELECT * FROM understudy;
            FETCH curs INTO understudy;
            MOVE FORWARD 2 FROM curs;
            RETURN curs;
        END;
    $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION funcForTriggerA() RETURNS TRIGGER
AS
    $$
    BEGIN
        RAISE NOTICE 'DELETE ON actor';
        RETURN NEW;
    END;
    $$
LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS triggerA ON actor;
CREATE TRIGGER triggerA BEFORE DELETE ON actor EXECUTE PROCEDURE funcForTriggerA();
DELETE FROM performance WHERE id = 49;

CREATE OR REPLACE FUNCTION funcForTriggerB() RETURNS TRIGGER
AS
    $$
    BEGIN
        RAISE NOTICE 'UPDATE ON performance';
        RETURN NEW;
    END;
    $$
LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS triggerB ON performance;
CREATE TRIGGER triggerB BEFORE UPDATE ON performance EXECUTE PROCEDURE funcForTriggerB();
UPDATE performance SET timestamp = '31.12.2021' WHERE id = 1;

CREATE OR REPLACE FUNCTION funcForTriggerC() RETURNS TRIGGER
AS
    $$
    BEGIN
        RAISE NOTICE 'INSERT ON actor';
        RETURN NEW;
    END;
    $$
LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS triggerC ON actor;
CREATE TRIGGER triggerC AFTER INSERT ON actor EXECUTE PROCEDURE funcForTriggerC();
INSERT INTO actor(first_name, last_name, date_of_birth) VALUES ('Henry', 'Lorenson', '02.10.1976');

