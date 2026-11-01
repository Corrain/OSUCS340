-- Write your queries to insert data here

INSERT INTO client (
    first_name,
    last_name,
    email
) VALUES (
    "Sara",
    "Smith",
    "smiths@hello.com"
),
(
    "Miguel",
    "Cabrera",
    "mc@hello.com"
),
(
    "Bo",
    "Chan'g",
    "bochang@hello.com"
);

INSERT INTO employee (
    first_name,
    last_name,
    start_date,
    email
) VALUES (
    "Ananya",
    "Jaiswal",
    "2008-04-10",
    "ajaiswal@hello.com"
),
(
    "Michael",
    "Fern",
    "2015-07-19",
    "michaelf@hello.com"
),
(
    "Abdul",
    "Rehman",
    "2018-02-27",
    "rehman@hello.com"
);

INSERT INTO project (
    title,
    comments,
    cid
) VALUES (
    "Diamond",
    "Should be done by Jan 2019",
    (SELECT client.id FROM client WHERE first_name = "Sara" AND last_name = "Smith")
),
(
    "Chan'g",
    "Ongoing maintenance",
    (SELECT client.id FROM client WHERE first_name = "Bo" AND last_name = "Chan'g")
),
(
    "The Robinson Project",
    NULL,
    (SELECT client.id FROM client WHERE first_name = "Miguel" AND last_name = "Cabrera")
);

INSERT INTO works_on (
    pid,
    eid,
    due_date
) VALUES (
    (SELECT project.id FROM project WHERE project.title = "Chan'g"),
    (SELECT employee.id FROM employee WHERE employee.first_name = "Ananya" AND employee.last_name = "Jaiswal"),
    "2020-11-19"
),
(
    (SELECT project.id FROM project WHERE project.title = "The Robinson Project"),
    (SELECT employee.id FROM employee WHERE employee.first_name = "Michael" AND employee.last_name = "Fern"),
    "2020-12-05"
),
(
    (SELECT project.id FROM project WHERE project.title = "Diamond"),
    (SELECT employee.id FROM employee WHERE employee.first_name = "Abdul" AND employee.last_name = "Rehman"),
    "2021-01-01"
);