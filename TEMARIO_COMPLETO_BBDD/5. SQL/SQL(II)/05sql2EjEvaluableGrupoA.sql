-- -------------------------------------------------------------
-- EJERCICIO EVALUABLE GRUPO A. 30.11.2018
-- -------------------------------------------------------------
alter session set nls_date_format = 'DD/MM/YYYY';

drop table ej_noticia cascade constraints;
drop table ej_autor cascade constraints;
drop table ej_periodico cascade constraints;

create table ej_periodico(
    IdPer integer primary key,
    Nombre varchar2(50),
    url varchar2(200),
    Idioma varchar2(3) -- puede ser 'en' (inglés), 'es' (español), 'fr', etc.
);

create table ej_autor(
    IdAutor integer primary key,
    nombre varchar2(30)
);

create table ej_noticia(
    IdNoticia integer primary key,
    titular varchar2(100),
    url varchar2(200),
    IdPer references ej_periodico,
    IdAutor references ej_autor,
    FechaPub date,
    NumVisitas integer
);


INSERT INTO ej_periodico VALUES (1, 'El Noticiero', 'http://www.elnoticiero.es','es');
INSERT INTO ej_periodico VALUES (2, 'El Diario de Zaragoza', 'http://www.diariozaragoza.es','es');
INSERT INTO ej_periodico VALUES (3, 'La Gaceta', 'http://www.gacetaguadalajara.es','en');
INSERT INTO ej_periodico VALUES (4, 'Toledo Tribune', 'http://www.toledotribune.es','en');
INSERT INTO ej_periodico VALUES (5, 'Alvarado Times', 'http://www.alvaradotimes.es','en');
INSERT INTO ej_periodico VALUES (6, 'El Retiro Noticias', 'http://www.elretironoticias.es','es');

insert into ej_autor values (201,'Margarita Sanchez');
insert into ej_autor values (203,'Pedro Santillana');
insert into ej_autor values (204,'Rosa Prieto');
insert into ej_autor values (206,'Lola Arribas');

INSERT INTO ej_noticia VALUES (101, 'El Banco de Inglaterra advierte de los peligros del Brexit',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 370);
INSERT INTO ej_noticia VALUES (102, 'La UE acabará con el 100% de las emisiones de CO2 para 2050',
			   'http://www.elnoticiero.es/ibex9000',
			   1,204, TO_DATE('01/06/2018'), 1940);
INSERT INTO ej_noticia VALUES (103, 'Madrid Central starts tomorrow',
			   'http://www.gacetaguadalajara.es/nacional24',
			   3,201, TO_DATE('01/06/2018'), 490);
INSERT INTO ej_noticia VALUES (104, 'El Ayuntamiento prepara diez nuevos carriles bici',
			   'http://www.diariozaragoza.es/movilidad33',
			   2,203, TO_DATE('01/06/2018'), 2300);
INSERT INTO ej_noticia VALUES (105, 'Un aragonés cruzará Siberia, de punta a punta en bici',
			   'http://www.diariozaragoza.es/ibex9000',
			   2,203, TO_DATE('01/11/2018'), 2300);
INSERT INTO ej_noticia VALUES (106, 'Hecatombe financiera ante un Brexit duro',
			   'http://www.diariozaragoza.es/ibex9000',
			   2,204, TO_DATE('01/11/2018'), 2220);

INSERT INTO ej_noticia VALUES (107, 'Fomento anuncia una estrategia nacional para fomentar la intermodalidad y el uso de la bicicleta',
			   'http://www.elnoticiero.es/ibex9001',
			   1,206, TO_DATE('22/06/2018'), 390);
INSERT INTO ej_noticia VALUES (108, 'Así será el carril bici que pasará por la puerta del Clínico',
			   'http://www.diariozaragoza.es/nacional22062018',
			   2,206, TO_DATE('13/11/2018'), 230);
INSERT INTO ej_noticia VALUES (109, 'How will traffic constraints affect you? La Gaceta answers your questions',
			   'http://www.gacetaguadalajara.es/deportes33',
			   3,204, TO_DATE('22/11/2018'), 123);
INSERT INTO ej_noticia VALUES (110, 'How will traffic constraints affect you? Toledo Tribune answers your questions',
			   'http://www.toledotribune.es/deportes33',
			   4,204, TO_DATE('22/11/2018'), 880);
INSERT INTO ej_noticia VALUES (111, 'Financial havoc if there is a hard Brexit',
			   'http://www.toledotribune.es/deportes44',
			   4,201, TO_DATE('22/11/2018'), 110);
INSERT INTO ej_noticia VALUES (112, 'Financial havoc if there is a hard Brexit',
			   'http://www.alvaradotimes.es/deportes44',
			   5,204, TO_DATE('22/10/2018'), 130);

COMMIT;
