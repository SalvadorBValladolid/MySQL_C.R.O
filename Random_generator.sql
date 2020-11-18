# Prtimero, vamos a ver como le haríamos para llenar
# la tabla de customers de valores aleatorios, para eso, primero necesitamos
# crear una nueva columna en la tabla "customers".
ALTER TABLE customers ADD Random_number float;
# Una vez hecho lo anterior, tenemos que insertar valores aleatorios.
DROP PROCEDURE IF EXISTS InsertRand;
DELIMITER $$
CREATE PROCEDURE InsertRand()
    BEGIN
        DECLARE nrow INT;
        DECLARE i INT;
        SET i=0;
        select count(*) into nrow from customers;
        WHILE i<=nrow DO
        UPDATE customers
            SET Random_number = RAND() 
            WHERE CustomerNumber IN (SELECT * FROM(
            SELECT CustomerNumber
            FROM customers 
            LIMIT i, 1) as t);
            SET i=i+1;
        END WHILE;
    END$$
DELIMITER ;


# Ahora ya podemos llenar la tabla con valores aleatorios
call InsertRand();
