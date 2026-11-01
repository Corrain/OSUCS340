/* Select query to get all people where homeworld is NOT NULL */
SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age
FROM bsg_people
INNER JOIN bsg_planets ON bsg_people.homeworld = bsg_planets.id;

/* Insert query to add a person and their homeworld */
/* the %s are placeholders for values that will be passed in */
INSERT INTO bsg_people (fname, lname, homeworld, age)
VALUES (%s, %s, %s, %s);

/* Update query to modify a person */
UPDATE bsg_people SET fname=%s, lname=%s, homeworld=%s, age=%s WHERE id=%s;

/* Delete a person using their id */
DELETE FROM bsg_people WHERE id=%s;

/* Finally, a Select query to get planet id and name */
SELECT `id`,`name` FROM `bsg_planets`; 