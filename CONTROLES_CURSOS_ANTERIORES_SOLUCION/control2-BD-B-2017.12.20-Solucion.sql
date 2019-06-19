DROP TABLE c2b_aula CASCADE CONSTRAINTS;
DROP TABLE c2b_colaboracion CASCADE CONSTRAINTS;
DROP TABLE c2b_asignatura CASCADE CONSTRAINTS;
DROP TABLE c2b_alumno CASCADE CONSTRAINTS;

-- ------------------------------------------------------------
-- a. Proporciona las sentencias SQL necesarias para crear las tablas
-- correspondientes, suponiendo lo siguiente: como máximo se va a
-- almacenar información sobre 2000 alumnos y 110 asignaturas, todos
-- los alumnos obligatoriamente reciben beca y todas las asignaturas
-- tienen créditos asociados.  Todos los identificadores son
-- numéricos.
-- ---------------------------------------------------------

CREATE TABLE c2b_alumno (
       idAlumno NUMBER(5,0) PRIMARY KEY,
       nombre VARCHAR2(50),
       beca NUMBER(10,2), -- beca mensual.
       CONSTRAINT chk_c2b_alumno CHECK (beca > 0)
);

CREATE TABLE c2b_asignatura (
       idAsignatura NUMBER(5,0) PRIMARY KEY,
       descr VARCHAR2(50),
       departamento VARCHAR2(20),
       creditos NUMBER(2,0),
       CONSTRAINT chk_c2b_asignatura CHECK (creditos > 0)
);

CREATE TABLE c2b_colaboracion (
       idAlumno NUMBER(5,0) REFERENCES c2b_alumno,
       idAsignatura NUMBER(5,0) REFERENCES c2b_asignatura,
       horas NUMBER(3,0),
       CONSTRAINT pk_c2b_colaboracion PRIMARY KEY (idAlumno, idAsignatura)
);

CREATE TABLE c2b_aula (
       idAlumno NUMBER(5,0),
       idAsignatura NUMBER(5,0),
       idAula NUMBER(5,0),
       CONSTRAINT pk_c2b_aula PRIMARY KEY (idAlumno, idAsignatura, idAula),
       CONSTRAINT fk_c2b_pt_aula FOREIGN KEY (idAlumno, idAsignatura) REFERENCES c2b_colaboracion
);


ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
INSERT INTO c2b_alumno VALUES (1, 'Astrid Almendros', 825.0);
INSERT INTO c2b_alumno VALUES (2, 'Manuel Sanchez', 315.25);
INSERT INTO c2b_alumno VALUES (3,'Marta Sanchez', 520.0);
INSERT INTO c2b_alumno VALUES (4,'Alberto San Gil', 570.0);
INSERT INTO c2b_alumno VALUES (5,'Maria Puente', 640.0);
INSERT INTO c2b_alumno VALUES (6,'Juan Panero', 820.0);
INSERT INTO c2b_alumno VALUES (7,'John Doe', 345.0);

INSERT INTO c2b_asignatura VALUES (201,'Tecnologia de Programacion','SIC/ISIA',12);
INSERT INTO c2b_asignatura VALUES (202,'Bases de Datos','SIC/ISIA',6);
INSERT INTO c2b_asignatura VALUES (203,'Programacion Concurrente','SIC',6);
INSERT INTO c2b_asignatura VALUES (204,'Programacion Declarativa','SIC',6);


INSERT INTO c2b_colaboracion VALUES (1,201,17);
INSERT INTO c2b_colaboracion VALUES (2,201,25);
INSERT INTO c2b_colaboracion VALUES (3,201,35);
INSERT INTO c2b_colaboracion VALUES (4,201,22);

INSERT INTO c2b_colaboracion VALUES (2,202,15);

INSERT INTO c2b_colaboracion VALUES (1,203,10);
INSERT INTO c2b_colaboracion VALUES (6,203,20);

INSERT INTO c2b_colaboracion VALUES (4,204,18);
INSERT INTO c2b_colaboracion VALUES (5,204,35);
INSERT INTO c2b_colaboracion VALUES (6,204,20);
INSERT INTO c2b_colaboracion VALUES (2,204,20);
INSERT INTO c2b_colaboracion VALUES (7,204,30);

INSERT INTO c2b_aula VALUES (1,201,3);
INSERT INTO c2b_aula VALUES (1,203,4);
INSERT INTO c2b_aula VALUES (6,203,5);
INSERT INTO c2b_aula VALUES (6,204,5);

COMMIT;


-- -----------------------------------------------------------------------
-- b. Escribe una sentencia SQL que incremente un 5\% la beca de los
--    alumnos que colaboran en más de 3 asignaturas y más de 50 horas
--    en total.
-- -----------------------------------------------------------------------

UPDATE c2b_alumno SET beca = beca * 1.05 
WHERE idAlumno IN 
  (SELECT idAlumno 
  FROM c2b_colaboracion c
  GROUP BY idAlumno
  HAVING COUNT(*) >= 3 AND SUM(c.horas) > 50);

-- -----------------------------------------------------------------------
-- c. Escribe una consulta que muestre los departamentos y los alumnos
--    que colaboran en sus asignaturas de 12 créditos.
-- -----------------------------------------------------------------------

SELECT ag.departamento, a.nombre, a.idAlumno
FROM c2b_asignatura ag
JOIN c2b_colaboracion c ON ag.idAsignatura = c.idAsignatura
JOIN c2b_alumno a ON a.idAlumno = c.idAlumno
WHERE ag.creditos = 12;

-- -----------------------------------------------------------------------
-- d. Escribe una consulta SQL que muestre el nombre de los
--    alumnos y el total de horas de todas sus colaboraciones, solo para
--    aquellos alumnos con beca superior a 300 euros y que colaboran en al
--    menos una asignatura de más de 9 créditos.
-- -----------------------------------------------------------------------

SELECT a.Nombre, SUM(c.horas)
FROM c2b_alumno a
JOIN c2b_colaboracion c ON a.idAlumno = c.idAlumno
JOIN c2b_asignatura ag ON ag.idAsignatura = c.idAsignatura
WHERE a.beca > 300
GROUP BY a.nombre, a.idAlumno
HAVING MAX(ag.creditos) > 9;

-- -----------------------------------------------------------------------
-- e. Escribe una consulta que muestre el nombre  de aquellos
-- alumnos que no colaboran en ninguna asignatura en la que colabora
-- 'John Doe'.
-- -----------------------------------------------------------------------

SELECT a.Nombre, a.idAlumno
FROM c2b_alumno a
WHERE a.idAlumno NOT IN
      (SELECT a2.idAlumno
      FROM c2b_alumno a2
      JOIN c2b_colaboracion c2 ON a2.idAlumno = c2.idAlumno
      JOIN c2b_colaboracion c3 ON c3.idAsignatura = c2.idAsignatura
      JOIN c2b_alumno a3 ON c3.idAlumno = a3.idAlumno
      WHERE a3.Nombre = 'John Doe');

-- -----------------------------------------------------------------------
-- f. Escribe una consulta que muestre las asignaturas dentro de cada
--    departamento en las que más horas colaboran los alumnos. Debe mostrar
--    el nombre de la asignatura y el departamento.
-- -----------------------------------------------------------------------

SELECT ag.descr, ag.departamento, sum(c.horas)
FROM c2b_asignatura ag
JOIN c2b_colaboracion c ON ag.idAsignatura = c.idAsignatura
GROUP BY ag.descr, ag.idAsignatura, ag.departamento
HAVING sum(c.horas) >= ALL
       (SELECT SUM(c2.horas)
       FROM c2b_colaboracion c2
       JOIN c2b_asignatura ag2 ON c2.idAsignatura = ag2.idAsignatura
       WHERE ag2.departamento = ag.departamento
       GROUP BY c2.idAsignatura);





