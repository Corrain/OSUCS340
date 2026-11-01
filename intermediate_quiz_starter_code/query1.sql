-- Write the query to create the 4 tables below.

DROP TABLE IF EXISTS client;
CREATE TABLE client (
  id int(11) AUTO_INCREMENT,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  CONSTRAINT full_name UNIQUE (first_name, last_name),
  PRIMARY KEY (id)
  );


DROP TABLE IF EXISTS employee;

  CREATE TABLE employee (
  id int(11) AUTO_INCREMENT,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  start_date date NOT NULL,
  email varchar(255) NOT NULL,
  CONSTRAINT full_name UNIQUE (first_name, last_name),
  PRIMARY KEY (id)
  );

  DROP TABLE IF EXISTS project;

  CREATE TABLE project (
  id int(11) AUTO_INCREMENT,
  title varchar(255) NOT NULL UNIQUE,
  comments TEXT,
  cid INT,
  PRIMARY KEY (id),
  FOREIGN KEY (cid) REFERENCES client(id)
  );

  DROP TABLE IF EXISTS works_on;

  CREATE TABLE works_on (
    pid INT,
    eid INT,
    due_date DATE NOT NULL,
    PRIMARY KEY (eid, pid),
    FOREIGN KEY (pid) REFERENCES project(id),
    FOREIGN KEY (eid) REFERENCES employee(id)
  );