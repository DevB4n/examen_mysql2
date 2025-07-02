use examen;


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS ps_registrar_cliente_unico(IN nombre VARCHAR(60), IN email VARCHAR(50),IN numero INT,IN direccion VARCHAR(50),IN fecha_registro DATE)
BEGIN
    IF 
    (SELECT  clientes.email
    FROM clientes
    ) != email
    INSERT VALUES nombre,email,numero,direccion,fecha_registro INTO clientes(nombre,email,telefono,direccion,fecha_registro)
    END IF;
END//

DELIMITER;

   CALL ps_registrar_cliente_unico(
     'Adrian Ruiz', 
     'adrian.ruiz@gmail.com', 
     '3123456789', 
     'Calle 123 #45-67', 
     '2025-02-01', 
     5
   );


DELIMITER //
DROP PROCEDURE IF EXISTS  ps_obtener_clientes_por_municipio
CREATE PROCEDURE  IF NOT EXISTS ps_obtener_clientes_por_municipio(IN municipio VARCHAR,OUT cliente_id ,OUT nombre,OUT email)
BEGIN

    SELECT clientes.cliente_id,clientes.nombre,clientes.email
    INTO  cliente_id,nombre,email
    FROM municipio
    JOIN clientes ON municipio.id = clientes.municipioid;
    
END //

