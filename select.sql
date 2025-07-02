-- mostrar los empleados junto al pais donde laburan


SELECT empleados.nombre AS nombre, pais.nombre AS pais
FROM empleados
JOIN sucursal ON empleados.sucursalid = sucursal.id
JOIN municipio ON sucursal.municipioid = municipio.id
JOIN departamento ON municipio.depid = departamento.id
JOIN pais ON departamento.paisid = pais.id;


