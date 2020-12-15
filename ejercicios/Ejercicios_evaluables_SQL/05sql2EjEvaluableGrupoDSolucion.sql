prompt ---------------------------------------------------------------------

prompt SOLUCIONES EJERCICIO EVALUABLE 1. GRUPO D. 11/12/2017
prompt ---------------------------------------------------------------------

set linesize 300
prompt ---------------------------------------------------------------------


prompt 
prompt 1. Muestra el nombre de los clientes que han tenido proyectos
prompt    en los que han participado empleados cuya fecha de contratación es 
prompt    anterior al 1-1-2017.
prompt 

SELECT DISTINCT c.idCliente, c.nombre
FROM ejd_cliente c JOIN ejd_proyecto p ON c.idCliente = p.idCliente
JOIN ejd_distribucion d ON p.idProyecto = d.idProyecto
JOIN ejd_empleado e ON d.idEmpleado = e.idEmpleado
WHERE e.fecContrato < TO_DATE('01-01-2017');

prompt 
prompt 2. Muestra el nombre de los empleados que nunca han
prompt    trabajado para el cliente 'Movigas'.
prompt 

SELECT DISTINCT e.idEmpleado, e.nombre
FROM ejd_empleado e
WHERE e.idEmpleado NOT IN 
      (SELECT d2.idEmpleado 
      FROM ejd_distribucion d2
      JOIN ejd_proyecto p2 ON d2.idProyecto = p2.idProyecto
      JOIN ejd_cliente c2 ON p2.idCliente = c2.idCliente
      WHERE c2.nombre = 'Movigas');

prompt 
prompt 3. Muestra el nombre de los clientes para los que han
prompt    trabajado, en un mismo proyecto,
prompt    los empleados 'Astrid Almendros' y 'Manuel Sanchez'.
prompt 

SELECT c.idCliente, c.nombre
FROM ejd_cliente c JOIN ejd_proyecto p ON c.idCliente = p.idCliente
WHERE p.idProyecto IN 
      (SELECT d2.idProyecto
      FROM ejd_distribucion d2
      JOIN ejd_empleado e2 ON d2.idEmpleado = e2.idEmpleado
      WHERE e2.nombre = 'Astrid Almendros')
AND p.idProyecto IN 
      (SELECT d2.idProyecto
      FROM ejd_distribucion d2
      JOIN ejd_empleado e2 ON d2.idEmpleado = e2.idEmpleado
      WHERE e2.nombre = 'Manuel Sanchez');

prompt 
prompt 4. Muestra los proyectos (id de proyecto, nombre de cliente)
prompt    en los que *todos* los empleados asignados al proyecto
prompt    fueron contratados después del inicio del proyecto.
prompt 

SELECT p.idProyecto, c.nombre
FROM ejd_proyecto p
JOIN ejd_cliente c ON p.idCliente = c.idCliente
WHERE NOT EXISTS
      (SELECT e2.idEmpleado
      FROM ejd_empleado e2
      JOIN ejd_distribucion d2 ON e2.idEmpleado = d2.idEmpleado
      JOIN ejd_proyecto p2 ON d2.idProyecto = p2.idProyecto
      WHERE e2.fecContrato <= p2.fecInicio
      AND p2.idProyecto = p.idProyecto); -- CORRELACIONADA

prompt 
prompt 5. Muestra, para cada proyecto, los empleados asignados al proyecto
prompt    que tienen un salario mayor al salario medio del proyecto.
prompt    Debe mostrar idProyecto, nombre y salario del empleado.
prompt 

SELECT d.idProyecto, e.nombre, e.salario
FROM ejd_empleado e
JOIN ejd_distribucion d ON d.idEmpleado = e.idEmpleado
WHERE e.salario >
      (SELECT AVG(e2.salario)
      FROM ejd_empleado e2
      JOIN ejd_distribucion d2 ON d2.idEmpleado = e2.idEmpleado
      WHERE d2.idProyecto = d.idProyecto); -- CORRELACIONADA

prompt 
prompt 6. Muestra los proyectos con mayor número de empleados asignados en su área.
prompt    Debe mostrar idProyecto, número de empleados asignados y área.
prompt 

SELECT p.idProyecto, COUNT(DISTINCT e.idEmpleado), p.area
FROM ejd_proyecto p
JOIN ejd_distribucion d ON d.idProyecto = p.idProyecto
JOIN ejd_empleado e ON e.idEmpleado = d.idEmpleado
GROUP BY p.area, p.idProyecto
HAVING COUNT(DISTINCT e.idEmpleado) >= ALL
       (SELECT COUNT(DISTINCT e2.idEmpleado)
       FROM ejd_proyecto p2
       JOIN ejd_distribucion d2 ON d2.idProyecto = p2.idProyecto
       JOIN ejd_empleado e2 ON e2.idEmpleado = d2.idEmpleado
       GROUP BY p2.area, p2.idProyecto
       HAVING p2.area = p.area); -- CORRELACIONADA

prompt 
prompt Otra forma de resolverlo es utilizar *DOS* funciones
prompt de agregacion anidadas.
prompt 

SELECT p.idProyecto, COUNT(DISTINCT e.idEmpleado), p.area
FROM ejd_proyecto p
JOIN ejd_distribucion d ON d.idProyecto = p.idProyecto
JOIN ejd_empleado e ON e.idEmpleado = d.idEmpleado
GROUP BY p.area, p.idProyecto
HAVING COUNT(DISTINCT e.idEmpleado) = 
       (SELECT MAX(COUNT(DISTINCT e2.idEmpleado))
       FROM ejd_proyecto p2
       JOIN ejd_distribucion d2 ON d2.idProyecto = p2.idProyecto
       JOIN ejd_empleado e2 ON e2.idEmpleado = d2.idEmpleado
       GROUP BY p2.area, p2.idProyecto
       HAVING p2.area = p.area);

prompt 
prompt 7. Muestra el listado de todos los empleados de la empresa, junto a
prompt    los clientes para los que están trabajando actualmente (SYSDATE).
prompt    Si ahora no están trabajando para ningún cliente,
prompt    se debe indicar como nombre de cliente 'DISPONIBLE'.
prompt 

SELECT DISTINCT e.nombre, NVL(actuales.nombre,'DISPONIBLE')
FROM ejd_empleado e
LEFT JOIN
     (SELECT d.idEmpleado, c.nombre
     FROM ejd_distribucion d
     JOIN ejd_proyecto p ON d.idProyecto = p.idProyecto
     JOIN ejd_cliente c ON p.idCliente = c.idCliente
     WHERE SYSDATE BETWEEN d.fecInicio AND d.fecFin) actuales
ON actuales.idEmpleado = e.idEmpleado;


prompt 
prompt Se puede solucionar como una union de dos consultas:
prompt 

SELECT DISTINCT e.nombre, c.nombre
FROM ejd_empleado e
JOIN ejd_distribucion d ON d.idEmpleado = e.idEmpleado
JOIN ejd_proyecto p ON d.idProyecto = p.idProyecto
JOIN ejd_cliente c ON p.idCliente = c.idCliente
WHERE SYSDATE BETWEEN d.fecInicio AND d.fecFin
UNION ALL
SELECT e2.nombre, 'DISPONIBLE'
FROM ejd_empleado e2
WHERE e2.idEmpleado NOT IN
      (SELECT d3.idEmpleado
      FROM ejd_distribucion d3
      WHERE SYSDATE BETWEEN d3.fecInicio AND d3.fecFin);

prompt 
prompt 8. Muestra el gasto salarial total por cliente en el mes
prompt    de noviembre de 2017 de aquellos clientes que tienen
prompt    proyectos con presupuesto total de más de 100000 euros.
prompt    Observación: No es necesario mostrar todos los clientes, solo 
prompt    los que tienen gasto salarial en noviembre.
prompt 

SELECT c.idCliente, c.nombre, sum(e.salario)
FROM ejd_cliente c JOIN ejd_proyecto p ON c.idCliente = p.idCliente
JOIN ejd_distribucion d ON p.idProyecto = d.idProyecto
JOIN ejd_empleado e ON d.idEmpleado = e.idEmpleado
WHERE d.fecInicio <= TO_DATE('30-11-2017') AND d.fecFin >= TO_DATE('1-11-2017')
GROUP BY c.idCliente, c.nombre
HAVING sum(p.presupuesto) > 100000;



