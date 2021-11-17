ALTER TABLE
  theatre.actor RENAME is_a_student TO student;
ALTER TABLE
  theatre.actor DROP COLUMN student;
ALTER TABLE
  theatre.actor
ADD
  years_of_experience SMALLINT DEFAULT 0;
ALTER TABLE
  theatre.actor ALTER years_of_experience
SET
  NOT NULL;
ALTER TABLE
  theatre.actor ADD CONSTRAINT years_of_experience_valid CHECK (years_of_experience >= 0);
ALTER TABLE
  theatre.actor ALTER years_of_experience DROP NOT NULL;