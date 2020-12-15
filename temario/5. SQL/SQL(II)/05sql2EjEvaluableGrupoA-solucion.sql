alter session set nls_date_format='DD/MM/YYYY';

SET LINESIZE 500;
SET PAGESIZE 500;

/* 1.  Resumen de visitas recibidas por autor e idioma: debe mostrar
  la lista de los autores que han publicado noticias y los idiomas de
  los periódicos en los que las ha publicado, con la siguiente
  información: Nombre del autor, idioma, número de periodicos en los
  que el autor ha publicado noticias en ese idioma, total de visitas
  recibidas en ese idioma y número de visitas de la noticia más
  visitada.  */

SELECT a.Nombre, p.Idioma, COUNT(DISTINCT IdPer), SUM(NumVisitas), MAX(NumVisitas)
FROM ej_autor a JOIN ej_noticia n USING (IdAutor) 
JOIN ej_periodico p USING (IdPer)
GROUP BY p.Idioma, a.Nombre, IdAutor;

/* 2. Lista de los periódicos (nombre y número de visitas) que en 2018
  han tenido más visitas que 'La Gaceta'.  */

SELECT p.Nombre, SUM(NumVisitas)
FROM ej_periodico p JOIN ej_noticia n USING (IdPer)
WHERE EXTRACT(YEAR FROM n.FechaPub) = 2018
GROUP BY IdPer, p.Nombre
HAVING SUM(n.NumVisitas) > (
  SELECT SUM(n2.NumVisitas) FROM ej_periodico p2 JOIN ej_noticia n2 USING (IdPer)
  WHERE p2.Nombre = 'La Gaceta' AND EXTRACT(YEAR FROM n2.FechaPub) = 2018);

/* 3. Lista de todos los periódicos y los autores que han publicado
  noticias en ellos en noviembre de 2018.  Debe mostrar el nombre del
  periódico y el nombre del autor (o bien '(ninguno) si el
  periódico no ha publicado noticias de ningún autor). Nota:
  al menos una de las filas resultantes debería aparecer con el texto
  '(ninguno)'.  */

-- IMPORTANTE: ESTA CONSULTA ES BASTANTE COMPLEJA: SI SE INCLUYEN EN LA CLAUSULA 
-- WHERE LAS CONDICIONES SOBRE LA FECHA, LOS PERIODICOS QUE TENGAN NOTICIAS 
-- PUBLICADAS EN FECHAS DISTINTAS DE NOV.2018 NO APARECEN EN EL RESULTADO
-- AUNQUE SE UTILICE UNA REUNION EXTERNA (LEFT OUTER JOIN). PARA
-- RESOLVERLO SE DEBE INCLUIR LA CONDICION DE FECHA *EN LA CONDICION DE REUNION*
-- DE NOTICIA CON AUTOR. 

SELECT p.Nombre, NVL(a.Nombre,'(ninguno)')
FROM ej_periodico p 
LEFT JOIN (ej_noticia n JOIN ej_autor a ON 
  (n.IdAutor = a.IdAutor AND n.FechaPub BETWEEN '01/11/2018' AND '30/11/2018')) 
  ON p.IdPer = n.IdPer;
  
-- SOLUCION ALTERNATIVA: AÑADIENDO UNA SUBCONSULTA EN FROM.

SELECT p.Nombre, NVL(s.Nombre,'(ninguno)')
FROM ej_periodico p 
LEFT JOIN (SELECT n.IdPer, a.Nombre 
           FROM ej_noticia n JOIN ej_autor a ON n.IdAutor = a.IdAutor 
           WHERE n.FechaPub BETWEEN '01/11/2018' AND '30/11/2018') s
ON p.IdPer = s.IdPer;
  
-- SOLUCION ALTERNATIVA: UTILIZANDO UNION.

SELECT p.Nombre, a.Nombre
FROM ej_periodico p 
JOIN ej_noticia n ON p.IdPer = n.IdPer
JOIN ej_autor a ON n.IdAutor = a.IdAutor 
WHERE n.FechaPub BETWEEN '01/11/2018' AND '30/11/2018'
UNION ALL
SELECT Nombre, '(ninguno)'
FROM ej_periodico 
WHERE IdPer NOT IN (SELECT IdPer FROM ej_noticia 
                    WHERE FechaPub BETWEEN '01/11/2018' AND '30/11/2018');

/* 4. Muestra los titulares de las noticias escritas por autores que
  en 2018 no han escrito ninguna noticia para periódicos en inglés.
  */

SELECT n.titular FROM ej_noticia n 
WHERE n.IdAutor NOT IN (
  SELECT  n2.IdAutor FROM ej_noticia n2 JOIN ej_periodico p USING (IdPer) 
  WHERE p.idioma = 'en' AND EXTRACT(YEAR FROM n2.FechaPub) = 2018); 

/* 5. Muestra los titulares de las noticias escritas por autores que
  en 2018 solamente han escrito noticias para periódicos en inglés.
  */

SELECT n.titular FROM ej_noticia n JOIN ej_periodico p USING (IdPer) 
WHERE p.idioma = 'en' AND EXTRACT(YEAR FROM n.FechaPub) = 2018
AND n.IdAutor NOT IN (
  SELECT n2.IdAutor FROM ej_noticia n2 JOIN ej_periodico p2 USING (IdPer) 
  WHERE p2.idioma != 'en' AND EXTRACT(YEAR FROM n2.FechaPub) = 2018); 

/* 6. Nombre de los autores que han publicado noticias en todos los
  periódicos en inglés.  */

-- Esta es una subconsulta *correlacionada*, pues necesitamos ligar
-- el id de autor de la subconsulta interna con el id de autor de la 
-- consulta externa.

SELECT a.nombre
FROM ej_autor a
WHERE NOT EXISTS (
  SELECT p.IdPer FROM ej_periodico p WHERE Idioma = 'en' AND IdPer NOT IN (
    SELECT n2.IdPer FROM ej_noticia n2 WHERE n2.IdAutor = a.IdAutor));

-- Solución alternativa, comparando el numero de periodicos en ingles
-- en los que publica el autor con el numero total de periodicos en
-- ingles. 
-- Es importante en este caso que la condicion de HAVING sea con COUNT
-- DISTINCT: puede haber un autor que haya publicado mas de una
-- noticia en un mismo periodico en ingles, y por tanto la comparacion
-- seria incorrecta si no se cuentan los periodicos *distintos*.

SELECT a.nombre
FROM ej_autor a JOIN ej_noticia n USING (IdAutor) 
JOIN ej_periodico p USING (IdPer)
WHERE p.Idioma = 'en'
GROUP BY a.nombre, IdAutor
HAVING COUNT(DISTINCT IdPer) = (SELECT COUNT(*) FROM ej_periodico WHERE Idioma = 'en');

/* 7. Lista de las noticias más visitadas de cada periódico. Debe
  mostrar el nombre del periódico, el titular y el número de visitas.
  */

SELECT p.Nombre, n.Titular, n.NumVisitas 
FROM ej_periodico p
JOIN ej_noticia n ON p.IdPer = n.IdPer
WHERE n.NumVisitas = (
  SELECT MAX(n2.NumVisitas)
  FROM ej_noticia n2
  WHERE n2.IdPer = n.IdPer);


