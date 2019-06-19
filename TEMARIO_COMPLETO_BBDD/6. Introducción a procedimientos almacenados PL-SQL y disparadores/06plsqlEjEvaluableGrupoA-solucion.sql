-- -------------------------------------------------------------
-- EJERCICIO EVALUABLE GRUPO A. 14.12.2018 - SOLUCIONES
-- -------------------------------------------------------------
alter session set nls_date_format = 'DD/MM/YYYY';

-- -------------------------------------------------------------
-- PROCEDIMIENTO ALMACENADO
-- -------------------------------------------------------------
CREATE OR REPLACE PROCEDURE NoticiasMasVistas(p_anio NUMBER) IS
  v_IdPer ej_periodico.IdPer%TYPE;
  v_numNoticias INTEGER;
CURSOR cPeriodico IS
  SELECT p.Nombre, p.IdPer
  FROM ej_periodico p;

CURSOR cNoticiasMes IS
  SELECT EXTRACT(MONTH FROM n.FechaPub) mes, n.Titular, n.NumVisitas
  FROM ej_noticia n 
  WHERE EXTRACT(YEAR FROM n.FechaPub) = p_anio
  AND n.IdPer = v_IdPer
  AND n.NumVisitas = (
    SELECT MAX(n2.NumVisitas) 
    FROM ej_noticia n2
    WHERE EXTRACT(YEAR FROM n2.FechaPub) = p_anio
    AND n2.IdPer = n.IdPer
    AND EXTRACT(MONTH FROM n2.FechaPub) =  EXTRACT(MONTH FROM n.FechaPub));
BEGIN
  DBMS_OUTPUT.PUT_LINE('NOTICIAS MAS VISITADAS ' || p_anio);
  FOR rPeriodico IN cPeriodico LOOP
    DBMS_OUTPUT.PUT_LINE('Perdiodico : ' || rPeriodico.Nombre);
    v_IdPer := rPeriodico.IdPer;
    v_numNoticias := 0;
    FOR rNoticiasMes IN cNoticiasMes LOOP
      v_numNoticias := v_numNoticias + 1;
      DBMS_OUTPUT.PUT_LINE('  Mes: ' || TO_CHAR(rNoticiasMes.mes,'99') ||
                           ': ' || RPAD(rNoticiasMes.Titular,70));
      DBMS_OUTPUT.PUT_LINE('            ' || rNoticiasMes.numVisitas || ' Visitas.');
    END LOOP;
    IF v_numNoticias = 0 THEN
      DBMS_OUTPUT.PUT_LINE('  No se han publicado noticias durante 2018');
    END IF;
  END LOOP;

END;
/

SET SERVEROUTPUT ON;
BEGIN
  NoticiasMasVistas(2018);
END;
/
  

-- -------------------------------------------------------------
-- DISPARADOR
-- -------------------------------------------------------------

CREATE OR REPLACE TRIGGER ActualizaTotalAutor
BEFORE INSERT OR DELETE OR UPDATE ON ej_noticia
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE ej_autor SET TotalVisitas = TotalVisitas + :NEW.numVisitas
    WHERE :NEW.IdAutor = IdAutor;
  ELSIF DELETING THEN
    UPDATE ej_autor SET TotalVisitas = TotalVisitas - :OLD.numVisitas
    WHERE :OLD.IdAutor = IdAutor;
  ELSE
    IF :OLD.IdAutor != :NEW.IdAutor THEN
      UPDATE ej_autor SET TotalVisitas = TotalVisitas + :NEW.numVisitas
      WHERE :NEW.IdAutor = IdAutor;

      UPDATE ej_autor SET TotalVisitas = TotalVisitas - :OLD.numVisitas
      WHERE :OLD.IdAutor = IdAutor;
    ELSE
      UPDATE ej_autor 
      SET TotalVisitas = TotalVisitas - :OLD.numVisitas + :NEW.numVisitas
      WHERE :OLD.IdAutor = IdAutor;
    END IF;
    
    IF :OLD.NumVisitas < :NEW.NumVisitas THEN
      :NEW.FechaPub := SYSDATE;
    END IF;

  END IF;
END;
/

SELECT * FROM ej_autor;
SELECT * FROM ej_noticia;

INSERT INTO ej_noticia VALUES (113, 'Prueba', 'url', 5, 204, TO_DATE('22/10/2018'), 10);

UPDATE ej_noticia SET IdAutor = 201 WHERE IdNoticia = 113;

UPDATE ej_noticia SET NumVisitas = 30 WHERE IdNoticia = 113;

DELETE FROM ej_noticia WHERE IdNoticia = 113;

