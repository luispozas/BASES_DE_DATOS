-- ------------------------------------------------
-- Ejercicio 1. Creación de tablas.
-- ------------------------------------------------
DROP TABLE Prestamo CASCADE CONSTRAINTS;
DROP TABLE Ejemplar_Libro CASCADE CONSTRAINTS;
DROP TABLE Libro CASCADE CONSTRAINTS;
DROP TABLE Socio CASCADE CONSTRAINTS;

CREATE TABLE Socio
(NumSocio NUMBER(5) PRIMARY KEY,
 Nombre VARCHAR2(50) NOT NULL,
 MaxEjemplares NUMBER(3) NOT NULL,
 Edad NUMBER(3) NOT NULL);

CREATE TABLE Libro
(ISBN CHAR(15) PRIMARY KEY,
 Titulo VARCHAR2(50) NOT NULL,
 Autor VARCHAR2(50) NOT NULL,
 Genero VARCHAR2(50) NOT NULL);

CREATE TABLE Ejemplar_Libro
(IdEjemplar NUMBER(6) PRIMARY KEY,
 ISBN CHAR(15) NOT NULL REFERENCES Libro,
 FechaCompra DATE NOT NULL);

CREATE TABLE Prestamo
(Ejemplar NUMBER(6) REFERENCES Ejemplar_Libro,
 FechaPtmo DATE,
 NumSocio NUMBER(5) NOT NULL REFERENCES Socio,
 FechaVto DATE NOT NULL,
 CONSTRAINT Prestamo_PK PRIMARY KEY (Ejemplar,FechaPtmo));

alter session set nls_date_format='DD/MM/YYYY';

INSERT INTO Socio VALUES(1,'Arturo Pérez-Ramírez',3,57);
INSERT INTO Socio VALUES(2,'Andrés Iniesta García',25,32);
INSERT INTO Socio VALUES(3,'Fernando Alonso Fernández',2,35);
INSERT INTO Socio VALUES(4,'Miguel Induráin Ruiz',3,51);
INSERT INTO Socio VALUES(5,'Andrés Fiz Albert',3,59);
INSERT INTO Socio VALUES(6,'Ramón Bilbao Bilbao',3,23);
INSERT INTO Socio VALUES(7,'Rodrigo Rato de Guevara',3,61);

INSERT INTO Libro VALUES ('8233771378567', 'Todo bajo el cielo', 'Matilde Asensi', 'Historia');
INSERT INTO Libro VALUES ('1235271378662', 'La catedral del mar', 'Ildefonso Falcones', 'Historia');
INSERT INTO Libro VALUES ('0853477468299', 'La sangre de los inocentes', 'Julia Navarro','Historia');
INSERT INTO Libro VALUES ('1243415243666', 'Diez negritos', 'Agatha Christie','Misterio');
INSERT INTO Libro VALUES ('0482174555366', 'El nombre de la rosa', 'Umberto Eco','Misterio');
INSERT INTO Libro VALUES ('0482174555367', '2001 Una Odisea del Espacio', 'Arthur C. Clarke','Ciencia-ficción');
INSERT INTO Libro VALUES ('0482174555368', 'Cita con Rama', 'Arthur C. Clarke','Ciencia-ficción');
INSERT INTO Libro VALUES ('0482174555369', 'La fundación', 'Isaac Asimov','Ciencia-ficción');


INSERT INTO Ejemplar_Libro VALUES (1,'8233771378567', TO_DATE('01/01/2016'));
INSERT INTO Ejemplar_Libro VALUES (2,'1235271378662', TO_DATE('01/01/2016'));
INSERT INTO Ejemplar_Libro VALUES (3,'1235271378662', TO_DATE('01/06/2016'));
INSERT INTO Ejemplar_Libro VALUES (4,'1235271378662', TO_DATE('23/08/2016'));
INSERT INTO Ejemplar_Libro VALUES (5,'0853477468299', TO_DATE('05/06/2014'));
INSERT INTO Ejemplar_Libro VALUES (6,'1243415243666', TO_DATE('05/06/2014'));
INSERT INTO Ejemplar_Libro VALUES (7,'0482174555366', TO_DATE('05/06/1990'));
INSERT INTO Ejemplar_Libro VALUES (8,'0482174555366', TO_DATE('05/06/1990'));
INSERT INTO Ejemplar_Libro VALUES (9,'0482174555366', TO_DATE('22/05/1999'));
INSERT INTO Ejemplar_Libro VALUES (10,'0482174555366', TO_DATE('22/05/1999'));
INSERT INTO Ejemplar_Libro VALUES (11,'0482174555366', TO_DATE('30/01/2005'));
INSERT INTO Ejemplar_Libro VALUES (12,'0482174555366', TO_DATE('05/06/2015'));
INSERT INTO Ejemplar_Libro VALUES (13,'0482174555367', TO_DATE('05/06/2015'));
INSERT INTO Ejemplar_Libro VALUES (14,'0482174555368', TO_DATE('05/06/2015'));
INSERT INTO Ejemplar_Libro VALUES (15,'0482174555369', TO_DATE('05/06/2015'));

INSERT INTO Prestamo VALUES (1,TO_DATE('05/06/2015'),1,TO_DATE('31/12/2015'));
INSERT INTO Prestamo VALUES (1,TO_DATE('05/07/2016'),1,TO_DATE('31/12/2016'));
INSERT INTO Prestamo VALUES (3,TO_DATE('05/08/2016'),1,TO_DATE('31/12/2016'));
INSERT INTO Prestamo VALUES (6,TO_DATE('05/09/2016'),1,TO_DATE('31/12/2016'));

INSERT INTO Prestamo VALUES (2,TO_DATE('05/06/2015'),2,TO_DATE('15/06/2015'));
INSERT INTO Prestamo VALUES (14,TO_DATE('05/08/2016'),2,TO_DATE('31/12/2016'));
INSERT INTO Prestamo VALUES (8,TO_DATE('05/12/2016'),2,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (15,TO_DATE('05/12/2016'),2,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (13,TO_DATE('01/12/2016'),2,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (14,TO_DATE('02/12/2016'),2,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (3,TO_DATE('02/12/2016'),2,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (4,TO_DATE('15/12/2016'),2,TO_DATE('25/12/2016'));


INSERT INTO Prestamo VALUES (6,TO_DATE('05/10/2016'),3,TO_DATE('15/10/2016'));
INSERT INTO Prestamo VALUES (9,TO_DATE('05/11/2016'),4,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (12,TO_DATE('05/12/2016'),5,TO_DATE('15/12/2016'));
INSERT INTO Prestamo VALUES (4,TO_DATE('02/12/2016'),5,TO_DATE('15/12/2016'));

INSERT INTO Prestamo VALUES (6,TO_DATE('05/07/2016'),6,TO_DATE('15/07/2016'));
INSERT INTO Prestamo VALUES (9,TO_DATE('05/08/2016'),6,TO_DATE('15/08/2016'));
INSERT INTO Prestamo VALUES (12,TO_DATE('05/09/2016'),6,TO_DATE('15/09/2016'));
INSERT INTO Prestamo VALUES (15,TO_DATE('02/12/2016'),6,TO_DATE('15/12/2016'));


-- ------------------------------------------------
-- Ejercicio 2. Modificación de datos.
-- ------------------------------------------------

-- 2.1 Supongamos (solo para este apartado) que, además de las tablas
--     anteriores, existe una tabla COMPRAS con dos columnas,
--     ISBN y NumEjemplares sin claves ni restricciones
--     definidas. Escribe una sentencia SQL que inserte en COMPRAS
--     los ejemplares de libros que se deben comprar próximamente.  Deben
--     ser aquellos libros que han sido pedidos en préstamo al menos 15
--     veces desde el 1 de septiembre. Se debe comprar un ejemplar de
--     cada libro por cada 15 peticiones de préstamo.

CREATE TABLE Compras
(ISBN CHAR(15) NOT NULL,
 NumEjemplares NUMBER(3));

-- en lugar de 15 se utiliza 3 para poder probar con menos datos.
INSERT INTO Compras
SELECT ISBN, TRUNC(COUNT(*)/3)
FROM Ejemplar_Libro el JOIN Prestamo p ON el.IdEjemplar = p.Ejemplar
WHERE FechaPtmo >= TO_DATE('01/09/2016')
GROUP BY ISBN
HAVING COUNT(*) >= 3;

-- 2.2 Actualiza la información de la BD para incrementar en un 10% el
--     número máximo de ejemplares que pueden tomar prestados los socios
--     que han pedido prestados más de 5 ejemplares desde el 1 de
--     diciembre. 

UPDATE Socio SET MaxEjemplares = round(MaxEjemplares*1.1)
WHERE NumSocio IN (SELECT NumSocio FROM Prestamo
      WHERE FechaPtmo >= TO_DATE('01/12/2016')
      GROUP BY NumSocio 
      HAVING count(*) > 5);

-- ------------------------------------------------
-- Ejercicio 3. Consultas SQL.
-- ------------------------------------------------

-- 3.1 Listado de los ejemplares prestados
--     (IdEjemplar, FechaPtmo, FechaVto) durante el
--     tercer trimestre de 2016 que no han vencido a fecha de hoy
--     (SYSDATE). Los resultados deben estar ordenados por mes de
--     inicio del préstamo y, dentro de cada mes, por número de socio.

SELECT * FROM Prestamo 
WHERE FechaPtmo >= TO_DATE('01/07/2016') 
AND FechaPtmo <= TO_DATE('30/09/2016')
AND FechaVto >= SYSDATE
ORDER BY EXTRACT(MONTH FROM FechaPtmo), NumSocio;

-- 3.2 Listado de los libros que se han prestado durante 2016
--     y cuyo autor es \emph{Arthur C. Clarke}.

SELECT l.* FROM Libro l 
JOIN Ejemplar_libro el ON l.ISBN = el.ISBN
JOIN Prestamo p ON p.Ejemplar = el.IdEjemplar
WHERE EXTRACT(YEAR FROM p.FechaPtmo) = 2016 AND l.Autor LIKE '%Arthur C. Clarke%';

-- 3.3 Listado de los libros prestados en diciembre de
--     2016, mostrando el ISBN, título y número de veces que se han prestado
--     sus ejemplares a socios distintos. 

SELECT L.ISBN, L.Titulo, COUNT(distinct P.NumSocio) 
FROM Libro L JOIN Ejemplar_libro EL ON L.ISBN = EL.ISBN 
JOIN Prestamo P ON EL.IdEjemplar = P.Ejemplar
WHERE FechaPtmo >= '01/12/2016' AND FechaPtmo <= '31/12/2016'
GROUP BY L.ISBN, L.Titulo;


-- 3.4 Listado de los socios que han tomado en préstamo al
--     menos 10 ejemplares de libros durante el segundo semestre de 2016,
--     pero no tienen prestado ningún libro de misterio. 

SELECT S.NumSocio, S.Nombre 
FROM Socio S JOIN Prestamo P ON S.NumSocio = P.NumSocio
WHERE P.FechaPtmo >= TO_DATE('01/07/2016') AND  P.FechaPtmo <= TO_DATE('31/12/2016')
GROUP BY S.NumSocio, S.Nombre
HAVING COUNT(*) >= 10 AND S.NumSocio NOT IN (
       SELECT S2.NumSocio 
       FROM Socio S2 
       JOIN Prestamo P2 ON S2.NumSocio = P2.NumSocio 
       JOIN Ejemplar_libro EL2 ON P2.Ejemplar = EL2.IdEjemplar
       JOIN Libro L2 ON EL2.ISBN = L2.ISBN
       WHERE L2.Genero = 'Misterio');


-- 3.5 Listado de aquellos socios que más libros distintos
--     han tomado prestados respecto a los demás socios de su 
--     misma edad.

SELECT S.NumSocio, S.Nombre, S.Edad, COUNT(DISTINCT EL.ISBN)
FROM Socio S
JOIN Prestamo P ON S.NumSocio = P.NumSocio
JOIN Ejemplar_libro EL ON EL.IdEjemplar = P.Ejemplar
GROUP BY S.NumSocio, S.Nombre, S.Edad
HAVING COUNT(DISTINCT EL.ISBN) >= ALL (
       SELECT COUNT(DISTINCT EL2.ISBN)
       FROM Socio S2
       JOIN Prestamo P2 ON S2.NumSocio = P2.NumSocio
       JOIN Ejemplar_libro EL2 ON EL2.IdEjemplar = P2.Ejemplar
       WHERE S2.Edad = S.Edad
       GROUP BY S2.NumSocio
       );
       

-- 3.6 Listado con los autores de libros que han sido prestados a como
--     mucho 10 socios distintos entre el 1 de junio y el 31 de agosto
--     de 2016.  Además del nombre del autor, se debe mostrar el número de
--     préstamos a socios distintos y la edad del socio más joven que
--     ha tomado en préstamo uno de sus libros.

SELECT L.Autor, COUNT(DISTINCT P.NumSocio), MIN(S.Edad)
FROM Libro L 
JOIN Ejemplar_libro EL ON L.ISBN = EL.ISBN
JOIN Prestamo P ON EL.IdEjemplar = P.Ejemplar
JOIN Socio S ON P.NumSocio = S.NumSocio
WHERE fechaPtmo >= TO_DATE('01/06/2016') AND fechaPtmo <= TO_DATE('31/08/2016')
GROUP BY L.Autor
HAVING COUNT(DISTINCT P.NumSocio) <= 10;
