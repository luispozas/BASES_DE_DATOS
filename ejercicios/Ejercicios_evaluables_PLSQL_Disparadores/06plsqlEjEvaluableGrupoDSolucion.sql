prompt ---------------------------------------------------------------------.
prompt SOLUCIONES EJERCICIO EVALUABLE 2. GRUPO D. 15/01/2018.
prompt ---------------------------------------------------------------------.
set linesize 300;
SET SERVEROUTPUT ON;
alter session set nls_date_format='DD/MM/YYYY HH24:MI';


prompt 1a. Escribe un procedimiento almacenado PasesSala que, dado un 
prompt     identificador de Cine y un número de sala, muestre un 
prompt     listado en la consola que indique las películas que se van
prompt     a proyectar en la sala: título, hora de inicio y número de 
prompt     asientos disponibles. Los resultados se deben mostrar en
prompt     orden cronológico por HoraIni.
prompt 

CREATE OR REPLACE PROCEDURE PasesSala(p_IdCine IN VARCHAR2, p_sala IN NUMBER) IS
  CURSOR cr_pase IS
    SELECT p.Titulo, p.HoraIni, s.Aforo - p.EntradasVendidas AS asientos
    FROM PASE p 
    JOIN SALA s ON p.IdCine = s.IdCine AND p.NumSala = s.NumSala
    WHERE s.IdCine = p_IdCine AND s.NumSala = p_sala
    ORDER BY HoraIni;
BEGIN
  FOR r_pase IN cr_pase LOOP
    DBMS_OUTPUT.PUT_LINE('  ' || TO_CHAR(r_pase.HoraIni,'HH24:MI') || 
                         '  ' || RPAD(r_pase.Titulo,30) ||
			 '  ' || TO_CHAR(r_pase.asientos,'999') || ' asientos disponibles');
  END LOOP;
END;
/

BEGIN
  PasesSala('44',1);
END;
/

prompt 
prompt 1b. Escribe un procedimiento almacenado Cartelera que, dado un 
prompt     identificador de Cine, muestre en la consola la dirección del
prompt     cine y las películas que se van a proyectar en todas sus salas.  
prompt     Por cada sala del cine debe mostrar el número de la sala y a 
prompt     continuación debe llamar al procedimiento PasesSala para 
prompt     mostrar la información de la sala.
prompt     Si no existe ningún cine con ese identificador, debe mostrar
prompt     un mensaje de error.
prompt 

CREATE OR REPLACE PROCEDURE Cartelera(p_IdCine IN VARCHAR2) IS
  CURSOR cr_sala IS
    SELECT IdCine, NumSala
    FROM SALA
    WHERE IdCine = p_IdCine
    ORDER BY NumSala;
  v_Direccion CINE.Direccion%TYPE;
BEGIN
  SELECT Direccion INTO v_Direccion
    FROM CINE WHERE IdCine = p_IdCine;
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('CARTELERA DEL CINE ' ||
                        p_IdCine || ' -- ' || v_Direccion);
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
  FOR r_sala IN cr_sala LOOP
    DBMS_OUTPUT.PUT_LINE('Sala: ' || TO_CHAR(r_sala.NumSala,'999'));
    PasesSala(p_IdCine, r_sala.NumSala);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No hay ningun cine con identificador: ' || p_IdCine);
END;
/

BEGIN
  Cartelera('37');
  Cartelera('44');
  Cartelera('11');
END;
/

prompt 
prompt 2. Escribe un disparador ActualizaEntradasVendidas que, cuando se 
prompt    modifiquen los datos de la tabla VENTA (por cualquier operación: 
prompt    inserción, actualización o borrado de filas), actualice el valor 
prompt    de la columna EntradasVendidas de las filas afectadas en PASE. 
prompt 

CREATE OR REPLACE TRIGGER ActualizaEntradasVendidas
AFTER UPDATE OR INSERT OR DELETE ON VENTA
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE PASE SET EntradasVendidas = EntradasVendidas + :NEW.NumEntradas
    WHERE IdCine = :NEW.IdCine AND NumSala = :NEW.NumSala AND HoraIni = :NEW.HoraIni;
  ELSIF DELETING THEN
    UPDATE PASE SET EntradasVendidas = EntradasVendidas - :OLD.NumEntradas
    WHERE IdCine = :OLD.IdCine AND NumSala = :OLD.NumSala AND HoraIni = :OLD.HoraIni;
  ELSIF UPDATING THEN
    UPDATE PASE SET EntradasVendidas = EntradasVendidas - :OLD.NumEntradas
    WHERE IdCine = :OLD.IdCine AND NumSala = :OLD.NumSala AND HoraIni = :OLD.HoraIni;

    UPDATE PASE SET EntradasVendidas = EntradasVendidas + :NEW.NumEntradas
    WHERE IdCine = :NEW.IdCine AND NumSala = :NEW.NumSala AND HoraIni = :NEW.HoraIni;
  END IF;
END;
/

INSERT INTO VENTA VALUES ('V01','44',1, TO_CHAR('15-01-2018 15:00'),8);
INSERT INTO VENTA VALUES ('V02','44',1, TO_CHAR('15-01-2018 15:00'),6);
INSERT INTO VENTA VALUES ('V03','37',1, TO_CHAR('15-01-2018 22:30'),5);
UPDATE VENTA SET NumSala = 2, 
                 HoraIni = TO_CHAR('15-01-2018 18:00'), 
                 NumEntradas = 4
WHERE IdVenta = 'V02';   
DELETE FROM VENTA WHERE IdVenta = 'V03';
SELECT * FROM VENTA;
SELECT * FROM PASE;


