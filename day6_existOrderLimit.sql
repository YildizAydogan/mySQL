/*=========================== EXISTS, NOT EXIST ================================
   EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanımına benzer olarak,
    EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde 
   bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar. 
   
   EXISTS operatorü bir Boolean operatördür ve true - false değer döndürür. 
    EXISTS operatorü sıklıkla Subquery'lerde satırların doğruluğunu test etmek 
    için kullanılır.
    
    Eğer bir subquery (altsorgu) bir satırı döndürürse EXISTS operatörü de TRUE 
    değer döndürür. Aksi takdirde, FALSE değer döndürecektir.
    
    Özellikle altsorgularda hızlı kontrol işlemi gerçekleştirmek için kullanılır
==============================================================================*/
   
    CREATE TABLE mart
    (
        urun_id int,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
    CREATE TABLE nisan 
    (
        urun_id int ,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
  
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
   
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
/* -----------------------------------------------------------------------------
  ORNEK1: MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID'lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/       
 select urun_id, musteri_isim
 from mart
 where urun_id in(select urun_id from nisan where mart.urun_id=nisan.urun_id);
  
 -- 2. yol  
  select urun_id, musteri_isim
 from mart
 where exists(select urun_id from nisan where mart.urun_id=nisan.urun_id);
     
    /* -----------------------------------------------------------------------------
  ORNEK2: Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/
  select urun_isim, musteri_isim
 from nisan 
 where exists(select urun_isim from mart where mart.urun_isim=nisan.urun_isim);
 -- 2. yol
 
 select urun_isim, musteri_isim from nisan as n
    where exists (select urun_isim from mart m
                    where n.urun_isim=m.urun_isim);
 
   /* -----------------------------------------------------------------------------
  ORNEK3: Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/
select urun_isim, musteri_isim from nisan as n
    where not exists (select urun_isim from mart m
                    where n.urun_isim=m.urun_isim);
    
    
    /*===================== IS NULL, IS NOT NULL, COALESCE ========================
    
    IS NULL, ve IS NOT NULL, BOOLEAN operatörleridir. Bir ifadenin NULL olup 
    olmadığını kontrol ederler.  
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi döndürür. Eğer aldığı tüm ifadeler NULL ise NULL döndürürür.
    
    sutun_adi = COALESCE(ifade1, ifade2, .....ifadeN)
    
==============================================================================*/

    CREATE TABLE insanlar 
    (
        ssn CHAR(9), -- Social Security Number
        isim VARCHAR(50), 
        adres VARCHAR(50) 
    );

    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
    
    select * from insanlar;

 -- ORNEK1 ve ORNEK2: ismi null olanlari sorgula 
    select * from insanlar where isim is null;
    select * from insanlar where isim is not null;
 /* ----------------------------------------------------------------------------
  ORNEK3: isim 'i NULL olan kişilerin isim'ine NO NAME atayınız. kisa soruda eski yolla olur
--------------------------------------------------------------------------  */   
  -- update insanlar
  -- birde set yapacim
  update insanlar set isim='NO NAME' where isim is null;
  select * from insanlar;
    
  -- tabloyu eski haline döndür  
  update insanlar set isim=null where isim='NO NAME';
  select * from insanlar;  
    
   /* ----------------------------------------------------------------------------
  ORNEK4:   isim 'i NULL olanlara 'Henuz isim girilmedi'
            adres 'i NULL olanlara 'Henuz adres girilmedi'
            ssn 'i NULL olanlara ' no ssn' atayalım.
            çoklu değişimde ve  WHERE isim IS NULL or adres is null....; 
            gibi ifade yazmamak için. coalesce=birleşmek
-----------------------------------------------------------------------------*/     
  update insanlar
  set isim=coalesce(isim, 'Henüz girilmedi'),
   adres=coalesce(adres, 'Henüz adres girilmedi'),
   ssn=coalesce(ssn, 'No ssn');
   select * from insanlar;  
   
   
   
   /*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN'a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
==============================================================================*/       
    CREATE TABLE kisiler 
    (   id int PRIMARY KEY,
        ssn CHAR(9) ,
        isim VARCHAR(50), 
        soyisim VARCHAR(50), 
        maas int,
        adres VARCHAR(50) 
    );
    
    INSERT INTO kisiler VALUES(1,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(2,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(3,345678901, 'Mine','Bulut',4200,'Adiyaman');
    INSERT INTO kisiler VALUES(4,256789012, 'Mahmut','Bulut',3150,'Adana');
    INSERT INTO kisiler VALUES (5,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (6,345458901, 'Veli','Yilmaz',7000,'Istanbul');

    INSERT INTO kisiler VALUES(7,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(8,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(9,345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler VALUES(10,256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler VALUES (11,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (12,345458901, 'Veli','Yilmaz',7000,'Istanbul');
    
    /* ----------------------------------------------------------------------------
  ORNEK1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/ 
  select * from kisiler Order by adres;  
      select * from kisiler Order by maas desc;  
    
 /* ----------------------------------------------------------------------------
  ORNEK4: ismi Mine olanları, maasa göre AZALAN sırada sorgulayınız.
-----------------------------------------------------------------------------*/
    select * from kisiler
    where isim='Mine' order by maas desc;
   select * from kisiler
    where soyisim='Bulut' order by 5;
/* ----------------------------------------------------------------------------
  ORNEK5: soyismi 'i Bulut olanları ssn sıralı olarak sorgulayınız.
-----------------------------------------------------------------------------*/    
 /*============================= GROUP BY =====================================
    
    GROUP BY cümleciği bir SELECT ifadesinde satırları, sutunların değerlerine 
    göre özet olarak gruplamak için kullanılır. 
   
    GROUP BY cümleceği her grup başına bir satır döndürür. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonları ile birlikte kullanılır.
    
==============================================================================*/ 
      
    CREATE TABLE manav 
    (
        isim varchar(50), 
        urun_adi varchar(50), 
        urun_miktari int 
    );
    
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', null, 2);
    
    
    /* -----------------------------------------------------------------------------
  ORNEK1: kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu 
  yazınız.
------------------------------------------------------------------------------*/  
    select isim, sum(urun_miktari) toplam_urun from manav
    group by isim;
    
    /* ----------------------------------------------------------------------------
  ORNEK2: satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren
  sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.
-----------------------------------------------------------------------------*/ 
select urun_adi, count(isim) kisi_sayisi
from manav
where urun_adi is not null
group by urun_adi;
-- group by ile birlikte where cümleciği kullanilabilir

/* ----------------------------------------------------------------------------
  ORNEK3: satılan meyve türüne (urun_adi) göre satılan (urun_miktari )MIN ve 
  MAX urun miktarlarini, MAX urun miktarina göre sıralayarak listeyen sorguyu 
  yazınız.
-----------------------------------------------------------------------------*/ 
select urun_adi, min(urun_miktari) min, max(urun_miktari) maks
from manav
where urun_adi is not null
group by urun_adi
order by maks;

/* ----------------------------------------------------------------------------
  ORNEK4: kisi ismine ve urun adına göre satılan ürünlerin toplamını 
  gruplandıran ve isime göre ters sırasıda listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/ 
select isim, urun_adi, sum(urun_miktari) toplam_miktar
from manav
group by isim,urun_adi
order by isim desc; 
/* ----------------------------------------------------------------------------
  ORNEK5: kisi ismine ve urun adına göre (gruplayarak) satılan ürünlerin toplamını bulan ve
  ve bu toplam değeri 3 ve fazlası olan kayıtları toplam urun miktarlarina göre
  ters siralayarak listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/  
select isim, urun_adi, sum(urun_miktari) toplam_satis
from manav
group by isim, urun_adi 
having sum(urun_miktari)>=3
order by sum(urun_miktari) desc;
-- aggregate fonksiyonlari ile ilgili bir koşul koymak için
 -- group by dan sonra having cümleciği kullanilir.

 /* ----------------------------------------------------------------------------
  ORNEK6: satılan urun_adi'na göre (gruplayarak) MAX urun sayılarını sıralayarak listeleyen 
  sorguyu yazınız. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarına 
  eşit olmayan kayıtları listelemelidir.
 -----------------------------------------------------------------------------*/    
select urun_adi, max(urun_miktari) maks
from manav
group by urun_adi 
having max(urun_miktari)!=min(urun_miktari)
order by max(urun_miktari);

-- 2. yol

 select urun_adi, max(urun_miktari)maks
 from manav
 group by urun_adi
 having max(urun_miktari)<>min(urun_miktari)
 order by max(urun_miktari);




  
-- *********************LIMIT************************* -- 
 -- Listeden ilk 10 veriyi getir
 
 select * from kisiler limit 10;
 select * from kisiler limit 10, 2; -- ilk sayi dahil degil 11 den basla, 2. sayi kadar git (2 tane git)   
  select * from kisiler where id>10 limit 2; 
  
  /* ----------------------------------------------------------------------------
  ORNEK1: MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyen sorguyu yazınız.
-----------------------------------------------------------------------------*/
SELECT * FROM kisiler
   ORDER BY maas DESC limit 3;
/*   select * from kisiler
     order by maas desc
    fetch next 3 rows only; 
   (Oracle COZUM) */
   
   /* ----------------------------------------------------------------------------
  ORNEK3: MAAŞ'a göre sıralamada 4. 5.  6. kişilerin bilgilerini listeleyen 
  sorguyu yazınız.
-----------------------------------------------------------------------------*/    
select*from kisiler order by maas desc limit  3,3;

/* ----------------------------------------------------------------------------
  ORNEK4: kisi ismine ve urun adına göre satılan ürünlerin toplamını 
  gruplandıran ve isime göre ters sırasıda listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/ 
select isim, urun_adi, sum(urun_miktari) toplam_miktar
from manav
group by isim,urun_adi
order by isim desc;



/*============================= DISTINCT =====================================
    
    DISTINCT cümleciği bir SORGU ifadesinde benzer olan satırları filtrelemek
    için kullanılır. Dolayısıyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satırlar oluşturmaya yarar.
   
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, sutun_adi3
    FROM  tablo_adı;
==============================================================================*/
/* ----------------------------------------------------------------------------
  ORNEK1: satılan farklı meyve türlerinin sayısını listeleyen sorguyu yazınız.
-----------------------------------------------------------------------------*/   
select count(distinct urun_adi) uniqlik from manav;

/* -----------------------------------------------------------------------------
  ORNEK2: satılan meyve + isimlerin farklı olanlarını listeyen sorguyu yazınız.
------------------------------------------------------------------------------*/
select distinct urun_adi farkli_meyveler, isim farkli_kisiler from manav;

/* ----------------------------------------------------------------------------
  ORNEK3: satılan meyvelerin urun_mikarlarinin benzersiz  olanlarının 
  toplamlarini listeyen sorguyu yazınız.
-----------------------------------------------------------------------------*/  
select sum(distinct urun_miktari) toplam_urun  from manav;


































































































