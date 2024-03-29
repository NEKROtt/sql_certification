CREATE DATABASE IF NOT EXISTS seminar_sql_end;

USE seminar_sql_end;

DELIMITER $$

CREATE FUNCTION seminar_sql_end.sec_function(seconds int) 
  RETURNS varchar(300)
  DETERMINISTIC
BEGIN
  DECLARE result varchar(300);
  DECLARE days_value int DEFAULT 0;
  DECLARE hours_value int DEFAULT 0;
  DECLARE minutes_value int DEFAULT 0;

  -- счетчик дней

  IF seconds >= 86400 THEN
    SET days_value = seconds DIV 86400;
    SET seconds = seconds % 86400;
  END IF;

  -- счетчик часов

  IF seconds >= 3600 THEN
    SET hours_value = seconds DIV 3600;
    SET seconds = seconds % 3600; 
  END IF;

  -- счетчик минут / секунд

  IF seconds >=60 THEN
    SET minutes_value = seconds DIV 60;
    SET seconds = seconds % 60;
  END IF;
  
  SET result = CONCAT(
                    CAST(days_value AS CHAR), ' дней ',
                    CAST(hours_value AS CHAR), ' час ',
                    CAST(minutes_value AS CHAR), ' мин.');

  SET result = CONCAT(result, CAST(seconds AS CHAR), ' сек.');
  
  RETURN result;
END$$

DELIMITER ;

SELECT seminar_sql_end.sec_function(4563456)


