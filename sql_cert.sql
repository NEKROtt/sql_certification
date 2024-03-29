/*
Основное ДЗ:
1 задание:

Создайте процедуру ИЛИ функцию, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/


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

/*
2 задание:

Выведите только четные числа от 1 до 10 (Через цикл).
Пример: 2,4,6,8,10
*/

CREATE DATABASE IF NOT EXISTS HW_2;

USE HW_2;

DELIMITER $$ 

CREATE PROCEDURE even_numbers (IN count_number int, OUT result varchar(255))
BEGIN
  DECLARE i int DEFAULT 2;

  SET result = '';

  WHILE i < count_number DO
    SET result = CONCAT(result, CAST(i AS char), ' '); 
    SET i = i + 2;
  END WHILE;

END
$$

DELIMITER ;

SET @even = '';
CALL HW_2.even_numbers(20, @even);
SELECT @even;
