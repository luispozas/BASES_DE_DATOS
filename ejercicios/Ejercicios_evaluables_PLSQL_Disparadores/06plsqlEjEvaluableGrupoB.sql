prompt ---------------------------------------------------------------------.
prompt EJERCICIO EVALUABLE 2. GRUPO B. 16/01/2018.
prompt ---------------------------------------------------------------------.
set linesize 300;
SET SERVEROUTPUT ON;
alter session set nls_date_format='DD/MM/YYYY';

DROP TABLE VENTA CASCADE CONSTRAINTS;
DROP TABLE OFERTA CASCADE CONSTRAINTS;
DROP TABLE DPTO CASCADE CONSTRAINTS;
DROP TABLE TIENDA CASCADE CONSTRAINTS;

CREATE TABLE TIENDA (
  IdTienda VARCHAR2(5) PRIMARY KEY,
  Direccion VARCHAR2(40)
);

CREATE TABLE DPTO (
  IdTienda VARCHAR2(5) REFERENCES TIENDA,
  NumDpto NUMBER(3),
  Descr VARCHAR2(40),
  CONSTRAINT PK_DPTO PRIMARY KEY (IdTienda, NumDpto)
);

CREATE TABLE OFERTA (
  IdOferta VARCHAR2(5) PRIMARY KEY,
  IdTienda VARCHAR2(5),
  NumDpto NUMBER(3),
  FechaIni DATE,
  FechaFin DATE,
  Producto VARCHAR2(40),
  UnidadesOfertadas NUMBER(4) NOT NULL,
  UnidadesVendidas NUMBER(4) DEFAULT 0 NOT NULL,
  CONSTRAINT FK_OFERTA_DPTO FOREIGN KEY (IdTienda, NumDpto) REFERENCES DPTO,
  CONSTRAINT CHK_OFERTA CHECK (UnidadesOfertadas > 0)
);

CREATE TABLE VENTA(
  IdVenta VARCHAR2(5) PRIMARY KEY,
  IdOferta VARCHAR2(5) REFERENCES OFERTA,
  FechaVenta DATE,
  Cliente VARCHAR2(40),
  NumUnidades NUMBER(4),
  CONSTRAINT CHK_VENTA CHECK (NumUnidades > 0)
);

INSERT INTO TIENDA VALUES ('37','Conde de Peñalver, 44');
INSERT INTO TIENDA VALUES ('44','Princesa, 25');

INSERT INTO DPTO VALUES ('37',1, 'Papeleria');
INSERT INTO DPTO VALUES ('37',2, 'Informatica');
INSERT INTO DPTO VALUES ('37',3, 'Imagen y sonido');
INSERT INTO DPTO VALUES ('44',1, 'Informatica');
INSERT INTO DPTO VALUES ('44',2, 'Libreria');

INSERT INTO OFERTA VALUES ('o01', '37', 1, TO_CHAR('01-02-2018'), TO_CHAR('01-02-2018'), 'Destructora de papel SuperDestroyer 60', 50, 0);
INSERT INTO OFERTA VALUES ('o02', '37', 2, TO_CHAR('15-03-2018'), TO_CHAR('15-04-2018'), 'Ordenador Victor i7 16Gb 1Tb HD', 15, 0);
INSERT INTO OFERTA VALUES ('o03', '37', 2, TO_CHAR('15-03-2018'), TO_CHAR('15-04-2018'), 'Monitor 27in 4K', 15, 0);
INSERT INTO OFERTA VALUES ('o04', '37', 3, TO_CHAR('01-02-2018'), TO_CHAR('15-05-2018'), 'Barra de sonido Megatron', 20, 0);
INSERT INTO OFERTA VALUES ('o05', '44', 1, TO_CHAR('01-02-2018'), TO_CHAR('15-04-2018'), 'Ordenador Compaq i5 8Gb 1Tb HD', 84, 0);
INSERT INTO OFERTA VALUES ('o06', '44', 1, TO_CHAR('01-02-2018'), TO_CHAR('15-02-2018'), 'Impresora Saikushi 3000', 20, 0);
INSERT INTO OFERTA VALUES ('o07', '44', 2, TO_CHAR('01-02-2018'), TO_CHAR('15-02-2018'), 'Tetralogia El anillo', 25, 0);

