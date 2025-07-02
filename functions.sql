--1. Crea una función llamada `fn_total_clientes_municipio(municipio_id INT)` que retorne el número de clientes en ese municipio.

USE examen;


DELIMITER //
DROP FUNCTION IF EXISTS  fn_total_clientes_municipio //
CREATE FUNCTION IF NOT EXISTS  fn_total_clientes_municipio(municipio_id INT)
DETERMINISTIC
READS SQL DATA
RETURNS INT
BEGIN
DECLARE numero_clientes VARCHAR(100);
    SET numero_clientes = SELECT COUNT(clientes.cliente_id )     
    FROM municipio
    JOIN clientes ON municipio.id = clientes.municipioid
    WHERE municipio_id = municipio.id;

    RETURN numero_clientes; 
END //

DELIMITER ;
SELECT fn_total_clientes_municipio(9);


--2. Crea una función llamada `fn_nombre_municipio(cliente_id INT)` que retorne el nombre del municipio de residencia del cliente.

DELIMITER //
DROP FUNCTION IF EXISTS fn_nombre_municipio//
CREATE FUNCTION IF NOT EXISTS fn_nombre_municipio(cliente_id INT)
READS SQL DATA
DETERMINISTIC
RETURNS VARCHAR
BEGIN
    DECLARE nombre_municipio VARCHAR(100);
    SET nombre_municipio = 
    SELECT municipio.nombre
    FROM clientes
    JOIN municipio ON clientes.municipioid = municipio.id
    WHERE clientes.cliente_id =  cliente_id;

    RETURN nombre_municipio;
END//
DELIMITER ;
SELECT fn_nombre_municipio(10);


--3. Crea una función llamada `fn_salario_promedio_sucursal(sucursal_id INT)` que retorne el promedio salarial de los empleados de la sucursal.

DELIMITER //
DROP FUCTION IF EXISTS  fn_salario_promedio_sucursal //
CREATE FUNCTION IF NOT EXISTS fn_salario_promedio_sucursal(sucursal_id INT)
DETERMINISTIC
READS SQL DATA
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE salario_promedio
    SET salario_promedio =
    SELECT AVG(empleados.salario)
    FROM sucursal
    JOIN empleados ON sucursal.id = empleados.sucursalid
    WHERE sucursal.id = sucursal_id;

    RETURN salario_promedio;
END//
DELIMITER ;
SELECT  fn_salario_promedio_sucursal(4);


--4. Crea una función llamada `fn_municipio_por_nombre_cliente(nombre_cliente VARCHAR)` que retorne el nombre del municipio del cliente según su nombre (puede haber duplicados).
DELIMITER //
DROP FUNCTION IF EXISTS fn_municipio_por_nombre_cliente //
CREATE FUNCTION IF NOT EXISTS fn_municipio_por_nombre_cliente(nombre_cliente VARCHAR)
DETERMINISTIC
READS SQL DATA
RETURNS VARCHAR(100)
BEGIN
    DECLARE municipio VARCHAR(100);
    SET municipio =
    SELECT DISTINCT municipio.nombre
    FROM clientes
    JOIN municipio ON clientes.municipioid = municipio.id 
    WHERE clientes.nombre  = nombre_cliente;

    RETURN municipio;
END //

DELIMITER ;
SELECT  fn_municipio_por_nombre_cliente("Daniela García")

--5. Crea una función llamada `fn_departamento_por_municipio(municipio_id INT)` que retorne el nombre del departamento asociado.

DELIMITER //
DROP FUNCTION IF EXISTS fn_departamento_por_municipio //
CREATE FUNCTION IF NOT EXISTS fn_departamento_por_municipio(municipio_id INT)
DETERMINISTIC
READS SQL DATA
RETURNS VARCHAR(100)
BEGIN
    DECLARE nombre_departamento =
    SELECT departamento.nombre 
    FROM municipio
    JOIN departamento ON municipio.depid = departamento.id
    WHERE municipio.id = municipio_id;

    RETURN nombre_departamento;
END//

DELIMITER ;

SELECT fn_departamento_por_municipio(4);