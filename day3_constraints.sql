/*======================= CONSTRAINTS - KISITLAMALAR ======================================
           
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder. 
    UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  
    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)
    FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 
                  foreign ve primary ile tablolar birbirine bağlamadan da, id leri ayni olan satirlarda işlem yap diyebiliriz, böylelikle
                  ayni field verilebilir, parent child ilişkisi olmamiş olur
    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir şartı sağlamasını garanti eder. 
    DEFAULT - Herhangi bir değer atanamadığında Başlangıç değerinin atanmasını sağlar.
 ========================================================================================*/
CREATE TABLE calisanlar
    (
        id CHAR(5) PRIMARY KEY, -- not null+ unique
        isim VARCHAR(50) UNIQUE,
        maas int NOT NULL,
        ise_baslama DATE
    );
INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
	INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
    INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maaş null olamaz
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');-- can unique olmadi. bir oncekinden dolayi hata verir
    INSERT INTO calisanlar VALUES('10003', 'cem', '', '2018-04-14'); -- maaş integer olduğu için hata verir
    INSERT INTO calisanlar VALUES('', 'osman', '2000', '2018-04-14');-- id string olduğu için '' hiçlik anlamna gelir ve kabul eder.
	INSERT INTO calisanlar VALUES( '10002', 'Ayse Yılmaz' ,12000, '2018-04-14'); -- id tekrarl olamaz primary key den dolayi
	INSERT INTO calisanlar VALUES('null', 'Filiz', 12000, '2018-04-14');
-- constaint
/*INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', null, 5000, '2018-04-14');-- bunu kabul eder benzersizlik kisitlamasini bozmaz
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maas null olamaZ 
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- can zaten var unique olmadi
INSERT INTO calisanlar VALUES('10003', 'cem', '', '2018-04-14');-- bunun hatasi maas int verilmis bu hiclik
INSERT INTO calisanlar VALUES('', 'osman', '2000', '2018-04-14');-- stringde hiclik kabul edilir
INSERT INTO calisanlar VALUES( '10002', 'ayse' ,12000, '2018-04-14');-- primary key den dolayi id iki tane olamaz
INSERT INTO calisanlar VALUES( null, 'filiz' ,12000, '2018-04-14');-- primary key den dolayi null degerde giremem
*/
select * from calisanlar;


/*-------------- KISITLAMALAR (O FOREIGN KEY)----------------------------*/
      
CREATE TABLE adresler
(
   adres_id CHAR(5),     
   sokak VARCHAR(50),
   cadde VARCHAR(30),
   sehir VARCHAR(15),
   CONSTRAINT id_clsnlr FOREIGN KEY(adres_id) REFERENCES calisanlar(id) -- (solda tablo seçiliyken üstteki info dan ismi kontrol edebilirsin)
);
--  (solda tablo seçiliyken üstteki info dan ismi kontrol edebilirsin) 
-- referans olarak primary key olan kismi secmelisin calisanlar tablosundan id_fk yerine istedigin ismi verebilirsin
INSERT INTO adresler VALUES('10002','Mütlü Sok', '40.Cad.','IST'); -- baba ile yani calisanlar ile ayni olmayan id yazamssin
INSERT INTO adresler VALUES('10004','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Aga Sok', '30.Cad.','Antep');
-- parent tabloda olmayan id ile child a ekleme yapamayiz

-- FK'ye null değeri atanabilir. 
INSERT INTO adresler VALUES(NULL,'Aga Sok', '30.Cad.','Antep');

select * from adresler;


-- baglantili tablolarda child silinmeden parent silinmez bu bir **KURALDIR**
drop table calisanlar;
drop table adresler;


 
 
/*============================== ON DELETE CASCADE =============================
​
  Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelliğini aktif hale getirebiliriz.
  
  Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmak yeterli
  
==============================================================================*/ 
CREATE TABLE talebeler
    (
        id CHAR(3) primary key,  
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int
    );
    
    INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO talebeler VALUES(124, 'Merve Gül', 'Ayse',85);
	INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
	INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);


  CREATE TABLE notlar 
    ( 
        talebe_id char(3), 
        ders_adi varchar(30), 
        yazili_notu int, 
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
        REFERENCES talebeler(id) ON DELETE CASCADE); -- on delete cascade sayesinde
       -- parent taki silinen bir kayıt ile ilişkili olan tüm child kayıtlarını
       -- siler.  
       -- mesela bir hastane silindi o hastanedeki bütün kayıtlar silinmeli, oda böyle olur.
       -- cascade yoksa önce child temizlenir sonra parent
    
    INSERT INTO notlar VALUES ('123','kimya',75);
    INSERT INTO notlar VALUES ('124', 'fizik',65);
    INSERT INTO notlar VALUES ('125', 'tarih',90);
	INSERT INTO notlar VALUES ('126', 'Matematik',90);

-- FK ile birleştirilen tablolardaki tüm verileri çekmek için 
    -- JOIN İşlemi yapmak gerekir. Bu konuyu sonra göreceğiz.
    SELECT * FROM talebeler, notlar WHERE talebeler.id = notlar.talebe_id;
 
--   bunu baba icin yapamam
DELETE FROM notlar WHERE talebe_id = '123'; -- child
DELETE FROM talebeler WHERE id = '124'; -- parent
select * from talebeler;
select * from notlar;

 
 

















































