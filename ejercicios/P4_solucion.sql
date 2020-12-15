alter session set nls_date_format='DD/MM/YYYY';

-------------------------------------------------------
-- Tablas y datos iniciales.
-------------------------------------------------------

drop table c2d_Cliente cascade constraints;
drop table c2d_Pedido cascade constraints;
drop table c2d_Libro cascade constraints;
drop table c2d_Libros_Pedido cascade constraints;

create table c2d_Cliente
(IdCliente NUMBER(10) PRIMARY KEY,
 Nombre VARCHAR(25) NOT NULL
);
 
create table c2d_Pedido
(IdPedido NUMBER(10) PRIMARY KEY,
 IdCliente NUMBER(10) NOT NULL REFERENCES c2d_Cliente on delete cascade,
 FechaPedido DATE NOT NULL,
 FechaExped DATE);

create table c2d_Libro
(ISBN CHAR(15) PRIMARY KEY,
Titulo VARCHAR(60) NOT NULL,
Autor VARCHAR(60) NOT NULL,
Anio NUMBER(4) NOT NULL,
PrecioCompra NUMBER(6,2) DEFAULT 0,
PrecioVenta NUMBER(6,2) DEFAULT 0);

create table c2d_Libros_Pedido(
ISBN CHAR(15),
IdPedido NUMBER(10),
Cantidad NUMBER(3) CHECK (cantidad >0),
CONSTRAINT c2d_lp_PK PRIMARY KEY (ISBN, idPedido),
CONSTRAINT c2d_Libro_FK FOREIGN KEY (ISBN) REFERENCES c2d_Libro on delete cascade,
CONSTRAINT c2d_Pedido_FK FOREIGN KEY (IdPedido) REFERENCES c2d_Pedido on delete cascade);

-- -----------------------------------------------------------------------
--    a. Suponiendo que todas las tablas están vacías, indica las
--    sentencias necesarias para introducir la siguiente información:
--    se ha realizado un pedido con id 37 el día 11-12-2017 (que no se
--    ha expedido todavía) de dos ejemplares del libro 'Guerra y Paz'
--    de L. Tolstoi en su edición de 2011 (ISBN 9788420674407), con
--    precios de compra y venta de 12,25 y 15,20 euros,
--    respectivamente.  El cliente que ha realizado el pedido es Marta
--    García, con id 44.
--    Considera que los identificadores (excepto ISBN) e importes son
--    numéricos y las demás columnas son del tipo más adecuado para su
--    contenido.
-- -----------------------------------------------------------------------

INSERT INTO c2d_Cliente (IdCliente,Nombre)
       VALUES (44,'Marta Garcia');
INSERT INTO c2d_Pedido (IdPedido,IdCliente,FechaPedido,FechaExped)
       VALUES (37,44, TO_DATE('11/12/2017'),NULL);
INSERT INTO c2d_Libro (ISBN,Titulo,Autor,Anio,PrecioCompra,PrecioVenta)
       VALUES ('9788420674407', 'Guerra y Paz','L. Tolstoi', 2011, 12.25, 15.20);
INSERT INTO c2d_Libros_Pedido (ISBN,IdPedido,Cantidad)
       VALUES ('9788420674407',37,2);

-------------------------------------------------------
-- Datos para probar las demás consultas SQL
-------------------------------------------------------

insert into c2d_Cliente values (1,'Margarita Sanchez');
insert into c2d_Cliente values (2,'Angel Garcia');
insert into c2d_Cliente values (3,'Pedro Santillana');
insert into c2d_Cliente values (4,'Rosa Prieto');
insert into c2d_Cliente values (5,'Ambrosio Perez');
insert into c2d_Cliente values (6,'Lola Arribas');


insert into c2d_Pedido values (101,1, TO_DATE('01/12/2011'),TO_DATE('03/12/2011'));
insert into c2d_Pedido values (201,1, TO_DATE('01/12/2017'),null);
insert into c2d_Pedido values (301,2, TO_DATE('02/12/2017'),TO_DATE('03/12/2017'));
insert into c2d_Pedido values (401,4, TO_DATE('02/12/2011'),TO_DATE('05/12/2011'));
insert into c2d_Pedido values (501,5, TO_DATE('03/12/2017'),TO_DATE('03/12/2017'));
insert into c2d_Pedido values (601,3, TO_DATE('04/12/2017'),null);

insert into c2d_Libro values ('8233771378567', 'Todo bajo el cielo','Matilde Asensi', 2008, 9.45, 13.45);
insert into c2d_Libro values ('1235271378662', 'La catedral del mar','Ildefonso Falcones', 2009, 12.50, 19.25);
insert into c2d_Libro values ('4554672899910', 'La sombra del viento','Carlos Ruiz Zafon', 2002, 19.00, 33.15);
insert into c2d_Libro values ('5463467723747', 'Don Quijote de la Mancha','Miguel de Cervantes', 2000, 49.00, 73.45);
insert into c2d_Libro values ('0853477468299', 'La sangre de los inocentes','Julia Navarro', 2011, 9.45, 13.45);
insert into c2d_Libro values ('1243415243666', 'Los santos inocentes','Miguel Delibes', 1997, 10.45, 15.75);
insert into c2d_Libro values ('0482174555366', 'Noches Blancas','Fiodor Dostoievski', 1998, 4.00, 9.45);

insert into c2d_Libros_Pedido values ('8233771378567',101, 1);
insert into c2d_Libros_Pedido values ('5463467723747',101, 2);
insert into c2d_Libros_Pedido values ('0482174555366',201, 1);
insert into c2d_Libros_Pedido values ('4554672899910',301, 4);
insert into c2d_Libros_Pedido values ('8233771378567',301, 1);
insert into c2d_Libros_Pedido values ('1243415243666',301, 1);
insert into c2d_Libros_Pedido values ('8233771378567',401, 1);
insert into c2d_Libros_Pedido values ('4554672899910',501, 1);
insert into c2d_Libros_Pedido values ('1243415243666',501, 1);
insert into c2d_Libros_Pedido values ('5463467723747',501, 3);
insert into c2d_Libros_Pedido values ('1243415243666',601, 3); 
insert into c2d_Libros_Pedido values ('1235271378662',201, 1);

commit;

-- -----------------------------------------------------------------
-- b. Escribe una sentencia SQL que incremente un 5\% el precio
--    de venta de los libros cuyo precio de compra está por debajo de la
--    media de precios de compra de los libros editados después de 2010.
-- -----------------------------------------------------------------

update c2d_Libro set precioventa = 1.05*precioventa 
where preciocompra < 
  (select avg(preciocompra)
  from c2d_Libro l
  where l.Anio > 2010);

-- -----------------------------------------------------------------
-- c. Escribe una consulta que muestre el nombre de los
--    clientes y el número de autores distintos de los que han comprado
--    libros en 2017, en orden decreciente de número de autores.
-- -----------------------------------------------------------------

select c.Nombre, count(distinct l.Autor)
from c2d_Libro l 
join c2d_Libros_Pedido lp on l.isbn = lp.isbn
join c2d_Pedido p on lp.idPedido = p.idPedido
join c2d_Cliente c on p.idCliente = c.idCliente
where extract(year from p.FechaPedido) = 2017
group by c.Nombre, c.IdCliente
order by count(distinct l.Autor) desc;

-- -----------------------------------------------------------------
-- d. Escribe una consulta que muestre una lista de los
--    autores y el número de ejemplares vendidos de aquellos autores que
--    han vendido al menos tantos ejemplares como Miguel Delibes.
-- -----------------------------------------------------------------

select l.Autor, sum(lp.Cantidad)
from c2d_Libro l 
join c2d_Libros_Pedido lp on l.isbn = lp.isbn
group by l.Autor
having sum(lp.Cantidad) >= 
  (select sum(lp2.Cantidad)
  from c2d_Libro l2 
  join c2d_Libros_Pedido lp2 on l2.isbn = lp2.isbn
  where l2.Autor = 'Miguel Delibes');


-- -----------------------------------------------------------------
-- e. Escribe una consulta que muestre el nombre y número
--    de ejemplares pedidos en 2017 de aquellos clientes que solamente
--    han hecho pedidos de Miguel Delibes en ese mismo año.
-- -----------------------------------------------------------------

SELECT c.Nombre, SUM(lp.Cantidad)
FROM c2d_Libro l 
JOIN c2d_Libros_Pedido lp ON l.isbn = lp.isbn
JOIN c2d_Pedido p ON lp.idPedido = p.idPedido
JOIN c2d_Cliente c ON p.idCliente = c.idCliente
WHERE extract(year from p.FechaPedido) = 2017
AND l.Autor = 'Miguel Delibes'
AND c.idCliente NOT IN 
    (SELECT c2.idCliente
    FROM c2d_Libro l2 
    JOIN c2d_Libros_Pedido lp2 ON l2.isbn = lp2.isbn
    JOIN c2d_Pedido p2 ON lp2.idPedido = p2.idPedido
    JOIN c2d_Cliente c2 ON p2.idCliente = c2.idCliente
    WHERE extract(year from p2.FechaPedido) = 2017
    AND l2.Autor != 'Miguel Delibes')
group by c.Nombre, c.idCliente;


-- -----------------------------------------------------------------  
-- f. Escribe una consulta que muestre el título de los libros
--    vendidos en 2017 de los que se han vendido menos ejemplares.
-- -----------------------------------------------------------------

select l.titulo, SUM(lp.Cantidad)
from c2d_Libro l
join c2d_Libros_Pedido lp ON l.ISBN = lp.ISBN
JOIN c2d_Pedido p ON p.IdPedido = lp.IdPedido
WHERE EXTRACT(YEAR FROM p.fechaPedido) = 2017
GROUP BY l.ISBN, l.titulo
HAVING SUM(lp.Cantidad) <= ALL
      (select SUM(lp2.Cantidad)
      from c2d_Libros_Pedido lp2 JOIN c2d_Pedido p2 ON lp2.IdPedido = p2.IdPedido
      WHERE EXTRACT(YEAR FROM p2.fechaPedido) = 2017
      GROUP BY lp2.ISBN);




