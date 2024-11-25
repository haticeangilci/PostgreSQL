--------------------------------------------DAY 4 DT----------------
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

--employees3 tablosunda max maaş değerini bulunuz.
--Find the max salary value in the employees3 table.

SELECT max(maas)from employees3;--7000

--employees3 tablosunda min maaş değerini bulunuz.
--Find the min salary value in the employees3 table.

SELECT isim, min(maas)from employees3;--1000

--employees3 tablosunda toplam maaş değerini bulunuz.
--Find the total salary value in the employees3 table.

SELECT sum(maas)from employees3;--19000

--employees3 tablosunda ortalama maaş değerini bulunuz.
--Find the average salary value in the employees3 table.



SELECT avg(maas)from employees3;--2714.48714285714

SELECT round(avg(maas),2)from employees3;2714.29

--employees3 tablosundaki kayıt sayısını bulunuz.
--Find the number of records in the employees3 table.

SELECT count(*)from employees3;--7 yıldızla ve count la kayıt sayısı saydırıyoruz.

SELECT count(id)from employees3;--7 null olanları saymaz

--employees3 tablosunda maaşı 2500 olanların kayıt sayısını bulunuz.
--Find the number of records of those whose salary is 2500 in the employees3 table.

select * from employees3 where maas= 2500;--2 kişi varmış

--------------------------------------------------------------------
--23-ALIASES:Rumuz/Etiket/takma isim

/*Senaryo: "workers" adinda bir tablo oluşturalim.

1-calisan_id sutun ismini id olarak degistirelim
2-calisan_isim sutun ismini isim olarak degistirelim
3-workers olan tablo ismini w olarak degistirelim*/

/*Scenario: Let's create a table called "workers".

1- Let's change the name of column employee_id to id.
2-employee_name column name should be changed to name.
3- Let's change the table name workers to w*/

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM workers;

select calisan_id as id , calisan_isim as isim from workers as w;

select calisan_id  id , calisan_isim  isim from workers  w;--As kullanmadan da çalışabilir...

--------------------------------------------------------------------------
--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

--brands ve employees3 tablolarin da subquery calismasi yapalim

/*Senaryo 1: marka_id si 100 olan firmada çalışanların bilgilerini listeleyiniz.*/
/*Scenario 1: List the information of the employees of the company with brand_id 100.*/
select * from brands;
--1.yol: dinamik degil
SELECT marka_isim FROM brands WHERE marka_id = 100; --Vakko

SELECT * FROM employees3 WHERE isyeri = 'Vakko';

SELECT * FROM employees3 WHERE isyeri = (SELECT marka_isim FROM brands WHERE marka_id = 100);


----------------------------------------------------------------------------------
/*Senaryo 2: (INTERVIEW QUESTION) employees3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz.*/
/*Scenario 2: (INTERVIEW QUESTION) List all fields of the employee receiving the max salary in the employees3 table.*/

SELECT * FROM employees3 WHERE maas = 7000;

select max (maas) from employees3;
SELECT * FROM employees3 WHERE maas =(select  max(maas) from employees3);

-----------------------------------------------------------------------------------------------------------------
--Interview Question: employees3 tablosunda ikinci en yüksek maaşı gösteriniz. (ORDER BY kullanmadan cozulecek)
--Interview Question: Show the second highest salary in table employees3. (to be solved without using ORDER BY)
SELECT max (maas) FROM employees3 WHERE maas < (select  max(maas) from employees3);--3000

--------------------------------------------------------------------------------------
/*Senaryo 3: employees3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.*/
/*Scenario 3: Show all fields of employees who receive max or min salary in table employees3.*/

SELECT MIN(maas)  FROM employees3;

SELECT max(maas)  FROM employees3;

SELECT * FROM employees3 WHERE maas = (SELECT MIN(maas)  FROM employees3) OR 
								maas = (SELECT max(maas)  FROM employees3);

------------------------------------------------------------------------------------------------
/*Senaryo 4: Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.*/
/*Scenario 4: List the brand ids and number of employees of brands with employees in Ankara.*/

SELECT marka_id,calisan_sayisi 
FROM brands 
where marka_isim IN (SELECT isyeri FROM employees3 where sehir ='Ankara');

SELECT isyeri FROM employees3 where sehir ='Ankara';

--------------------------------------------------------------------------------------------------
/*Senaryo 5: marka_id'si 101’den büyük olan marka çalişanlarinin tüm bilgilerini listeleyiniz.*/
/*Scenario 5: list all information of brand employees with brand_id greater than 101.*/

SELECT * 
FROM employees3 
WHERE isyeri in (select marka_isim from brands where marka_id > 101);


--------------------------------------------------------------------------------------------
/*Senaryo 6: Çalisan sayisi 15.000’den cok olan markalarin isimlerini, calisanlarin isimlerini ve maaşlarini listeleyiniz.*/
/*Scenario 6: List the names of brands with more than 15,000 employees, the names of the employees and their salaries.*/

SELECT isim,maas,isyeri
FROM employees3 
WHERE isyeri in (select marka_isim from brands where calisan_sayisi > 15000);

------------------------------------------------------------------------------------------------
--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

/*Senaryo 7: Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.*/
/*Scenario 7: Write a QUERY that lists the id, name and total number of cities each brand is located in.*/

SELECT marka_id, marka_isim,(SELECT COUNT (sehir) FROM employees3 where isyeri=marka_isim) from brands;


SELECT * FROM employees3;
SELECT * FROM brands;

---------------------------------------------------------------------------------------------------------

/*Senaryo 8: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir sorgu yaziniz.*/
/*Scenario 8: Write a query that lists the name of each brand, the number of employees, and the maximum and minimum salary of the employees of that brand.*/

SELECT marka_isim,calisan_sayisi, (SELECT MAX(maas)from employees3 where isyeri =marka_isim),
									(SELECT MIN(maas)from employees3 where isyeri =marka_isim) FROM brands;	

-----------------------------------------------------------------------------------------------------------
--25-EXISTS Condition

/*Senaryo 1: "march" ve "april" adlarinda iki tablo oluşturunuz ve Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario : Create two tables named "march" and "april" and list the information of all products in April if 'Toyota' was sold in March.*/

CREATE TABLE march
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO march VALUES (10, 'Mark', 'Honda');
INSERT INTO march VALUES (20, 'John', 'Toyota');
INSERT INTO march VALUES (30, 'Amy', 'Ford');
INSERT INTO march VALUES (20, 'Mark', 'Toyota');
INSERT INTO march VALUES (10, 'Adam', 'Honda');
INSERT INTO march VALUES (40, 'John', 'Hyundai');
INSERT INTO march VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE april 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO april VALUES (10, 'Hasan', 'Honda');
INSERT INTO april VALUES (10, 'Kemal', 'Honda');
INSERT INTO april VALUES (20, 'Ayse', 'Toyota');
INSERT INTO april VALUES (50, 'Yasar', 'Volvo');
INSERT INTO april VALUES (20, 'Mine', 'Toyota');

SELECT * FROM march;
SELECT * FROM april;

SELECT * FROM april where exists (select * from march where urun_isim='Toyota');--bak bakalım mart ayında toyata satışı oldumu .. Olduysa Nisanın tüm listesini getir..İf koşulu gibi düşünülmüş ama çok sağlıklı değil.
---------------------------------------------------------------------------------------------

--*Senaryo 2: Mart ayında 'Volvo' satışı yapılmışsa, Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario 2: If 'Volvo' was sold in March, list the information of all products in April.*/

SELECT * FROM april
WHERE EXISTS (SELECT * FROM march WHERE urun_isim ='Volvo' );
------------------------------------------------------------------------------
/*Senaryo 3: Mart ayında satılan ürünlerin urun_id ve musteri_isim'lerini, eğer urun(urun_isim) Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız.*/
/*Scenario 3: Write a query that lists the product_id and customer_name of the products sold in March, if the product(urun_isim) was also sold in April.*/

SELECT urun_id,musteri_isim FROM march AS m
WHERE EXISTS (SELECT * FROM april AS a where a.urun_isim =  m.urun_isim );
--------------------------------------------------------------------------------------------
/*Senaryo 4: Her iki ayda birden satılan ürünlerin urun_isim'lerini, bu ürünleri NİSAN ayında satın alan musteri_isim'lerine gore listeleyen bir sorgu yazınız*/
/*Scenario 4: Write a query that lists the product names of the products sold in both months according to the customer names that purchased these products in APRIL*/

SELECT urun_isim,musteri_isim FROM april a
WHERE EXISTS(SELECT * FROM march m WHERE  m.urun_isim= a.urun_isim);

----------------------------------------------------------------------------------

-- ÖDEV: Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan musteri isimlerini listeleyen bir sorgu yazınız.
-- HOMEWORK: Identify the product names of the products that were sold in March but not in April and
--Write a query that lists the names of customers who purchased in March.

SELECT urun_isim, musteri_isim FROM march m
WHERE NOT EXISTS (SELECT * FROM april a WHERE a.urun_isim = m.urun_isim);

--NOT EXISTSKullanımı
--dosya WHEREdosyalarında bir tabloya bağlı olmayan veya bunlarla ilişkili olmayan kayıtların bulunması için kullanılır.

-----------------------------------------------------------------------------------------

--26-UPDATE tablo_adı SET sütunadı=yeni değer 
--WHERE koşul 
-- koşulu sağlayan kayıtlar güncellenir

--employees4 adli bir tablo olusturalim

/*Senaryo 1: employees4 adli bir tablo olusturunuz. id'si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/
/*Scenario 1: Create a table named employees4. update the workplace name of the employee whose id is 123456789 to 'Trendyol'.*/

CREATE TABLE employees4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO employees4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO employees4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO employees4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO employees4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM employees4;

UPDATE employees4 
SET isyeri = 'Trendyol' 
WHERE id=123456789;

---------------------------------------------------------------------------------
/*Senaryo 2: id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/
/*Scenario 2: Update the name of the employee whose id is 567890123 as 'Veli Yıldırım' and the city as 'Bursa'.*/

UPDATE employees4 
SET isim = 'Veli Yıldırım' , sehir = 'Bursa'
WHERE id = 567890123;

----------------------------------------------------------------------------------------
/*Senaryo 3: brands tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.*/
/*Scenario 3: change the marka_id of brands in the brands table with a marka_id greater than or equal to 102 by multiplying by 2.*/

select * from brands;

UPDATE brands 
SET  marka_id=marka_id*2 
WHERE marka_id >=102;

------------------------------------------------------------------------------------------TODO--
/*Senaryo 4: brands tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/
/*Scenario 4: Update the calisan_sayisi values of all brands in the brands table by adding them with marka_id.*/

UPDATE brands SET calisan_sayisi = calisan_sayisi+marka_id;














									







								






















