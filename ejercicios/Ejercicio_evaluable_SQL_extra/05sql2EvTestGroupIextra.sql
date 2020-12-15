-------------------------------------------------------------
-- FILE: 05sql2EvTestGroupIextra.sql
-------------------------------------------------------------
alter session set nls_date_format='DD/MM/YYYY';

drop table ex_certificate cascade constraints;
drop table ex_empl cascade constraints;
drop table ex_plane cascade constraints;
drop table ex_flight cascade constraints;

create table ex_flight(
	flno number(4,0) primary key,
	deptAirport varchar2(20),
	destAirport varchar2(20),
	distance number(6,0),
	deptDate date,
	arrivDate date,
	price number(7,2));

create table ex_plane(
	pid number(9,0) primary key,
	name varchar2(30),
	maxFlLength number(6,0)); -- Maximum flight length, measured in miles.

create table ex_empl(
	eid number(9,0) primary key,
	name varchar2(30),
	salary number(10,2));

create table ex_certificate(
	eid number(9,0),
	pid number(9,0),
	primary key(eid,pid),
	foreign key(eid) references ex_empl,
	foreign key(pid) references ex_plane); 


INSERT INTO ex_flight VALUES (99.0,'Los Angeles','Washington D.C.',2308.0,to_date('04/12/2005 09:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:40', 'dd/mm/yyyy HH24:MI'),235.98);

INSERT INTO ex_flight VALUES (13.0,'Los Angeles','Chicago',1749.0,to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:45', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO ex_flight VALUES (346.0,'Los Angeles','Dallas',1251.0,to_date('04/12/2005 11:50', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),225-43);

INSERT INTO ex_flight VALUES (387.0,'Los Angeles','Boston',2606.0,to_date('04/12/2005 07:03', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 05:03', 'dd/mm/yyyy HH24:MI'),261.56);

INSERT INTO ex_flight VALUES (7.0,'Los Angeles','Sydney',7487.0,to_date('04/12/2005 05:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:10', 'dd/mm/yyyy HH24:MI'),278.56);

INSERT INTO ex_flight VALUES (2.0,'Los Angeles','Tokyo',5478.0,to_date('04/12/2005 06:30', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:55', 'dd/mm/yyyy HH24:MI'),780.99);

INSERT INTO ex_flight VALUES (33.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 09:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:15', 'dd/mm/yyyy HH24:MI'),375.23);

INSERT INTO ex_flight VALUES (34.0,'Los Angeles','Honolulu',2551.0,to_date('04/12/2005 12:45', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 03:18', 'dd/mm/yyyy HH24:MI'),425.98);

INSERT INTO ex_flight VALUES (76.0,'Chicago','Los Angeles',1749.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:03', 'dd/mm/yyyy HH24:MI'),220.98);

INSERT INTO ex_flight VALUES (68.0,'Chicago','New York',802.0,to_date('04/12/2005 09:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:02', 'dd/mm/yyyy HH24:MI'),202.45);

INSERT INTO ex_flight VALUES (7789.0,'Madison','Detroit',319.0,to_date('04/12/2005 06:15', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 08:19', 'dd/mm/yyyy HH24:MI'),120.33);

INSERT INTO ex_flight VALUES (701.0,'Detroit','New York',470.0,to_date('04/12/2005 08:55', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:26', 'dd/mm/yyyy HH24:MI'),180.56);

INSERT INTO ex_flight VALUES (702.0,'Madison','New York',789.0,to_date('04/12/2005 07:05', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),202.34);

INSERT INTO ex_flight VALUES (4884.0,'Madison','Chicago',84.0,to_date('04/12/2005 10:12', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 11:02', 'dd/mm/yyyy HH24:MI'),112.45);

INSERT INTO ex_flight VALUES (2223.0,'Madison','Pittsburgh',517.0,to_date('04/12/2005 08:02', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 10:01', 'dd/mm/yyyy HH24:MI'),189.98);

INSERT INTO ex_flight VALUES (5694.0,'Madison','Minneapolis',247.0,to_date('04/12/2005 08:32', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 09:33', 'dd/mm/yyyy HH24:MI'),120.11);

INSERT INTO ex_flight VALUES (304.0,'Minneapolis','New York',991.0,to_date('04/12/2005 10:00', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 01:39', 'dd/mm/yyyy HH24:MI'),101.56);

INSERT INTO ex_flight VALUES (149.0,'Pittsburgh','New York',303.0,to_date('04/12/2005 09:42', 'dd/mm/yyyy HH24:MI'),to_date('04/12/2005 12:09', 'dd/mm/yyyy HH24:MI'),1165.00);

Insert into ex_plane values ('1','Boeing 747-400','8430');
Insert into ex_plane values ('2','Boeing 737-800','3383');
Insert into ex_plane values ('3','Airbus A340-300','7120');
Insert into ex_plane values ('4','British Aerospace Jetstream 41','1502');
Insert into ex_plane values ('5','Embraer ERJ-145','1530');
Insert into ex_plane values ('6','SAAB 340','2128');
Insert into ex_plane values ('7','Piper Archer III','520');
Insert into ex_plane values ('8','Tupolev 154','4103');
Insert into ex_plane values ('16','Schwitzer 2-33','30');
Insert into ex_plane values ('9','Lockheed L1011','6900');
Insert into ex_plane values ('10','Boeing 757-300','4010');
Insert into ex_plane values ('11','Boeing 777-300','6441');
Insert into ex_plane values ('12','Boeing 767-400ER','6475');
Insert into ex_plane values ('13','Airbus A320','2605');
Insert into ex_plane values ('14','Airbus A319','1805');
Insert into ex_plane values ('15','Boeing 727','1504');


Insert into ex_empl values ('242518965','James Smith','120433');
Insert into ex_empl values ('141582651','Mary Johnson','178345');
Insert into ex_empl values ('11564812','John Williams','153972');
Insert into ex_empl values ('567354612','Lisa Walker','256481');
Insert into ex_empl values ('552455318','Larry West','101745');
Insert into ex_empl values ('550156548','Karen Scott','205187');
Insert into ex_empl values ('390487451','Lawrence Sperry','212156');
Insert into ex_empl values ('274878974','Michael Miller','99890');
Insert into ex_empl values ('254099823','Patricia Jones','24450');
Insert into ex_empl values ('356187925','Robert Brown','44740');
Insert into ex_empl values ('355548984','Angela Martinez','212156');
Insert into ex_empl values ('310454876','Joseph Thompson','212156');
Insert into ex_empl values ('489456522','Linda Davis','27984');
Insert into ex_empl values ('489221823','Richard Jackson','23980');
Insert into ex_empl values ('548977562','William Ward','84476');
Insert into ex_empl values ('310454877','Chad Stewart','33546');
Insert into ex_empl values ('142519864','Betty Adams','227489');
Insert into ex_empl values ('269734834','George Wright','289950');
Insert into ex_empl values ('287321212','Michael Miller','48090');
Insert into ex_empl values ('552455348','Dorthy Lewis','152013');
Insert into ex_empl values ('248965255','Barbara Wilson','43723');
Insert into ex_empl values ('159542516','William Moore','48250');
Insert into ex_empl values ('348121549','Haywood Kelly','32899');
Insert into ex_empl values ('90873519','Elizabeth Taylor','32021');
Insert into ex_empl values ('486512566','David Anderson','43001');
Insert into ex_empl values ('619023588','Jennifer Thomas','54921');
Insert into ex_empl values ('15645489','Donald King','18050');
Insert into ex_empl values ('556784565','Mark Young','205187');
Insert into ex_empl values ('573284895','Eric Cooper','114323');
Insert into ex_empl values ('574489456','William Jones','105743');
Insert into ex_empl values ('574489457','Milo Brooks','20');


Insert into ex_certificate values ('11564812','2');
Insert into ex_certificate values ('11564812','10');
Insert into ex_certificate values ('90873519','6');
Insert into ex_certificate values ('141582651','2');
Insert into ex_certificate values ('141582651','10');
Insert into ex_certificate values ('141582651','12');
Insert into ex_certificate values ('142519864','1');
Insert into ex_certificate values ('142519864','2');
Insert into ex_certificate values ('142519864','3');
Insert into ex_certificate values ('142519864','7');
Insert into ex_certificate values ('142519864','10');
Insert into ex_certificate values ('142519864','11');
Insert into ex_certificate values ('142519864','12');
Insert into ex_certificate values ('142519864','13');
Insert into ex_certificate values ('159542516','5');
Insert into ex_certificate values ('159542516','7');
Insert into ex_certificate values ('242518965','2');
Insert into ex_certificate values ('242518965','10');
Insert into ex_certificate values ('269734834','1');
Insert into ex_certificate values ('269734834','2');
Insert into ex_certificate values ('269734834','3');
Insert into ex_certificate values ('269734834','4');
Insert into ex_certificate values ('269734834','5');
Insert into ex_certificate values ('269734834','6');
Insert into ex_certificate values ('269734834','7');
Insert into ex_certificate values ('269734834','8');
Insert into ex_certificate values ('269734834','9');
Insert into ex_certificate values ('269734834','10');
Insert into ex_certificate values ('269734834','11');
Insert into ex_certificate values ('269734834','12');
Insert into ex_certificate values ('269734834','13');
Insert into ex_certificate values ('269734834','14');
Insert into ex_certificate values ('269734834','15');
Insert into ex_certificate values ('274878974','10');
Insert into ex_certificate values ('274878974','12');
Insert into ex_certificate values ('310454876','8');
Insert into ex_certificate values ('310454876','9');
Insert into ex_certificate values ('355548984','8');
Insert into ex_certificate values ('355548984','9');
Insert into ex_certificate values ('356187925','6');
Insert into ex_certificate values ('390487451','3');
Insert into ex_certificate values ('390487451','13');
Insert into ex_certificate values ('390487451','14');
Insert into ex_certificate values ('548977562','7');
Insert into ex_certificate values ('550156548','1');
Insert into ex_certificate values ('550156548','12');
Insert into ex_certificate values ('552455318','2');
Insert into ex_certificate values ('552455318','7');
Insert into ex_certificate values ('552455318','14');
Insert into ex_certificate values ('556784565','2');
Insert into ex_certificate values ('556784565','3');
Insert into ex_certificate values ('556784565','5');
Insert into ex_certificate values ('567354612','1');
Insert into ex_certificate values ('567354612','2');
Insert into ex_certificate values ('567354612','3');
Insert into ex_certificate values ('567354612','4');
Insert into ex_certificate values ('567354612','5');
Insert into ex_certificate values ('567354612','7');
Insert into ex_certificate values ('567354612','9');
Insert into ex_certificate values ('567354612','10');
Insert into ex_certificate values ('567354612','11');
Insert into ex_certificate values ('567354612','12');
Insert into ex_certificate values ('567354612','15');
Insert into ex_certificate values ('573284895','3');
Insert into ex_certificate values ('573284895','4');
Insert into ex_certificate values ('573284895','5');
Insert into ex_certificate values ('574489456','6');
Insert into ex_certificate values ('574489456','8');
Insert into ex_certificate values ('574489457','7');

commit;
