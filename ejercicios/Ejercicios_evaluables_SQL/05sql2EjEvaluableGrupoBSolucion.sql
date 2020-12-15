prompt ---------------------------------------------------------------------

prompt SOLUCIONES EJERCICIO EVALUABLE 1. GRUPO B. 12/12/2017
prompt ---------------------------------------------------------------------

set linesize 300
prompt ---------------------------------------------------------------------

prompt   
prompt 1. Muestra el nombre de los canales y el tiempo total dedicado a 
prompt    documentales en el mes de diciembre de 2017 de aquellos 
prompt    canales que han emitido más de 3 documentales en ese
prompt    periodo.
prompt   

SELECT c.idCanal, c.nombre, sum(duracion)
FROM ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal
JOIN ejb_programa pg ON pr.codPrograma = pg.codPrograma
WHERE EXTRACT(MONTH FROM pr.fec_hora) = 12 
AND   EXTRACT(YEAR FROM pr.fec_hora) = 2017
AND   pg.tipo = 'documental'
GROUP BY c.nombre, c.idCanal
HAVING count(*) > 3;

prompt   
prompt 2. Muestra el nombre de los canales que emiten mas de 2
prompt    documentales distintos el mismo dia. NOTA: recuerda que puedes
prompt    agrupar por columnas, pero también por expresiones (con
prompt    operadores, funciones, etc.).
prompt   

SELECT c.idCanal, c.nombre, COUNT(DISTINCT pg.codPrograma)
FROM ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal
JOIN ejb_programa pg ON pr.codPrograma = pg.codPrograma
WHERE pg.tipo = 'documental'
GROUP BY TO_CHAR(pr.fec_hora, 'DD-MM-YYYY'), c.nombre, c.idcanal
HAVING COUNT(DISTINCT pg.codPrograma) > 2;

prompt   
prompt 3. Muestra el nombre de los canales que han programado algún programa 
prompt    con una duracion mayor a la de 'Lo que el viento se llevo', junto con el
prompt    titulo del programa y su duracion.
prompt   

SELECT c.idCanal, c.nombre, pg.titulo, pg.duracion
FROM ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal
JOIN ejb_programa pg ON pr.codPrograma = pg.codPrograma
WHERE pg.duracion > 
      (SELECT duracion FROM ejb_programa pg2
      WHERE pg2.titulo = 'Lo que el viento se llevo');

prompt   
prompt 4. Muestra el titulo de los documentales que no se han emitido nunca en
prompt    el canal con nombre 'Antena Sexta'.
prompt   

SELECT DISTINCT pg.titulo
FROM ejb_programa pg
WHERE pg.tipo = 'documental' AND pg.codPrograma NOT IN 
      (SELECT pr2.codPrograma 
      FROM ejb_programacion pr2 JOIN ejb_canal c ON c.idCanal = pr2.idCanal
      WHERE c.nombre = 'Antena Sexta');

prompt   
prompt 5. Para los programas que se emiten en algún canal, muestra
prompt    el título del programa y el nombre del canal en el que se
prompt    emite de aquellos programas que cumplen la siguiente
prompt    condición: la duración del programa es mayor a la
prompt    duración media de los programas emitidos en ese mismo
prompt    canal.
prompt   

SELECT pg.titulo, c.nombre, c.idcanal, pg.duracion
FROM ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal
JOIN ejb_programa pg ON pr.codPrograma = pg.codPrograma
WHERE pg.duracion >
      (SELECT AVG(pg2.duracion)
      FROM ejb_canal c2 JOIN ejb_programacion pr2 ON c2.idCanal = pr2.idCanal
      JOIN ejb_programa pg2 ON pr2.codPrograma = pg2.codPrograma
      WHERE c2.nombre = c.nombre);

prompt   
prompt 6. Muestra el titulo de los programas de mayor duracion de cada tipo 
prompt    de los emitidos en el mismo mes en cualquier canal.
prompt   

SELECT DISTINCT pg.titulo, pg.duracion, pg.tipo
FROM ejb_programa pg JOIN ejb_programacion pr ON pg.codPrograma = pr.codPrograma
WHERE pg.duracion = 
      (SELECT MAX(pg2.duracion)
      FROM ejb_programa pg2 JOIN ejb_programacion pr2 ON pg2.codPrograma = pr2.codPrograma
      WHERE EXTRACT(MONTH FROM pr.fec_hora) = EXTRACT(MONTH FROM pr2.fec_hora) 
      AND EXTRACT(YEAR FROM pr.fec_hora) = EXTRACT(YEAR FROM pr2.fec_hora) 
      AND pg.tipo = pg2.tipo);

prompt   
prompt 7. Muestra los titulos de todos los programas, con el nombre del
prompt    canal y la fecha en la que han sido emitidos.  Si un programa no ha 
prompt    sido emitido nunca, se debe indicar como canal el texto 'NO EMITIDO'
prompt   

SELECT pg.titulo, NVL(c.nombre, 'NO EMITIDO'), pr.fec_hora
FROM ejb_programa pg LEFT JOIN (ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal)
ON pr.codPrograma = pg.codPrograma;

prompt   
prompt Se puede solucionar como una union de dos consultas:
prompt   

SELECT pg.titulo, c.nombre, pr.fec_hora
FROM ejb_programa pg JOIN (ejb_canal c JOIN ejb_programacion pr ON c.idCanal = pr.idCanal)
ON pr.codPrograma = pg.codPrograma
UNION
SELECT pg.titulo, 'NO EMITIDO', NULL
FROM ejb_programa pg 
WHERE pg.codPrograma NOT IN 
      (SELECT pr2.codPrograma
      FROM ejb_canal c JOIN ejb_programacion pr2 ON c.idCanal = pr2.idCanal);

prompt   
prompt 8. Muestra la lista de los errores de programación de TV:
prompt    aquellos programas (codprograma, canal y fecha/hora de 
prompt    emisión) que se solapan con otro en el tiempo en un mismo canal.
prompt    Debe mostrar aquellos programas que terminan después de la hora
prompt    de inicio del siguiente programa del mismo canal.  NOTA: para
prompt    sumar una cantidad de minutos a una fecha se debe utilizar la
prompt    siguiente expresion: fecha + minutos/1440.
prompt   

SELECT pr1.codprograma, pr1.fec_hora, pr2.codprograma, pr2.fec_hora, c.nombre
FROM ejb_programacion pr1 JOIN ejb_canal c ON pr1.idCanal = c.idCanal
JOIN ejb_programacion pr2 ON c.idCanal = pr2.idCanal
JOIN ejb_programa pg ON pr1.codPrograma = pg.codPrograma
WHERE pr1.idEmision != pr2.idEmision
AND pr1.fec_hora <= pr2.fec_hora
AND pr1.fec_hora + pg.duracion/1440 > pr2.fec_hora;



