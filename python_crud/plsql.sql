-- ###
-- 1) Reset DB PL/SQL
-- ###

DROP PROCEDURE IF EXISTS sp_ResetBSGDatabase;

DELIMITER //
CREATE PROCEDURE sp_ResetBSGDatabase()
BEGIN
        SET FOREIGN_KEY_CHECKS = 0;

        DROP TABLE IF EXISTS bsg_cert_people;
        DROP TABLE IF EXISTS bsg_people;
        DROP TABLE IF EXISTS bsg_cert;
        DROP TABLE IF EXISTS bsg_planets;

        CREATE TABLE bsg_planets (
            id INT NOT NULL AUTO_INCREMENT,
            name VARCHAR(255) NOT NULL,
            population BIGINT DEFAULT NULL,
            language VARCHAR(255) DEFAULT NULL,
            capital VARCHAR(255) DEFAULT NULL,
            PRIMARY KEY (id),
            UNIQUE KEY name (name)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

        CREATE TABLE bsg_cert (
            id INT NOT NULL AUTO_INCREMENT,
            title VARCHAR(255) NOT NULL,
            PRIMARY KEY (id)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

        CREATE TABLE bsg_people (
            id INT NOT NULL AUTO_INCREMENT,
            fname VARCHAR(255) NOT NULL,
            lname VARCHAR(255) DEFAULT NULL,
            homeworld INT DEFAULT NULL,
            age INT DEFAULT NULL,
            PRIMARY KEY (id),
            KEY homeworld (homeworld),
            CONSTRAINT bsg_people_ibfk_1 FOREIGN KEY (homeworld)
                REFERENCES bsg_planets (id)
                ON DELETE SET NULL ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

        CREATE TABLE bsg_cert_people (
            cid INT NOT NULL,
            pid INT NOT NULL,
            PRIMARY KEY (cid, pid),
            KEY pid (pid),
            CONSTRAINT bsg_cert_people_ibfk_1 FOREIGN KEY (cid) REFERENCES bsg_cert (id),
            CONSTRAINT bsg_cert_people_ibfk_2 FOREIGN KEY (pid) REFERENCES bsg_people (id)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

        INSERT INTO bsg_planets (id, name, population, language, capital) VALUES
            (1, 'Gemenon', 2800000000, 'Old Gemenese', 'Oranu'),
            (2, 'Leonis', 2600000000, 'Leonese', 'Luminere'),
            (3, 'Caprica', 4900000000, 'Caprican', 'Caprica City'),
            (7, 'Sagittaron', 1700000000, NULL, 'Tawa'),
            (16, 'Aquaria', 25000, NULL, NULL),
            (17, 'Canceron', 6700000000, NULL, 'Hades'),
            (18, 'Libran', 2100000, NULL, NULL),
            (19, 'Picon', 1400000000, NULL, 'Queestown'),
            (20, 'Scorpia', 450000000, NULL, 'Celeste'),
            (21, 'Tauron', 2500000000, 'Tauron', 'Hypatia'),
            (22, 'Virgon', 4300000000, NULL, 'Boskirk');

        INSERT INTO bsg_cert (id, title) VALUES
            (1, 'Raptor'),
            (2, 'Viper'),
            (3, 'Mechanic'),
            (4, 'Command');

        INSERT INTO bsg_people (id, fname, lname, homeworld, age) VALUES
            (1, 'William', 'Adama', 3, 61),
            (2, 'Lee', 'Adama', 3, 30),
            (3, 'Laura', 'Roslin', 3, NULL),
            (4, 'Kara', 'Thrace', 3, NULL),
            (5, 'Gaius', 'Baltar', 3, NULL),
            (6, 'Saul', 'Tigh', NULL, 71),
            (7, 'Karl', 'Agathon', 1, NULL),
            (8, 'Galen', 'Tyrol', 1, 32),
            (9, 'Callandra', 'Henderson', NULL, NULL);

        INSERT INTO bsg_cert_people (cid, pid) VALUES
            (2, 2),
            (4, 2),
            (4, 3),
            (2, 4),
            (4, 6),
            (1, 7),
            (3, 8),
            (3, 9);

        SET FOREIGN_KEY_CHECKS = 1;
END //
DELIMITER ;

---
--- 2) Create Person PL/SQL
---

DROP PROCEDURE IF EXISTS sp_CreatePerson;

DELIMITER //
CREATE PROCEDURE sp_CreatePerson(
    IN p_fname VARCHAR(255),
    IN p_lname VARCHAR(255),
    IN p_homeworld INT,
    IN p_age INT,
    OUT p_id INT
)
BEGIN
    INSERT INTO bsg_people (fname, lname, homeworld, age)
    VALUES (p_fname, p_lname, p_homeworld, p_age);

    SELECT LAST_INSERT_ID() INTO p_id;
END //
DELIMITER ;

---
--- 3) Update Person PL/SQL
---

DROP PROCEDURE IF EXISTS sp_UpdatePerson;

DELIMITER //
CREATE PROCEDURE sp_UpdatePerson(
    IN p_id INT,
    IN p_fname VARCHAR(255),
    IN p_lname VARCHAR(255),
    IN p_homeworld INT,
    IN p_age INT
)
BEGIN
    UPDATE bsg_people
    SET fname = p_fname,
        lname = p_lname,
        homeworld = p_homeworld,
        age = p_age
    WHERE id = p_id;
END //
DELIMITER ;

---
--- 4) Delete Person PL/SQL
---

DROP PROCEDURE IF EXISTS sp_DeletePerson;

DELIMITER //
CREATE PROCEDURE sp_DeletePerson(IN p_id INT)
BEGIN
    DECLARE v_rows_deleted INT DEFAULT 0;
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM bsg_cert_people
        WHERE pid = p_id;

        DELETE FROM bsg_people
        WHERE id = p_id;

        SET v_rows_deleted = ROW_COUNT();

        IF v_rows_deleted = 0 THEN
            SET error_message = CONCAT('No matching record found in bsg_people for id: ', p_id);
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;
END //
DELIMITER ;

