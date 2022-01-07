create table kitaplik
(kitap_no int primary key,
yazar_no int,
tur_no int,
sayfa_say int);
INSERT INTO kitaplik VALUES (1,26,3,368);
INSERT INTO kitaplik VALUES (2,6,1,220);
INSERT INTO kitaplik VALUES (3,18,6,311);
INSERT INTO kitaplik VALUES (4,22,4,135);
INSERT INTO kitaplik VALUES (5,10,3,179);
INSERT INTO kitaplik VALUES (6,25,1,242);
INSERT INTO kitaplik VALUES (7,22,3,346);
INSERT INTO kitaplik VALUES (8,28,6,389);
INSERT INTO kitaplik VALUES (9,6,4,259);
INSERT INTO kitaplik VALUES (10,27,2,391);
INSERT INTO kitaplik VALUES (11,19,6,89);
INSERT INTO kitaplik VALUES (12,6,4,265);
INSERT INTO kitaplik VALUES (13,20,6,160);
INSERT INTO kitaplik VALUES (14,27,5,383);
INSERT INTO kitaplik VALUES (15,5,6,188);
 select * from kitaplik; 
 
 create table kitap_turu
 ( tur_no int primary key,
 kitabin_turu varchar(25));
 
 INSERT INTO kitap_turu VALUES (1,'Dram');
INSERT INTO kitap_turu VALUES (2,'Komedi');
INSERT INTO kitap_turu VALUES (3,'Roman');
INSERT INTO kitap_turu VALUES (4,'Hikaye');
INSERT INTO kitap_turu VALUES (5,'Arastirma');
INSERT INTO kitap_turu VALUES (6,'Fikra');
INSERT INTO kitap_turu VALUES (7,'Deneme');
 select * from kitap_turu;
  create table ogrenciler
 (ogr_no int,
 ogr_adi varchar(25),
 ogr_soyad varchar(25),
 cinsiyet varchar(1),
 sinif varchar(4) );
 
INSERT INTO ogrenciler VALUES (1,'Ahmet','Cansever','E','10A');
INSERT INTO ogrenciler VALUES (2,'Niyazi','Sevinc','E','11B');
INSERT INTO ogrenciler VALUES (3,'Ismail ','Sevinc','E','10B');
INSERT INTO ogrenciler VALUES (4,'Kenan','Emin','E','9A');
INSERT INTO ogrenciler VALUES (5,'Sema','Bakir','K','9B');
INSERT INTO ogrenciler VALUES (6,'Beyda','Kara','K','9C');
INSERT INTO ogrenciler VALUES (7,'Betül','Coskun','K','11A');
INSERT INTO ogrenciler VALUES (8,'Sema','Rüzgar','K','9C');
INSERT INTO ogrenciler VALUES (9,'Fadime','Dönmez','K','9A');
INSERT INTO ogrenciler VALUES (10,'Riza',';Koc','E','10B');
INSERT INTO ogrenciler VALUES (11,'Beyza','Kabak','K','10B');
INSERT INTO ogrenciler VALUES (12,'Deniz','Akcakaya','E','11A');
INSERT INTO ogrenciler VALUES (13,'Kemal','Karapinar','E','11A');
INSERT INTO ogrenciler VALUES (14,'Derya','Yilbur','K','10C');
INSERT INTO ogrenciler VALUES (15,'Filiz','Akat','K','10A');
INSERT INTO ogrenciler VALUES (16,'Niyazi','Dönmez','E','11A');
INSERT INTO ogrenciler VALUES (17,'Sema','Sekmen','K','10B');
 
 select * from ogrenciler;
 -- Örnek 1: Hangi isimden kaç tane olduğunu bulun.*
 select  ogr_adi, count( ogr_adi) as tekrarlanan
 from ogrenciler 
 group by ogr_adi;
 
-- Örnek 2: Sınıflardaki öğrenci sayısını bulun.
select   sinif, count(sinif) as sinifMev
from ogrenciler
group by sinif;

-- Örnek 3: Her sınıftaki erkek ve kız öğrenci sayısını bulun.(cinsiyet ve sinifa göre grupla)
select sinif, count(cinsiyet) as kızlar
from ogrenciler
where cinsiyet='K'  
group by cinsiyet,sinif;

select sinif, count(cinsiyet) as erkekler
from ogrenciler
where cinsiyet='E'  
group by cinsiyet,sinif;


-- Örnek 4: Her türden kaç tane kitap olduğunu listeleyiniz.
select kitabin_turu
from kitap_turu
union all
select count(tur_no)
from kitaplik
group by tur_no; 


-- Örnek 5: Her türdeki en fazla sayfa sayısı olan kitapları listeleyiniz.
select kitabin_turu
from kitap_turu
union
select max(sayfa_say) 
from kitaplik
group by tur_no;


-- Örnek 6: Her türdeki en az sayfa sayısı olan kitapları listeleyiniz.
select kitabin_turu
from kitap_turu
union
select min(sayfa_say) 
from kitaplik
group by tur_no;


-- Örnek 7***: Her türden kaç tane kitap olduğunu listeleyiniz.(Tür isimleri de olsun) (edited)
select kitabin_turu edited
from kitap_turu
union all
select count(tur_no)
from kitaplik
group by tur_no; 

 