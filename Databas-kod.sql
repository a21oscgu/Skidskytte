drop database a21oscgu;
create database a21oscgu;
use a21oscgu;

#Databastabeller

create table skjutfalt(
    skjutfalt_namn varchar(20) not null,
    tele varchar(11),
    stad varchar(20),
    primary key(skjutfalt_namn)
)engine=innodb;

create table skjutbana(
    skjutbana_nr varchar(2) not null,
    moment varchar(12),
    skjutfalt_namn varchar(20) not null,
    primary key(skjutbana_nr),
    foreign key(skjutfalt_namn) references skjutfalt(skjutfalt_namn)
)engine=innodb;

create table funktionar(
    funktionar_pnr char(11) not null,
    lon varchar(10),
    funktionar_namn varchar(20),
	skjutfalt_namn varchar(20) not null,
    skjutbana_nr varchar(2) not null,
    primary key(funktionar_pnr),
	foreign key(skjutfalt_namn) references skjutfalt(skjutfalt_namn),
    foreign key(skjutbana_nr) references skjutbana(skjutbana_nr)
)engine=innodb;

create table maltavla(
    maltavla_nr char(13) not null,
    antal char(1),
    primary key(maltavla_nr)
)engine=innodb;

create table skytt(
    skytt_pnr char(11) not null,
    skytt_namn varchar(20),
    lag varchar(20),
    primary key(skytt_pnr)
)engine=innodb;

create table gevar(
	gevar_namn varchar(20) not null,
	vikt varchar(10),
    skytt_pnr char(11) not null,
    primary key (gevar_namn, skytt_pnr),
    foreign key(skytt_pnr) references skytt(skytt_pnr)
)engine=innodb;

create table ammunition(
    ammunition_namn varchar(10),
	kaliber varchar(10) not null,
	gevar_namn varchar(20) not null,
	skytt_pnr char(11) not null,
    primary key (kaliber, gevar_namn, skytt_pnr),
    foreign key(gevar_namn, skytt_pnr) references gevar(gevar_namn, skytt_pnr)
)engine=innodb;

create table skjutserie(
	starttid char(8) not null,
    resultat varchar(10),
    datum char(10),
    maltavla_nr char(13) not null,
	skytt_pnr char(11) not null,
    funktionar_pnr char(11),
	skjutbana_nr varchar(2),
    primary key (starttid, maltavla_nr, skytt_pnr),
	foreign key(maltavla_nr) references maltavla(maltavla_nr),
    foreign key(skytt_pnr) references skytt(skytt_pnr),
    foreign key(funktionar_pnr) references funktionar(funktionar_pnr),
    foreign key(skjutbana_nr) references skjutbana(skjutbana_nr)
)engine=innodb;

create table ammunition_ansvara(
	kaliber varchar(10) not null,
	gevar_namn varchar(20) not null,
    skytt_pnr char(11) not null,
    funktionar_pnr char(11) not null,
	primary key(kaliber, funktionar_pnr),
	foreign key(kaliber, gevar_namn, skytt_pnr) references ammunition(kaliber, gevar_namn, skytt_pnr),
	foreign key(funktionar_pnr) references funktionar(funktionar_pnr)
)engine=innodb;

#Transaktioner:
insert into skjutfalt(skjutfalt_namn, tele, stad) values('Kråk','0500-999999', 'Skövde');#1

insert into skjutbana(skjutbana_nr, moment) values ('1','knästående');#2
insert into skjutbana(skjutbana_nr, moment) values ('2','sittandes');#2
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('790129-4444','18000','Leif','Kråk','1');#2
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('810912-5555','18000','Lennart','Kråk','2');#2

insert into skytt(skytt_pnr, skytt_namn, lag) values ('560123-6666','Bosse','Göteborg');#3

insert into skytt(skytt_pnr, skytt_namn, lag) values ('761223-5656','Lars','Skövde');#4
insert into gevar(gevar_namn, vikt, skytt_pnr) values ('Izhmash','4,5','761223-5656');#4

insert into gevar(gevar_namn, vikt, skytt_pnr) values ('Izhmash','4,5','560123-6666');#5
insert into ammunition(ammunition_namn, kaliber, gevar_namn, skytt_pnr) values ('X-act','22','Izhmash','560123-6666');#5

insert into skjutbana(skjutbana_nr, moment) values ('3','stående');#6
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('870923-3434','18000','Linda','Kråk','3');#6
insert into skytt(skytt_pnr, skytt_namn, lag) values ('781222-2323','Allan','Skultorp');#6
insert into gevar(gevar_namn, vikt, skytt_pnr) values ('Allans_gevär','4,5','781222-2323');#6
insert into ammunition(ammunition_namn, kaliber, gevar_namn, skytt_pnr) values ('Midas+','22','Allans_gevär','781222-2323');#6
insert into ammunition_ansvara(kaliber, gevar_namn, skytt_pnr, funktionar_pnr) values ('22','Allans_gevär', '781222-2323', '870923-3434');#6

insert into maltavla(maltavla_nr, antal) values ('2','5');#7
insert into skjutserie(starttid, resultat, datum, skytt_pnr, maltavla_nr, funktionar_pnr, skjutbana_nr) values('13:01:33','5', '20120121','560123-6666','2','790129-4444','1');#7

insert into skytt(skytt_pnr, skytt_namn, lag) values ('761123-1212','Nisse','Skövde');#8
insert into gevar(gevar_namn, vikt, skytt_pnr) values ('Nisses_gevär','4,5','761123-1212');#8
insert into ammunition(ammunition_namn, kaliber, gevar_namn, skytt_pnr) values ('X-act-2','22','Nisses_gevär','761123-1212');#8
insert into skjutbana(skjutbana_nr, moment) values ('4','liggandes');#8
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('560123-4455','18000','Lukas','Kråk','4');#8
insert into skjutserie(starttid, resultat, datum, skytt_pnr, maltavla_nr, funktionar_pnr, skjutbana_nr) values('12:00:34','5', '20220102','761123-1212','2','560123-4455','4');#8
insert into ammunition_ansvara(kaliber, gevar_namn, skytt_pnr, funktionar_pnr) values ('22','Nisses_gevär', '761123-1212', '560123-4455');#8

insert into skjutserie(starttid, resultat, datum, skytt_pnr, maltavla_nr, funktionar_pnr, skjutbana_nr) values('13:32:13','5', '20220104','560123-6666','2','790129-4444','1');#9

insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('670809-9999','18000','Lisa','Kråk','4');#10
insert into skytt(skytt_pnr, skytt_namn, lag) values ('600112-2323','Ivar','Skövde');#10
insert into skjutserie(starttid, resultat, datum, skytt_pnr, maltavla_nr, funktionar_pnr, skjutbana_nr) values('11:15:03','5', '20220221','600112-2323','2','670809-9999','4');#10

#Egna transaktioner:
insert into skytt(skytt_pnr, skytt_namn, lag) values ('800620-9898','Adam','Rimforsa');#1+
insert into gevar(gevar_namn, vikt, skytt_pnr) values ('X-TREME','4,5','800620-9898');#1+
insert into ammunition(ammunition_namn, kaliber, gevar_namn, skytt_pnr) values ('X-act-2','22','X-TREME','800620-9898');#1+

insert into skjutbana(skjutbana_nr, moment) values ('5','knästående');#2+
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('890803-6868','19000','Alfred','Kråk','5');#2+
insert into ammunition_ansvara(kaliber, gevar_namn, skytt_pnr, funktionar_pnr) values ('22','X-TREME', '800620-9898', '890803-6868');#2+

insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('810601-7676','19000','Arvid','Kråk','3');#3+
insert into maltavla(maltavla_nr, antal) values ('1','5');#3+
insert into skjutserie(starttid, resultat, datum, skytt_pnr, maltavla_nr, funktionar_pnr, skjutbana_nr) values('10:00:10','4', '20220104','800620-9898','1','810601-7676','3');#3+
insert into ammunition_ansvara(kaliber, gevar_namn, skytt_pnr, funktionar_pnr) values ('22','Izhmash', '560123-6666', '790129-4444');#3+
insert into funktionar(funktionar_pnr, lon, funktionar_namn, skjutfalt_namn, skjutbana_nr) values ('790402-3223','11000','Albin','Kråk','5');#3+
insert into maltavla(maltavla_nr, antal) values ('8','5');#3+
insert into skytt(skytt_pnr, skytt_namn, lag) values ('800620-989','Andreas','Hjo');#3+

#Frågeoperationer
#1
select tele from skjutfalt where skjutfalt_namn='Kråk';
#2
select funktionar.funktionar_namn, funktionar.lon from funktionar where funktionar_pnr='790129-4444';
#3
select funktionar.funktionar_namn from funktionar inner join ammunition_ansvara on funktionar.funktionar_pnr = ammunition_ansvara.funktionar_pnr inner join ammunition on ammunition.skytt_pnr = ammunition_ansvara.skytt_pnr where ammunition_namn = 'X-act';
#4
select skytt_pnr from ammunition where gevar_namn='Izhmash' and kaliber='22' and ammunition_namn='X-act';
#5
select funktionar_namn from funktionar inner join skjutbana on funktionar.skjutbana_nr = skjutbana.skjutbana_nr where skjutbana.moment='stående';
#6
select f1.funktionar_pnr, f2.funktionar_pnr
from funktionar as f1, funktionar f2 where f1.lon = f2.lon and f1.funktionar_pnr != f2.funktionar_pnr;
#7
select skytt_pnr from skytt where not exists(select * from skjutserie where skytt.skytt_pnr = skjutserie.skytt_pnr);
#8
select skytt.lag from skytt inner join skjutserie on skjutserie.skytt_pnr = skytt.skytt_pnr where skjutserie.resultat = 5;
#9
select skytt.skytt_namn, skjutserie.resultat, skytt.skytt_pnr from skytt inner join skjutserie
on skjutserie.skytt_pnr = skytt.skytt_pnr where skytt.skytt_pnr = skjutserie.skytt_pnr;
#10
select funktionar_namn, skjutserie.funktionar_pnr from funktionar inner join skjutserie
on funktionar.funktionar_pnr = skjutserie.funktionar_pnr group by funktionar_namn having count(skjutserie.funktionar_pnr) = 2;
#11
select * from funktionar order by funktionar.funktionar_namn desc;
#12
select avg (skjutserie.resultat) from skjutserie;
#13
select skjutserie.skjutbana_nr, avg (skjutserie.resultat) from skjutserie inner join funktionar on funktionar.funktionar_pnr = skjutserie.funktionar_pnr group by skjutbana_nr;
#14
select * from skytt where lag rlike '^R';
#15
select skytt.skytt_namn, skytt.lag from skytt where CHAR_LENGTH(skytt.skytt_pnr) != 11;
#16
select funktionar_namn from funktionar where lon = (select max(lon) from funktionar);
#17
select skytt_namn from skytt inner join skjutserie on skytt.skytt_pnr = skjutserie.skytt_pnr order by skjutserie.datum desc limit 1;
#18
select * from skjutserie where datum = curdate()-1;
#19
select funktionar.funktionar_namn, funktionar.lon * 1.03 from funktionar where (10000 < funktionar.lon) and (funktionar.lon < 12000);
#20
delete from maltavla where maltavla.maltavla_nr = '8';
#21
delete from skjutserie where skjutserie.starttid = '12:01:33' and skjutserie.skytt_pnr = '560123-6666';
#22Test