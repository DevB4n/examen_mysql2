USE examen;

-- mostrar los empleados junto al pais donde laburan


SELECT empleados.nombre AS nombre, pais.nombre AS pais
FROM empleados
JOIN sucursal ON empleados.sucursalid = sucursal.id
JOIN municipio ON sucursal.municipioid = municipio.id
JOIN departamento ON municipio.depid = departamento.id
JOIN pais ON departamento.paisid = pais.id;


--Listar el nombre de cada cliente con su municipio, departamento y país.

SELECT clientes.nombre AS nombre, municipio.nombre AS municipio,departamento.nombre AS departamento, pais.nombre AS pais
FROM clientes
JOIN municipio ON clientes.municipioid = municipio.id
JOIN departamento ON municipio.depid = departamento.id
JOIN pais ON departamento.paisid = pais.id;


--Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.

SELECT DISTINCT sucursalid
FROM empleados;

SELECT empleados.nombre AS empleado, empleados.puesto AS Puesto
FROM empleados
JOIN sucursal ON empleados.sucursalid = sucursal.id
WHERE (
    SELECT COUNT(empleados.sucursalid) AS cantidad_sucursales
    FROM empleados
) > 1
;

--Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT municipio.nombre AS Municipio, departamento.nombre AS departamento, COUNT(empleados.empleado_id) AS cantidad_empleados
FROM empleados
JOIN sucursal ON empleados.sucursalid = sucursal.id
JOIN municipio ON sucursal.municipioid = municipio.id
JOIN departamento ON municipio.depid = departamento.id
GROUP BY municipio,departamento
;

--Mostrar todos los municipios con sucursales activas (que tengan al menos un empleado).
SELECT DISTINCT municipio.nombre AS municipio
FROM municipio
JOIN sucursal ON municipio.id = sucursal.municipioid
JOIN empleados ON  sucursal.id = empleados.sucursalid
WHERE empleados.sucursalid >= 1




