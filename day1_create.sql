/*======================================
			TABLO OLUSTURMA
========================================*/

CREATE TABLE student
(id varchar(4),
name varchar(25),
age int
);




/*======================================
            VERI GIRISI
=========================================*/
INSERT INTO student VALUES('1001', 'MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYSE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);





/*======================================
           PARCALI VERI GIRISI
=========================================*/
INSERT INTO student(name, age) VALUES('Yildiz Aydogan', 28);




/*======================================
           TABLODAN VERI SORGULAMA
=========================================*/
select * from student;




/*======================================
           TABLO SILME(CRUD-Crup)
=========================================*/
 drop table urunler;



















