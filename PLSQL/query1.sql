-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- Source URL: 
-- If AI tools were used:
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_query1;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_query1 (IN timeNow VARCHAR(4), OUT greeting VARCHAR(50))
BEGIN
    DECLARE current_hour INT;
    DECLARE formatted_time TIME DEFAULT NULL;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET formatted_time = NULL;

    -- Validate input format
    IF LENGTH(timeNow) != 4 THEN
        SET greeting = 'Invalid time format. Please use HHMM.'; 
    ELSE

        -- Convert the input timeNow to TIME format
        -- SET formatted_time = TIME_FORMAT(STR_TO_DATE(timeNow, '%H%i'), '%H:%i');
        SET formatted_time = STR_TO_DATE(timeNow, '%H%i');
        SET current_hour = HOUR(formatted_time);
        
        -- Check for valid time range
        IF formatted_time IS NULL OR timeNow NOT REGEXP '^([01][0-9]|2[0-3])[0-5][0-9]$' THEN
            SET greeting = 'Invalid time format. Please use HHMM.';
        ELSE

            -- SET OUTVAR 'greeting' to a string value based on current_hour
            IF current_hour < 6 THEN
                SET greeting = 'My it''s late, shouldn''t you be in bed?';
            ELSEIF current_hour < 12 THEN
                SET greeting = 'Good morning';
            ELSEIF current_hour < 17 THEN
                SET greeting = 'Good afternoon';
            ELSE
                SET greeting = 'Good evening';
            END IF;
        END IF;


    END IF;
END //
-- ------- Do not alter query code below this line -----------
DELIMITER ;