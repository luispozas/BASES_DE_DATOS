alter session set nls_date_format='DD/MM/YYYY';

drop table certificado cascade constraints;
drop table empleado cascade constraints;
drop table avion cascade constraints;
drop table vuelo cascade constraints;

create table vuelo(
	flno number(4,0) primary key,
	origen varchar2(20),
	destino varchar2(20),
	distancia number(6,0),
	salida date,
	llegada date,
	precio number(7,2));

create table avion(
	aid number(9,0) primary key,
	nombre varchar2(30),
	autonomia number(6,0));

create table empleado(
	eid number(9,0) primary key,
	nombre varchar2(30),
	salario number(10,2));

create table certificado(
	eid number(9,0),
	aid number(9,0),
	primary key(eid,aid),
	foreign key(eid) references empleado,
	foreign key(aid) references avion); 



INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (99.0,'Los Angeles','Washington D.C.',2308.0,to_date('04/12/2005 09:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:40', 'dd/mm/yyyy HH24:MI'),235.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (13.0,'Los Angeles','Chicago',1749.0,to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (346.0,'Los Angeles','Dallas',1251.0,to_date('04/12/2005 11:50', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),225-43);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (387.0,'Los Angeles','Boston',2606.0,to_date('04/12/2005 07:03', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 05:03', 'dd/mm/yyyy HH24:MI'),261.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (7.0,'Los Angeles','Sydney',7487.0,to_date('04/12/2005 05:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:10', 'dd/mm/yyyy HH24:MI'),278.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (2.0,'Los Angeles','Tokyo',5478.0,to_date('04/12/2005 06:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:55', 'dd/mm/yyyy HH24:MI'),780.99);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (33.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 09:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:15', 'dd/mm/yyyy HH24:MI'),375.23);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (34.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 12:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:18', 'dd/mm/yyyy HH24:MI'),425.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (76.0,'Chicago','Los Angeles',1749.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:03', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (68.0,'Chicago','New York',802.0,to_date('04/12/2005 09:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:02', 'dd/mm/yyyy HH24:MI'),202.45);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (7789.0,'Madison','Detroit',319.0,to_date('04/12/2005 06:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:19', 'dd/mm/yyyy HH24:MI'),120.33);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (701.0,'Detroit','New York',470.0,to_date('04/12/2005 08:55', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:26', 'dd/mm/yyyy HH24:MI'),180.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (702.0,'Madison','New York',789.0,to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),202.34);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (4884.0,'Madison','Chicago',84.0,to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:02', 'dd/mm/yyyy HH24:MI'),112.45);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (2223.0,'Madison','Pittsburgh',517.0,to_date('04/12/2005 08:02', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:01', 'dd/mm/yyyy HH24:MI'),189.98);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (5694.0,'Madison','Minneapolis',247.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:33', 'dd/mm/yyyy HH24:MI'),120.11);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (304.0,'Minneapolis','New York',991.0,to_date('04/12/2005 10:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 01:39', 'dd/mm/yyyy HH24:MI'),101.56);

INSERT INTO VUELO (FLNO, ORIGEN, DESTINO, DISTANCIA, SALIDA, LLEGADA, PRECIO) VALUES (149.0,'Pittsburgh','New York',303.0,to_date('04/12/2005 09:42', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:09', 'dd/mm/yyyy HH24:MI'),1165.00);

Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('1','Boeing 747-400','8430');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('3','Airbus A340-300','7120');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('4','British Aerospace Jetstream 41','1502');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('5','Embraer ERJ-145','1530');
Insert into AVION (AID,NOMBRE,AUTONOMIA) values ('7','Piper Archer III','520');


Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('567354612','Lisa Walker','256481');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('254099823','Patricia Jones','223000');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('355548984','Angela Martinez','212156');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('310454876','Joseph Thompson','212156');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('269734834','George Wright','289950');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('552455348','Dorthy Lewis','251300');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('486512566','David Anderson','43001');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('573284895','Eric Cooper','114323');
Insert into EMPLEADO (EID,NOMBRE,SALARIO) values ('574489457','Milo Brooks','20');


Insert into CERTIFICADO (EID,AID) values ('269734834','1');
Insert into CERTIFICADO (EID,AID) values ('269734834','3');
Insert into CERTIFICADO (EID,AID) values ('269734834','4');
Insert into CERTIFICADO (EID,AID) values ('269734834','5');
Insert into CERTIFICADO (EID,AID) values ('269734834','7');
Insert into CERTIFICADO (EID,AID) values ('567354612','1');
Insert into CERTIFICADO (EID,AID) values ('567354612','3');
Insert into CERTIFICADO (EID,AID) values ('567354612','4');
Insert into CERTIFICADO (EID,AID) values ('567354612','5');
Insert into CERTIFICADO (EID,AID) values ('567354612','7');
Insert into CERTIFICADO (EID,AID) values ('573284895','3');
Insert into CERTIFICADO (EID,AID) values ('573284895','4');
Insert into CERTIFICADO (EID,AID) values ('573284895','5');
Insert into CERTIFICADO (EID,AID) values ('574489457','7');

commit;



-- 1. Codigo y nombre de los pilotos certificados para pilotar aviones Boeing.

SELECT e.eid, e.nombre
FROM certificado c join empleado e on(c.eid = e.eid) join avion a on(a.aid = c.aid)
WHERE a.nombre LIKE '%Boeing%';

--2. Codigo de aviones que pueden hacer el recorrido de Los Angeles a Chicago sin repostar.

SELECT a.aid, a.nombre
FROM avion a
WHERE a.autonomia >= (SELECT MAX(distancia)
                      FROM vuelo v
                      WHERE v.origen = 'Los Angeles' and v.destino = 'Chicago');

--3. Pilotos certificados para operar con aviones con una autonomia superior a 3000 millas pero no certificados
--para aviones Boeing.

SELECT e.eid, e.nombre
FROM  certificado c join empleado e on(c.eid = e.eid) join avion a on(a.aid = c.aid)
WHERE a.autonomia > 3000 and e.eid NOT IN (SELECT c1.eid
                                           FROM avion a1 join certificado c1 on (a1.aid = c1.aid)
                                           WHERE a1.nombre LIKE '%Boeing%');

--4.  Empleados con el salario más elevado.

SELECT e.eid, e.nombre, e.salario
FROM empleado e
WHERE e.salario = (SELECT MAX(salario)
                   FROM empleado e1);
                   
--5.  Empleados con el segundo salario más alto.

SELECT e.eid, e.nombre, e.salario
FROM empleado e
WHERE e.salario = (SELECT MAX(salario)
                   FROM empleado e1
                   WHERE e1.salario NOT IN (SELECT MAX(e2.salario)
                                            FROM empleado e2));


--6.  Empleados con mayor número de certificaciones para volar.

SELECT e.eid, e.nombre, COUNT(*) as Numero_certificaciones
FROM certificado c join empleado e on (c.eid = e.eid)
GROUP BY e.eid, e.nombre
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                        FROM certificado c1 join empleado e1 on(c1.eid = e1.eid)
                        GROUP BY e1.eid); 


--7.  Empleados certificados para 3 modelos de avión.

SELECT e.eid, e.nombre, COUNT(*) as Numero_Aviones_Certificados
FROM certificado c join empleado e on (c.eid = e.eid)
GROUP BY e.eid, e.nombre
HAVING COUNT(DISTINCT c.aid) >= 3
ORDER BY Numero_Aviones_Certificados DESC;

--8.  Nombre de los aviones tales que todos los pilotos certificados para operar
--con ellos tengan salarios superiores a 80.000 euros.

SELECT a.aid, a.nombre
FROM avion a
WHERE NOT EXISTS (SELECT e.eid
                  FROM empleado e join certificado c on(e.eid = c.eid)
                  WHERE c.aid = a.aid AND e.eid NOT IN (SELECT e1.eid
                                                        FROM empleado e1 join certificado c1 on(e1.eid = c1.eid)
                                                        WHERE c1.aid = a.aid and e1.salario > 80000));

--9.  Para cada piloto certificado para operar con más de 3 modelos de avión
--indicar el código de empleado y la autonomía máxima de los aviones que puede pilotar.

SELECT e.eid, e.nombre, MAX(a.autonomia) as autonomia_Maxima
FROM certificado c join empleado e on (c.eid = e.eid) join avion a on (a.aid = c.aid)
GROUP BY e.eid, e.nombre
HAVING COUNT(DISTINCT c.aid) > 3;


--10. Nombre de los pilotos cuyo salario es inferior a la ruta más barata entre
-- Los Ángeles y Honolulu.

SELECT e.eid, e.nombre, e.salario
FROM certificado c join empleado e on (c.eid = e.eid)
WHERE e.salario < (SELECT MIN(v.precio)
                   FROM vuelo v
                   WHERE v.origen = 'Los Angeles' and v.destino = 'Honolulu');


--11. Mostrar el nombre de los aviones con autonomía de vuelo superior a 1.000
--millas junto con la media salarial de los pilotos certificados en dichos
--aviones.

SELECT a.aid, a.nombre, AVG(e.salario) as Salario_Medio
FROM certificado c join empleado e on (c.eid = e.eid) join avion a on (a.aid = c.aid)
WHERE a.autonomia > 1000
GROUP BY a.aid, a.nombre
ORDER BY a.aid DESC;


--12. Calcular la diferencia entre la media salarial de todos los empleados
--(incluidos los pilotos) y la de los pilotos.

SELECT Media_Todos - Media_Pilotos as Diferencia
FROM (SElECT AVG(e.salario) as Media_Todos
      FROM empleado e) CROSS JOIN (SELECT AVG(e1.salario) as Media_Pilotos
                                     FROM empleado e1 
                                     WHERE e1.eid IN (SELECT c.eid
                                                      FROM certificado c));

--   ***   OJO!! CROSS JOIN DEBE DE HACERLO CON CONSULTAS QUE DEVUELVEN 1 FILA y 1 COLUMNA PARA PODER RESTAR.
--   ***   EN LA SEGUNDA CONSULTA SELECT PARA HACER LO ANTERIOR DEBE DE IR CON UNA ANIDADA
--         PARA DEVOLVER EL SALARIO DE LOS EMPLEADOS SIN REPETIR YA QUE SI LO METEMOS CON "JOIN ON"
--         SE REPETIRIA EL SALARIO TANTAS VECES COMO CERTIFICADOS TENGA CADA PERSONA.


--13. Listar el nombre y los salarios de los empleados (no pilotos) cuyo salario
--sea superior a la media salarial de los pilotos.

SELECT e.nombre, e.salario
FROM empleado e
WHERE e.eid NOT IN (SELECT c.eid FROM certificado c) and e.salario > (SELECT AVG(e1.salario)
                                                                    FROM empleado e1 
                                                                    WHERE e1.eid IN (SELECT c1.eid
                                                                                     FROM certificado c1));
                 
                 
--14. Nombre de los pilotos certificados solo para modelos con autonomía superior a 1.000 millas. 

SELECT DISTINCT e.nombre
FROM certificado c join empleado e on (c.eid = e.eid)
WHERE NOT EXISTS (SELECT c1.eid
                  FROM certificado c1 join avion a1 on ( a1.aid = c1.aid)
                  WHERE c.eid = c1.eid and a1.autonomia <= 1000);



                 
