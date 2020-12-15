-- ------------------------------------------------
-- Ejercicio 1. Creación de tablas.
-- ------------------------------------------------
DROP TABLE Resultado CASCADE CONSTRAINTS;
DROP TABLE Carrera CASCADE CONSTRAINTS;
DROP TABLE Tipo CASCADE CONSTRAINTS;
DROP TABLE Corredor CASCADE CONSTRAINTS;
DROP TABLE Historico CASCADE CONSTRAINTS;

CREATE TABLE Corredor
(NIF CHAR(10) PRIMARY KEY,
 Nombre VARCHAR2(25) NOT NULL,
 FecNacim DATE NOT NULL);

CREATE TABLE Tipo
(IdTipo CHAR(4) PRIMARY KEY,
 Descripcion VARCHAR2(50) NOT NULL);

CREATE TABLE Carrera
(IdCarrera NUMBER(5) PRIMARY KEY,
 Nombre VARCHAR2(50) NOT NULL,
 Fecha DATE NOT NULL,
 Tipo CHAR(4) NOT NULL REFERENCES Tipo);

CREATE TABLE Resultado
(NIF CHAR(10) REFERENCES Corredor,
 IdCarrera NUMBER(5) REFERENCES Carrera,
 Tiempo NUMBER(8,2) NOT NULL CHECK(Tiempo > 0),
 CONSTRAINT resultado_PK PRIMARY KEY (NIF,IdCarrera));

alter session set nls_date_format='DD/MM/YYYY';
INSERT INTO Corredor VALUES ('0123456789','Bikila', TO_DATE('25/01/1983'));
INSERT INTO Corredor VALUES ('0123456444','Carl Lewis', TO_DATE('01/07/1961'));
INSERT INTO Corredor VALUES ('0123456555','Caballo Blanco', TO_DATE('01/07/1985'));
INSERT INTO Corredor VALUES ('0123456666','Scott Jurek',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450001','Paula Radcliffe',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450002','Mo Farah',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450003','Jessica Ennis',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450004','Paula González',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450005','Alessandra Aguilar',TO_DATE('27/04/1981'));
INSERT INTO Corredor VALUES ('0123450006','Estela Navascués',TO_DATE('27/04/1981'));

INSERT INTO Tipo VALUES ('10K','Chatarrilla');
INSERT INTO Tipo VALUES ('21K','Media Maratón');
INSERT INTO Tipo VALUES ('42K','Maratón');
INSERT INTO Tipo VALUES ('ULT','Ultramaratón');
INSERT INTO Tipo VALUES ('100K','100 Km ultra');

INSERT INTO Carrera VALUES (1,'San Silvestre Vallecana 2016',TO_DATE('31/12/2016'),'10K');
INSERT INTO Carrera VALUES (2,'San Silvestre Vallecana 2015',TO_DATE('31/12/2015'),'10K');
INSERT INTO Carrera VALUES (3,'San Silvestre Vallecana 2014',TO_DATE('31/12/2014'),'10K');
INSERT INTO Carrera VALUES (4,'San Silvestre Vallecana 2013',TO_DATE('31/12/2013'),'10K');
INSERT INTO Carrera VALUES (5,'San Silvestre Vallecana 2012',TO_DATE('31/12/2012'),'10K');

INSERT INTO Carrera VALUES (6,'San Lorenzo 2016',TO_DATE('18/07/2016'),'10K');
INSERT INTO Carrera VALUES (7,'San Lorenzo 2015',TO_DATE('28/07/2015'),'10K');
INSERT INTO Carrera VALUES (8,'100 Km de Santander - Cantabria',TO_DATE('25/07/2016'),'100K');
INSERT INTO Carrera VALUES (9,'Media Maratón Ciudad de Segovia',TO_DATE('19/09/2015'),'21K');
INSERT INTO Carrera VALUES (10,'San Lorenzo 2014',TO_DATE('25/07/2014'),'10K');
INSERT INTO Carrera VALUES (11,'Media Maratón Ciudad Universitaria 2016',TO_DATE('13/03/2016'),'21K');
INSERT INTO Carrera VALUES (12,'Media Maratón Ciudad Universitaria 2015',TO_DATE('08/03/2015'),'21K');
INSERT INTO Carrera VALUES (13,'Media Maratón Ciudad Universitaria 2014',TO_DATE('09/03/2014'),'21K');

INSERT INTO Resultado VALUES ('0123456789',1, 31.58);
INSERT INTO Resultado VALUES ('0123456789',2, 31.58);
INSERT INTO Resultado VALUES ('0123456789',3, 31.58);
INSERT INTO Resultado VALUES ('0123456789',4, 31.58);
INSERT INTO Resultado VALUES ('0123456789',5, 31.58);
INSERT INTO Resultado VALUES ('0123456789',6, 31.58);
INSERT INTO Resultado VALUES ('0123456789',10, 32.48);

INSERT INTO Resultado VALUES ('0123456444',2, 33.44);
INSERT INTO Resultado VALUES ('0123456444',3, 33.45);
INSERT INTO Resultado VALUES ('0123456444',5, 33.46);
INSERT INTO Resultado VALUES ('0123456444',11, 75.24);
INSERT INTO Resultado VALUES ('0123456444',12, 71.44);
INSERT INTO Resultado VALUES ('0123456444',13, 70.28);

INSERT INTO Resultado VALUES ('0123456789',11, 75.24);
INSERT INTO Resultado VALUES ('0123456555',11, 75.24);
INSERT INTO Resultado VALUES ('0123456666',11, 75.24);


INSERT INTO Resultado VALUES ('0123456555',8,650.0);
INSERT INTO Resultado VALUES ('0123456555',12,68.05);
INSERT INTO Resultado VALUES ('0123456555',13,65.55);
INSERT INTO Resultado VALUES ('0123456666',9,63.25);
INSERT INTO Resultado VALUES ('0123456666',13,58.33);
INSERT INTO Resultado VALUES ('0123456666',6,30.24);

INSERT INTO Resultado VALUES ('0123450001',11,33.24);
INSERT INTO Resultado VALUES ('0123450002',11,33.25);
INSERT INTO Resultado VALUES ('0123450003',11,33.26);
INSERT INTO Resultado VALUES ('0123450004',11,33.27);
INSERT INTO Resultado VALUES ('0123450005',11,33.28);
INSERT INTO Resultado VALUES ('0123450006',11,33.29);
-- ------------------------------------------------
-- Ejercicio 2. Creación de tablas.
-- ------------------------------------------------

-- 2.1 Dada una tabla HISTORICO con la misma estructura que la
--     tabla RESULTADO, escribe una sentencia SQL que inserte en
--     HISTORICO todos los resultados de carreras de fechas 
--     anteriores a 2016.
CREATE TABLE Historico
(NIF CHAR(10) REFERENCES Corredor,
 IdCarrera NUMBER(5) REFERENCES Carrera,
 Tiempo NUMBER(8,2) NOT NULL CHECK(Tiempo > 0),
 CONSTRAINT historico_PK PRIMARY KEY (NIF,IdCarrera)); -- errata corregida: historico_PK

INSERT INTO Historico
SELECT re.NIF, re.IDCARRERA, re.TIEMPO
FROM Resultado re 
JOIN Carrera ca ON re.IdCarrera = ca.IdCarrera
WHERE ca.Fecha < TO_DATE('01/01/2016');

-- 2.2 Debido a un error en el cronómetro oficial de algunas carreras,
--     algunas medidas de tiempos se deben corregir. Proporciona una
--     sentencia SQL que actualice la columna Tiempo incrementándolo
--     en un 15% para las carreras con IdCarrera con valor 3 y 5.

UPDATE Resultado SET Tiempo = Tiempo * 1.15 
WHERE IdCarrera IN (3,5);

-- ------------------------------------------------
-- Ejercicio 3. Consultas SQL.
-- ------------------------------------------------

-- 3.1 Listado con los datos de las carreras del segundo
--     semestre de 2016, ordenadas por tipo. Dentro de cada tipo, deben
--     aparecer en orden cronológico inverso.
  SELECT IdCarrera, Nombre, Tipo, Fecha FROM Carrera
  WHERE Fecha BETWEEN TO_DATE('30/06/2016') AND TO_DATE('31/12/2016')
  ORDER BY Tipo, Fecha DESC;

-- 3.2 Listado con los corredores que han participado en la
--     carrera 'San Lorenzo 2016' y que han nacido entre 1980 y 1990.
  SELECT co.NIF, co.Nombre, re.Tiempo
  FROM Corredor co
  JOIN Resultado re ON co.NIF = re.NIF
  JOIN Carrera ca ON ca.IdCarrera = re.IdCarrera
  WHERE ca.Nombre = 'San Lorenzo 2016'
  AND FecNacim BETWEEN TO_DATE('01/01/1980') AND TO_DATE('31/12/1990');

-- 3.3 Listado de los corredores que han participado en
--     carreras con \code{IdTipo = '21K'}, proporcionando el mejor
--     tiempo y el tiempo medio de cada corredor.
-- En esta consulta no es necesario utilizar la tabla Tipo porque, aunque 
-- nos piden una condición sobre la columna Tipo.IdTipo, la tabla Carrera
-- tiene una clave externa sobre la columna Carrear.Tipo que 
-- obligatoriamente debe tomar el mismo valor que Tipo.IdTipo en la fila
-- correspondiente.
  SELECT co.NIF, co.Nombre, AVG(re.Tiempo), MIN(re.Tiempo)
  FROM Corredor co
  JOIN Resultado re ON co.NIF = re.NIF
  JOIN Carrera ca ON ca.IdCarrera = re.IdCarrera
  WHERE ca.Tipo = '21K'
  GROUP BY co.NIF, co.Nombre;

-- 3.4 Listado de los corredores que han participado en
--     alguna carrera de tipo \code{'Media Maratón'}, pero nunca han
--     participado en una \emph{San Silvestre
-- En este caso se deben relacionar dos filas diferentes de la tabla 
-- Carrera sobre un mismo corredor (además de las filas asociadas de la 
-- tabla Tipo para obtener la descripción del tipo de carrera).
-- Por una parte, se hacen reuniones para evaluar la primera 
-- condición ("corredores que han participado en alguna carrera ...").
-- Por otra parte, para evaluar la segunda condición ("pero nunca han
-- participado en una ...") se utiliza una subconsulta porque se debe 
-- evaluar información que no está en la BD (la ausencia de información
-- de ese corredor relativa a carreras San Silvestre).
  SELECT DISTINCT co.NIF, co.Nombre
  FROM Corredor co
  JOIN Resultado re ON co.NIF = re.NIF
  JOIN Carrera ca ON ca.IdCarrera = re.IdCarrera
  JOIN Tipo ti ON ti.IdTipo = ca.Tipo
  WHERE ti.Descripcion = 'Media Maratón'
  AND co.NIF NOT IN (
    SELECT re2.NIF FROM Resultado re2
    JOIN Carrera ca2 ON re2.IdCarrera = ca2.IdCarrera
    WHERE ca2.Nombre LIKE '%San Silvestre%');

-- 3.5 Listado de los mejores corredores de su misma
--     edad: debe mostrar el nombre de los corredores y las carreras en las
--     que han participado en las que han obtenido el mejor tiempo de todos
--     los corredores que nacieron el mismo año que ellos. Para extraer el
--     año de una fecha puedes utilizar la función EXTRACT(YEAR FROM
--     fecha).
-- En este caso es necesario utilizar una subconsulta correlacionada
-- para obtener el mejor tiempo (en la misma carrera) de los corredores 
-- de la misma edad que el corredor que se muestra como resultado.
-- La correlación se produce sobre las columnas IdCarrera y FecNacim.
  SELECT co.NIF, ca.Nombre, re.Tiempo
  FROM Corredor co
  JOIN Resultado re ON co.NIF = re.NIF
  JOIN Carrera ca ON ca.IdCarrera = re.IdCarrera
  WHERE re.Tiempo = (
    SELECT MIN(re2.Tiempo) FROM Resultado re2
    JOIN Corredor co2 ON re2.NIF = co2.NIF
    JOIN Carrera ca2 ON ca2.IdCarrera = re2.IdCarrera
    WHERE ca2.IdCarrera = ca.IdCarrera 
    AND EXTRACT(YEAR FROM co2.FecNacim) = EXTRACT(YEAR FROM co.FecNacim));

-- 3.6 Listado de los tipos de carreras en los que han
--     participado al menos 10 corredores distintos en el año 2016. Además
--     de la descripción del tipo, debe mostrar el número de corredores y
--     el tiempo medio obtenido.
-- En esta consulta es necesario evaluar condiciones en las
-- cláusulas WHERE y HAVING: La condición sobre el año de
-- celebración de las carreras se debe evaluar *antes* de agrupar por
-- tipo de carrera.  La condición sobre el número de corredores distintos
-- se debe evaluar *después* de agrupar.
  SELECT ti.Descripcion, COUNT(DISTINCT re.NIF), AVG(re.Tiempo)
  FROM Tipo ti
  JOIN Carrera ca ON ca.Tipo = ti.IdTipo
  JOIN Resultado re ON re.IdCarrera = ca.IdCarrera
  WHERE ca.Fecha BETWEEN TO_DATE('01/01/2016') AND TO_DATE('31/12/2016')
  GROUP BY ti.Descripcion
  HAVING COUNT(DISTINCT re.NIF) >=10;
