-- ---------------------------------------------------------------------
-- SOLUTIONS EVALUATION TEST 1 EXTRA. GROUPS A AND I.
-- ---------------------------------------------------------------------
alter session set nls_date_format='DD/MM/YYYY';

-- a.

SELECT a.pid, a.name, sum(e.salary) 
FROM ex_plane a JOIN ex_certificate c ON a.pid = c.pid
JOIN ex_empl e ON c.eid = e.eid
GROUP BY a.pid, a.name
UNION ALL
SELECT a2.pid, a2.name, 0
FROM ex_plane a2
WHERE a2.pid NOT IN (SELECT pid FROM ex_certificate);

-- Alternate solution

SELECT a.pid, a.name, nvl(sum(e.salary), 0)
FROM (ex_certificate c JOIN ex_empl e ON c.eid = e.eid)
RIGHT OUTER JOIN ex_plane a ON a.pid = c.pid
GROUP BY a.pid, a.name
ORDER BY sum(e.salary) DESC;


-- b.

SELECT DISTINCT e.eid, e.name 
FROM ex_empl e JOIN ex_certificate c ON e.eid=c.eid 
WHERE c.pid IN (SELECT c2.pid 
                FROM ex_certificate c2 JOIN ex_empl e2 ON c2.eid=e2.eid
                WHERE e2.name='Lisa Walker');

-- c.

SELECT v.flno, v.deptAirport, v.destAirport, count(DISTINCT e.eid), min(e.salary)
FROM ex_flight v JOIN ex_plane a ON v.distance <= a.maxFlLength
JOIN ex_certificate c ON a.pid = c.pid
JOIN ex_empl e ON c.eid = e.eid
GROUP BY v.flno, v.deptAirport, v.destAirport;

-- d.

select e1.name, a1.name from ex_empl e1 join ex_certificate c1 on e1.eid=c1.eid
join ex_plane a1 on a1.pid = c1.pid 
where e1.eid not in 
  (select c.eid from ex_certificate c join ex_plane a on c.pid = a.pid 
   where a.name like '%Airbus%');

-- e.

select e1.name, count(distinct a1.pid) from ex_empl e1 join ex_certificate c1 on e1.eid=c1.eid
join ex_plane a1 on a1.pid = c1.pid
where a1.name like '%Airbus%'
group by e1.name, e1.eid
having count(distinct a1.pid) = (select count(pid) from ex_plane where name like '%Airbus%');

-- f.

select e.name, e.salary, a.name from ex_empl e join ex_certificate c on e.eid = c.eid
join ex_plane a on a.pid = c.pid
where e.salary = (select min(e2.salary) from ex_empl e2 join ex_certificate c2 on e2.eid = c2.eid
                   where c2.pid = c.pid);
