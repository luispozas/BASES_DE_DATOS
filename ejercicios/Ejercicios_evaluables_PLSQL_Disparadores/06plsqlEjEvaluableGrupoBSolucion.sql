prompt ---------------------------------------------------------------------.
prompt SOLUCIONES EJERCICIO EVALUABLE 2. GRUPO B. 16/01/2018.
prompt ---------------------------------------------------------------------.
set linesize 300;
SET SERVEROUTPUT ON;
alter session set nls_date_format='DD/MM/YYYY';

prompt 
prompt 1a.] Escribe un procedimiento almacenado OfertasFecha
prompt   que, dado un identificador de tienda, un número de departamento y
prompt   una fecha, muestre un listado en la consola que indique las ofertas
prompt   vigentes en ese departamento de esa tienda en la fecha dada. Debe
prompt   mostrar: IdOferta, producto, fecha de fin de la oferta
prompt   (posterior a la fecha dada) y
prompt   número de unidades disponibles.  Los resultados se deben mostrar en
prompt   orden cronológico por FechaIni.  Si no hay ofertas, debe
prompt   mostrar el texto ' No hay ofertas.'
prompt 

CREATE OR REPLACE PROCEDURE OfertasFecha(p_IdTienda IN VARCHAR2, p_NumDpto IN NUMBER, p_fecha IN DATE) IS
  CURSOR cr_oferta IS
    SELECT p.IdOferta, p.Producto, p.FechaFin, p.UnidadesOfertadas - p.UnidadesVendidas AS Unidades
    FROM OFERTA p 
    WHERE p.IdTienda = p_IdTienda AND p.NumDpto = p_NumDpto 
    AND p.FechaIni <= p_fecha AND p.FechaFin >= p_fecha
    ORDER BY FechaIni;
  v_NumOfertas INTEGER := 0;
BEGIN
  FOR r_oferta IN cr_oferta LOOP
    v_NumOfertas := v_NumOfertas + 1;
    DBMS_OUTPUT.PUT_LINE('  ' || RPAD(r_oferta.IdOferta,5) || 
                         '  ' || RPAD(r_oferta.Producto,35) ||
                   			 '  ' || TO_CHAR(r_oferta.FechaFin,'DD-MM-YYYY') || 
                    		 '  ' || TO_CHAR(r_oferta.Unidades,'999') || ' unidades');
  END LOOP;
  IF v_NumOfertas = 0 THEN
    DBMS_OUTPUT.PUT_LINE('  No hay ofertas.');
  END IF;
END;
/

BEGIN
  OfertasFecha('37',2,TO_DATE('01-04-2018'));
END;
/

prompt
prompt 1b.]  Escribe un procedimiento almacenado
prompt   OfertasTienda que, dado un identificador de tienda y una
prompt   fecha, muestre en la consola la dirección de la tienda y las ofertas
prompt   disponibles en esa fecha en todos sus departamentos.  Por cada
prompt   departamento de la tienda debe mostrar la descripción del
prompt   departamento y a continuación debe llamar al procedimiento
prompt   OfertasFecha para mostrar las ofertas de ese dpto.  Si no existe
prompt   ninguna tienda con ese identificador, debe manejarse esta situación
prompt   mediante una excepción y mostrar un mensaje de error.
prompt 

CREATE OR REPLACE PROCEDURE OfertasTienda(p_IdTienda IN VARCHAR2, p_fecha IN DATE) IS
  CURSOR cr_dpto IS
    SELECT NumDpto, Descr
    FROM DPTO
    WHERE IdTienda = p_IdTienda
    ORDER BY NumDpto;
  v_Direccion TIENDA.Direccion%TYPE;
BEGIN
  SELECT Direccion INTO v_Direccion
    FROM TIENDA WHERE IdTienda = p_IdTienda;
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('OFERTAS DEL DIA ' || TO_CHAR(p_fecha,'DD-MM-YYYY') ||
  		       ' EN LA TIENDA ' || p_IdTienda || ' -- ' || v_Direccion);
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
  FOR r_dpto IN cr_dpto LOOP
    DBMS_OUTPUT.PUT_LINE('Departamento: ' || TO_CHAR(r_dpto.NumDpto,'999') ||
    			 ' -- ' || r_dpto.Descr);
    OfertasFecha(p_IdTienda, r_dpto.NumDpto, p_fecha);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No hay ninguna tienda con identificador: ' || p_IdTienda);
END;
/

BEGIN
  --OfertasTienda('37',TO_DATE('01-04-2018'));
  --OfertasTienda('44',TO_DATE('01-04-2018'));
  OfertasTienda('11',TO_DATE('01-04-2018'));
END;
/

prompt 
prompt 2.]  Escribe un disparador ActualizaUnidadesVendidas
prompt   que, cuando se modifiquen los datos de la tabla VENTA (por
prompt   cualquier operación: inserción, actualización o borrado de filas),
prompt   actualice correctamente el valor de la columna
prompt   UnidadesVendidas en las filas afectadas de
prompt   OFERTA.
prompt 
prompt   Incluye en la solución las sentencias necesarias para probar el
prompt   disparador. 
prompt 

CREATE OR REPLACE TRIGGER ActualizaUnidadesVendidas
AFTER UPDATE OR INSERT OR DELETE ON VENTA
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE OFERTA SET UnidadesVendidas = UnidadesVendidas + :NEW.NumUnidades
    WHERE IdOferta = :NEW.IdOferta;
  ELSIF DELETING THEN
    UPDATE OFERTA SET UnidadesVendidas = UnidadesVendidas - :OLD.NumUnidades
    WHERE IdOferta = :OLD.IdOferta;
  ELSIF UPDATING THEN
    UPDATE OFERTA SET UnidadesVendidas = UnidadesVendidas - :OLD.NumUnidades
    WHERE IdOferta = :OLD.IdOferta;

    UPDATE OFERTA SET UnidadesVendidas = UnidadesVendidas + :NEW.NumUnidades
    WHERE IdOferta = :NEW.IdOferta;
  END IF;
END;
/

INSERT INTO VENTA VALUES ('V01','o02', TO_CHAR('15-04-2018'),'Andres Garcia', 2);
INSERT INTO VENTA VALUES ('V02','o02', TO_CHAR('15-03-2018'),'Alvaro Armengol', 3);
INSERT INTO VENTA VALUES ('V03','o06', TO_CHAR('15-01-2018'),'Renato Matina', 5);
UPDATE VENTA SET IdOferta = 'o03', 
                 NumUnidades = 2
WHERE IdVenta = 'V02';   
DELETE FROM VENTA WHERE IdVenta = 'V03';
SELECT * FROM VENTA;
SELECT * FROM OFERTA;


