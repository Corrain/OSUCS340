-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- Source URL: 
-- If AI tools were used:
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)


-- Leave the following query code untouched
DROP VIEW  IF EXISTS v_cert_people;

-- ------- Write your code below this line -----------
CREATE VIEW v_cert_people AS
SELECT 
    title, fname, lname, bsg_planets.name AS 'planet_name'
    -- bsg_cert.title AS 'certification title', bsg_people.fname AS 'first name', bsg_people.lname AS 'last name', bsg_planets.name AS 'homeworld name'
FROM 
    bsg_people
JOIN 
    bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
JOIN 
    bsg_cert ON bsg_cert_people.cid = bsg_cert.id
LEFT JOIN 
    bsg_planets ON bsg_people.homeworld = bsg_planets.id
ORDER BY 
    bsg_cert.title, bsg_people.fname, bsg_people.lname, bsg_planets.name;

