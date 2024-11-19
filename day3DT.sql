------------------Day 3 DT--------------------

/*Senaryo: "worker" ve "address" adlarinda iki tablo oluşturun.

worker tablosu sütunları: 
id CHAR(5), isim VARCHAR(50), maas INT, ise_baslama DATE

address tablosu sütunları:
adres_id CHAR(5), sokak VARCHAR(30), cadde VARCHAR(30), sehir VARCHAR(30)

Tablolari birbirine baglayarak, UNIQUE, NOT NULL uygulamasi yapiniz*/

/*Scenario: Create two tables named "worker" and "address".

worker table columns: 
id CHAR(5), name VARCHAR(50), salary INT, job_start DATE

address table columns:
address_id CHAR(5), street VARCHAR(30), street VARCHAR(30), city VARCHAR(30)

Apply UNIQUE, NOT NULL by linking tables together*/

--NOT: UNIQUE null kabul eder. Birden fazla da kabul eder cunku null bir deger degildir. Karsilastirma yapmaz

CREATE TABLE worker(
	id char(5) PRIMARY KEY, 
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date
);

CREATE TABLE address(
	adres_id char(5),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(30),
	FOREIGN KEY(adres_id) REFERENCES worker(id) 
);

SELECT * FROM worker;
SELECT * FROM address;

INSERT INTO worker VALUES('10002', 'Donatello' ,12000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10003', null, 5000, '2018-04-14'); --basarili --unique:NULL kabul eder
INSERT INTO worker VALUES('10004', 'Donatello', 5000, '2018-04-14'); --HATA name unique olmali
INSERT INTO worker VALUES('10005', 'Michelangelo', 5000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10006', 'Leonardo', null, '2019-04-12'); --HATA, maas not null cunku
INSERT INTO worker VALUES('10007', 'Raphael', '', '2018-04-14'); --HATA, maas int bekliyor biz bos String gonderdik
INSERT INTO worker VALUES('', 'April', 2000, '2018-04-14'); --Basarili, PK hiclik kabul eder ama kullanimi onerilmez
INSERT INTO worker VALUES('', 'Ms.April', 2000, '2018-04-14'); --HATA, PK 2 tane hiclik kabul etmez cunku unique'dir
INSERT INTO worker VALUES('10002', 'Splinter', 12000, '2018-04-14'); --HATA, 10002 daha once kullanildi
INSERT INTO worker VALUES(null, 'Fred', 12000, '2018-04-14'); --HATA, PK null kabul etmez
INSERT INTO worker VALUES('10008', 'Barnie', 10000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10009', 'Wilma', 11000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10010', 'Betty' ,12000, '2018-04-14'); --basarili

INSERT INTO address VALUES('10003','Ninja Sok', '40.Cad.', 'IST'); --basarili
INSERT INTO address VALUES('10003','Kaya Sok', '50.Cad.', 'Ankara'); --basarili, FK dublicate olur
INSERT INTO address VALUES('10002','Taş Sok', '30.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES('10012','Taş Sok', '30.Cad.', 'Konya'); --Hata, 10012 PK'de yok
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya');

SELECT * FROM worker;
SELECT * FROM address;

-------------------------------------

/*14- WHERE ifadesi, belirli koşulları karşılayan kayıtları seçmek için kullanılır. Bir SELECT, UPDATE ya da DELETE sorgusunda, hangi satırların işleme dahil edileceğini belirtmek için WHERE koşulu eklenir.*/

---------------------------
--worker tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose name is 'Donatello' from the worker table

SELECT * FROM worker WHERE isim = 'Donatello';

---------------------------
--worker tablosundan maaşı 5000’den fazla olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose salary is more than 5000 from the worker table

SELECT * FROM worker WHERE maas>5000;

---------------------------
--worker tablosundan maaşı 5000’den fazla olanların isim ve maaşlarını listeleyelim
--Let's list the names and salaries of those whose salary is more than 5000 from the worker table

SELECT isim, maas FROM worker WHERE maas > 5000

---------------------------
--address tablosundan sehri 'Konya' ve 
--adres_id'si 10002 olan kaydın tüm verilerini getirelim
--select the city 'Konya' from the address table and 
--Let's get all the data of the record with address_id 10002

SELECT * FROM address WHERE sehir='Konya' AND adres_id='10002';

---------------------------
--sehri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
--Let's get the street and city information for addresses whose city is 'Konya' or 'Bursa'.

SELECT cadde, sehir FROM address WHERE sehir='Konya' OR sehir='Bursa';

--------------------------
--15-Tablodan kayıt silme-DELETE FROM ... komutu:DML

/*
DELETE FROM
DML (Data Manipulation Language) Komutu: DELETE FROM bir DML komutudur. DML komutları, veritabanındaki verileri yönetir ve değiştirir.

Rollback İle Geri Alınabilir: DELETE işlemi, bir işlem (transaction) içinde yapıldığında ve işlem henüz COMMIT edilmeden ROLLBACK komutu ile geri alınabilir. COMMIT edilmişse, bu işlem kalıcı hale gelir ve veritabanında yapılan değişiklikler geri alınamaz. Ayrica, transaction kullanılmadan yapılan DELETE işlemi kalıcıdır.

Performans: Büyük tablolarda DELETE komutu yavaş çalışabilir, çünkü her bir satırı tek tek siler ve işlem sırasında log kayıtları tutar. Bu nedenle, büyük miktarlarda veriyi silmek için farklı stratejiler veya komutlar kullanmak performansı iyileştirebilir (örneğin, TRUNCATE komutu veya verileri daha küçük parçalara bölerek silmek(LIMIT ile)).*/

---------------------------------------------------------------

/*Senaryo: "students1" adinda bir tablo oluşturun.

students1 tablosu sütunları: 
id INTEGER, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu INTEGER

Tablo uzerinde cesitli silme islemleri yapiniz*/

/*Scenario: Create a table named "students1".

students1 table columns: 
id INTEGER, name VARCHAR(50), parent_name VARCHAR(50), written_note INTEGER

Perform various deletion operations on the table*/

CREATE table student1(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int    
);

select * from student1;

insert into student1 values (122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);
------------------------------------------------------

--id=123 olan kaydı silelim.
-- Let's delete the record with id=123.

DELETE FROM student1 WHERE id ='123';
------------------------------------------------------

--ismi Kemal Tan olan kaydı silelim.
-- delete the entry with the name Kemal Tan.

DELETE FROM student1 where isim ='Kemal Tan';
------------------------------------------------------

--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
-- delete records with the name Ahmet Ran or Veli Han

DELETE FROM student1 where isim = 'Ahmet Ran' or isim ='Veli Han';
---------------------------------------------------------------------

select * from students;
-----------------------------------------------------

--students tablosundan  tüm kayıtları silelim.
-- delete all records from the students table.

DELETE from students;


--NOT: DELETE FROM komutu koşulsuz kullanıldığında
--tüm satırları siler ancak tablo kalır.

--satirlari tek tek sildigi icin yavastir. Daha hizlisi var. (TRUNCATE)

-----------------------------------------------------------
--16-Tablodaki tüm kayıtları silme:TRUNCATE TABLE:DDL
/*
TRUNCATE TABLE komutunun bazı önemli özellikleri:

Hızlı Temizlik: TRUNCATE TABLE, tablodaki tüm verileri hızla silmek için kullanılır. Bu, özellikle büyük tablolar için DELETE komutundan daha verimlidir çünkü TRUNCATE log kayıtlarını daha az tutar ve tüm satırları tek seferde siler.

Koşulsuz: TRUNCATE TABLE, DELETE komutunun aksine, WHERE koşulu kullanmaz ve tablodaki tüm satırları siler.

İşlem Logları: TRUNCATE TABLE, DELETE komutuna kıyasla daha az işlem logu tutar, bu da veritabanı kaynaklarını daha az tüketmesini sağlar.

Yapıyı Korur: TRUNCATE TABLE tablonun yapısını korur, yani sütunlar ve kısıtlamalar (constraints) silinmez, sadece içerik temizlenir. (Delete'te korur)

İşlem Geri Alınamaz: Çoğu veritabanı sistemlerinde TRUNCATE TABLE komutu işlem bloğu içinde kullanılmadığı sürece geri alınamaz. Ancak, bazı sistemlerde (örneğin, PostgreSQL) TRUNCATE TABLE komutu bir işlem bloğu içinde kullanıldığında ve işlem tamamlanmadan önce ROLLBACK komutu verildiğinde geri alınabilir.*/

create table doctors (
	id serial,
	name varchar (30) not null,
	salary real,
	email varchar(50)UNIQUE
);

SELECT * from doctors;

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com');--basarılı
INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com');--HATA,hatalı name not null
INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com');--basarılı

--doctors tablosundan tüm kayıtları silelim.
--Delete all records from the doctors table.

TRUNCATE TABLE doctors;--where ile kullanılmaz... Delete from where ile de silinebilir.. Yavaş ve verimsiz ama truncate ise hem hızlı siler hemde daha az log kayıt tutar bu yüzden trancate tablo içindeki verileri daha hızlı silebiliriz..

---------------------------------------------------TODO-------------------
--17-parent-child ilişkisi olan tablolardan kayıt silme
--Delete records from tables with parent-child relationship

SELECT * FROM worker;
SELECT * FROM address;

--worker tablosundan tüm kayıtları silelim.
-- delete all records from the worker table.

DELETE FROM worker; --HATA cunku child'i var.

--worker tablosunda address tarafından referans alınan kayıtlar olduğu 
--için silmeye izin yok

DELETE FROM worker WHERE id='10002'; --HATA

--id=10002 olan kayıt adresler tarafından referans alındığı 
--için silmeye izin yok.Once child'dan iliskiyi koparalim

DELETE FROM address WHERE adres_id = '10002';
--referans alınan kayıt silindi,ilişki koparıldı

DELETE FROM worker WHERE id='10002'; --Simdi basarili

DELETE FROM address; --tum iliski koparildi
DELETE FROM worker; --artık hiçbir kayıt ref alınmadığı için başarılı.

---------------------------------------------------------------------------------------

/*Senaryo: "students2" ve "grades2" adlarinda iki tablo oluşturun.

students2 tablosu sütunları: 
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int

grades2 tablosu sütunları:
talebe_id int, ders_adi varchar(30), yazili_notu int

Tablolari birbirine baglayarak, ON DELETE CASCADE uygulamasi yapiniz*/

/*Scenario: Create two tables named "students2" and "grades2".

students2 table columns: 
id int, name VARCHAR(50), parent_name VARCHAR(50), written_note int

grades2 table columns:
student_id int, course_name varchar(30), written_note int

Apply ON DELETE CASCADE by linking the tables together*/

CREATE TABLE students2
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE grades2( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES students2(id) ON DELETE CASCADE 	
);

select * from students2;
select * from grades2;

INSERT INTO students2 VALUES--parents referans veren
(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO grades2 VALUES ---child referans alan
 ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

DELETE FROM grades2 where talebe_id =123;--child dan bir kaydı doğrudan silebiliriz..
DELETE FROM students2 where id =126;

delete from students2;
delete from grades2;

-----------------------------------------------------

--19-tabloyu silme

DROP TABLE students; ---HATA,tabloyu silemezsiniz çünkü child ı var..
DROP TABLE students CASCADE ; -- child'daki FK kopar , child tablo silinmez.

Drop table if exists student18;--varsa bu tabloyu sil, yoksa hata verme
--boyle bir tablo yoksa uygulama durmasin varsa silsin demektir(IF EXISTS)

------------------------------------------------------

--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: "customers" adinda bir tablo oluşturun.

customers tablosu sütunları: 
urun_id INTEGER, musteri_isim VARCHAR(50), urun_isim VARCHAR(50)

Tablo uzerinde IN kullanimi yapiniz*/

/*Scenario: Create a table named "customers".

customers table columns: 
product_id INTEGER, customer_name VARCHAR(50), product_name VARCHAR(50)

Use IN on the table */

CREATE TABLE customers1(
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO customers1 VALUES (10, 'Mark', 'Orange');
INSERT INTO customers1 VALUES (10, 'Mark', 'Orange');
INSERT INTO customers1 VALUES (20, 'John', 'Apple');
INSERT INTO customers1 VALUES (30, 'Amy', 'Palm');
INSERT INTO customers1 VALUES (20, 'Mark', 'Apple');
INSERT INTO customers1 VALUES (10, 'Adem', 'Orange');
INSERT INTO customers1 VALUES (40, 'John', 'Apricot');
INSERT INTO customers1 VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers1;

--1.yol:

select * from customers1 where urun_isim = 'Orange' or urun_isim = 'Apple' or urun_isim = 'Apricot';

--2.yol;

select * from customers1 where urun_isim in ('Orange','Apple','Apricot');
select * from customers1 where urun_isim not in ('Orange','Apple','Apricot');

---------------------------------------------------------------------------------------

-21-BETWEEN .. AND …

--BETWEEN operatörü, belirtilen iki değer arasında kalan değerleri seçmek için kullanılır ve her zaman AND ile birlikte kullanılır.

--customers1 tablosunda urun_id 20(dahil) ile 30(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
--List all the information of the products with product_id between 20(inclusive) and 30(inclusive) in the customers table

----20++++++++30-----

--1.yol:
SELECT *
FROM customers1
WHERE urun_id >= 20 AND urun_id <=30;

--2.yol:
SELECT *
FROM customers1
WHERE urun_id BETWEEN 20 AND 30;

-----
--customers tablosunda urun_id degeri 20’den küçük veya 30’dan büyük olan urunlerin tum bilgilerini listeleyiniz.(yani 20 ve 30 dahil değil)
--List all the information of the products whose product_id value is less than 20 or greater than 30 in the customers table (ie 20 and 30 are not included).

+++++20————30++++++++

SELECT *
FROM customers1
WHERE urun_id NOT BETWEEN 20 AND 30;

-------------------------------------------------------------------------------------------------------------------

--ODEV: Eğer kullanıcı yanlışlıkla değerleri ters girerse, bunu kontrol edip düzeltebilirsiniz. Nasil?

/*1. Veri Kontrolü ve Düzeltme Sorguları
Veri girişi sonrasında, belirli bir mantıksal kontrol yaparak verileri düzeltebilirsiniz. Örneğin, bir sipariş tablosunda "başlangıç tarihi" ve "bitiş tarihi" olup olmadığını kontrol edebilir ve gerekirse düzeltmeler yapabilirsiniz.

Örnek SQL Sorgusu
sql
UPDATE siparisler  
SET bitis_tarihi = NULL, -- ya da uygun bir değer  
    mesaj = 'Bitiş tarihi, başlangıç tarihinden önce olamaz!'  
WHERE bitis_tarihi < baslangic_tarihi;  
Bu sorgu ile bitiş_tarihi, baslangic_tarihinden önce olan kayıtları güncelleyebilir ve uygun bir hata mesajı ekleyebilirsiniz.

2. Veri Girişi Öncesi Kontrol
Veri girişini yapmadan önce, uygulama seviyesinde kullanıcı girdilerini kontrol eden mantık eklemek de etkili bir yöntemdir. Örneğin, bir form üzerinde kullanıcıdan alınan tarihleri kontrol edip, doğru sıraya getirmek için aşağıdaki mantık kullanılabilir:


3. Trigger Kullanma
Veritabanı seviyesinde, trigger kullanarak otomatik düzeltme yapabilirsiniz. Örneğin, bir TRIGGER oluşturup, bir kayıt eklendiğinde veya güncellendiğinde değerlerin doğru olup olmadığını kontrol edebilirsiniz.

Örnek Trigger
sql
CREATE OR REPLACE FUNCTION kontrol_et_trigger()  
RETURNS TRIGGER AS $$  
BEGIN  
    IF NEW.bitis_tarihi < NEW.baslangic_tarihi THEN  
        -- Değerleri değiştir  
        NEW.bitis_tarihi := NEW.baslangic_tarihi;  
    END IF;  
    RETURN NEW;  
END;  
$$ LANGUAGE plpgsql;  

CREATE TRIGGER siparis_trigger  
BEFORE INSERT OR UPDATE ON siparisler  
FOR EACH ROW  
EXECUTE FUNCTION kontrol_et_trigger();  
Bu kayıtlara yeni bir kayıt eklenmekte veya mevcut bir kayıt güncellenmekte olduğunda, baslangic_tarihi ve bitis_tarihi kontrol edilir ve gerektiğinde düzeltme yapılır.

4. Uyarı ve Bilgilendirme
Kullanıcılara veri girişi sırasında uyarılar göstererek hataların düzeltilmesine yardımcı olabilirsiniz. Kullanıcı bir değer girmeden önce veya bir form gönderirken, istenilen koşulları sağlamıyorsa hata mesajları veya uyarılar verebilirsiniz.*/

------------------------------------------------------------------
--22-AGGREGATE Fonk.

/*Senaryo: "brands" ve "employees3" adinda iki tablo oluşturun.*/
/*Scenario: Create two tables named "brands" and "employees3".*/

CREATE TABLE brands
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO brands VALUES(100, 'Vakko', 12000);
INSERT INTO brands VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO brands VALUES(102, 'Adidas', 10000);
INSERT INTO brands VALUES(103, 'LCWaikiki', 21000);

select * from brands;
SELECT * FROM employees3;

CREATE TABLE employees3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO employees3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO employees3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');













































 

















