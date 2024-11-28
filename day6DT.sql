------------------Day 6 DT--------------------

--31- UNION - UNION ALL ifadesi

CREATE TABLE developers(
	id SERIAL PRIMARY KEY,
	name varchar(50),
	email varchar(50) UNIQUE,
	salary real,
	prog_lang varchar(20),
	city varchar(50),
	age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','btl@mail.com',4000,'C#','Bursa',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayse Gul','ayse@mail.com',4000,'C#','Ankara',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ali Seker','ali@mail.com',4000,'C#','Ankara',29);

CREATE TABLE contact_info(
	address_id int,
	street varchar(30),
	number int,	
	city varchar(30),
	FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');

SELECT * FROM developers;
SELECT * FROM contact_info;
SELECT * FROM employees4; 

/*Senaryo 1: Ankara'da yaşayan developer ve İstanbul'da yaşayan çalışanların(employees4) isimlerini birlikte tekrarsız gösteren sorguyu yaziniz*/

/*Scenario 1: Write the query that shows the names of the developer living in Ankara and the employees (employees4) living in Istanbul together without duplicates*/

SELECT name FROM developers WHERE city = 'Ankara'
UNION
SELECT isim FROM employees4 WHERE sehir = 'Istanbul';

--developer ve çalışanların(employees4) isimlerini birlikte tekrarlı gösteren sorguyu yaziniz
--Write the query that shows the names of developer and employees(employees4) repeatedly together

SELECT name FROM developers WHERE city = 'Ankara'
UNION ALL
SELECT isim FROM employees4 WHERE sehir = 'Istanbul';

--union mantigi veri setlerini birlestirmedir, ancak veri type'lari ayni ya da uyumlu olmak zorundadir.

/*Senaryo 2: Yaşı 25’den büyük olan developer isimlerini ve yaşı 30'dan küçük developerların kullandığı prog. dillerini birlikte tekrarlı gösteren sorguyu yaziniz*/

/*Scenario 2: Write the query that shows the names of developers older than 25 and the prog. languages used by developers younger than 30 repeatedly together*/

SELECT name AS name_prog_lang FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age < 30;

/*Senaryo 3: Java kullananların maaşı ile şehrini ve 
Vakko'da çalışanların maaşı ile şehrini tekrarsız gösteren sorguyu yaziniz*/

/*Scenario 3: The salary of Java users and the city 
Write the query that shows the salary and city of Vakko employees without duplicate*/

--NOT:UNION/UNION ALL birleştirdiğimiz sorgular
--aynı sayıda sütun göstermeli ve alt alta
--gelecek olan sütunların data tipleri aynı olmalı

SELECT * FROM developers;
SELECT * FROM contact_info;
SELECT * FROM employees4; 

select salary,city 
from developers
where prog_lang ='Java'
UNION
select maas, sehir 
from employees4
where isyeri ='Vakko';

--not : UNION ve UNION ALL select sorgularında istediğimiz kadar sorgu çalıştırabiliriz. Sınır yoktur. Ancak iyi bir performans ve okunabilirlik için her zaman dikkatli olunmalıdır.

/*Senaryo 4: id'si 8 olan developer'ın çalıştığı şehir ile maaşını ve iletişim adresindeki şehir ile kapı nosunu görüntüleyiniz.*/
/*Scenario 4: Display the city and salary of the developer with id 8 and the city and door number of his contact address.*/

select city,salary 
from developers
where id=8
union 
select city,number 
from contact_info
where address_id = 8;
-----------------------------------------------------------------------
--32- INTERSECT ve EXCEPT

/*Senaryo 1: developers tablosundaki şehirler ve employees4 tablosunda sehirlerin
aynı olanlarını tekrarsız olarak listeleyiniz*/

/*Scenario 1: cities in the developers table and cities in the employees4 table
list the same ones without repetition*/

select city from developers
INTERSECT
select sehir from employees4;
----------
/*Senaryo 2: developers tablosunda Java kullananların çalıştıkları şehirler ve employees4 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
ortak olanlarını listeleyiniz.*/

/*Scenario 2: the cities where Java users work in the developers table and the cities of those whose salary is more than 1000 in the employees4 table 
List the common ones.*/

SELECT * FROM developers;
SELECT * FROM contact_info;
SELECT * FROM employees4; 

select city from developers where prog_lang ='Java'
intersect
select sehir from employees4 where maas>1000;

--Hangi tablonun uste yazilacagi onemli degildir
---------------------------------------------
/*Senaryo 3: developers tablosundaki şehirleri,
employees4 tablosundaki sehirler hariç olarak listeleyiniz*/
/*Scenario 3: cities in the developers table,
list excluding cities in the employees4 table*/

select city from developers
except
select sehir from employees4; 

--Hangi tablonun uste yazilacagi onemlidir.. 
--------------------------------------------------
/*Senaryo 4: employees4 tablosundaki şehirleri,
developers tablosundaki sehirler hariç olarak listeleyiniz*/
/*Scenario 4: cities in the employees4 table,
list excluding cities in the developers table*/

select sehir from employees4
EXCEPT
select city from developers
----------------------------------------------
--ÖDEV1:march ve april tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz. 
select musteri_isim from march 
UNION
select musteri_isim from april;
--ÖDEV2:march ve april tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
select musteri_isim from march 
INTERSECT
select musteri_isim from april;
--ÖDEV3:march ayında satılıp april ayında satılmayan ürünlerin isimlerini listeleyiniz.
SELECT musteri_isim FROM march
EXCEPT
select musteri_isim from april;
------------------------------------
----33- JOIN
--INNER JOIN: baz aldığımız sütundaki sadece ortak olan kayıtları getirir
--Bu sorgu, companies2 ve orders tablolarını sirket_id sütunu üzerinden ilişkilendirir.
--iki tablo arasındaki ortak kayıtları döndürür ve sadece eşleşen satırlar sonuçta yer alır..

--Araştırma:primary key ve foreign key olan tablolarda join işlemi yapabiliyormuyuz?
/*Evet, bir veritabanında birincil anahtar (primary key) ve yabancı anahtar (foreign key) ilişkisi olan tablolar arasında JOIN işlemi yapabilirsiniz. Bu ilişki, tablolar arasındaki bağlantıyı sağlamak ve verilerin bütünlüğünü korumak için kullanılır. JOIN işlemi, bir tabloda olan verileri, başka bir tabloyla ilişkilendirmek ve bir arada görüntülemek için kullanılır.*/

CREATE TABLE companies2  (
sirket_id int,  
sirket_isim varchar(20)
);

INSERT INTO companies2 VALUES(100, 'IBM');
INSERT INTO companies2 VALUES(101, 'GOOGLE');
INSERT INTO companies2 VALUES(102, 'MICROSOFT');
INSERT INTO companies2 VALUES(103, 'APPLE');

CREATE TABLE orders (
siparis_id int,
sirket_id int,
siparis_tarihi date
);

INSERT INTO orders VALUES(11, 101, '2023-02-17');  
INSERT INTO orders VALUES(22, 102, '2023-02-18');  
INSERT INTO orders VALUES(33, 103, '2023-01-19');  
INSERT INTO orders VALUES(44, 104, '2023-01-20');  
INSERT INTO orders VALUES(55, 105, '2022-12-21');

SELECT * FROM companies2
SELECT * FROM orders 

/*Senaryo 1: Asagida bulunan iki tablodaki şirket id'si aynı olanların şirket id, şirket ismi, sipariş tarihini, sipariş id'sini  listeleyiniz.*/
/*Scenario 1: List the company id, company name, order date, order id of those with the same company id in the two tables below.*/

SELECT c.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM companies2 as c
INNER JOIN orders as o ON c.sirket_id = o.sirket_id;

-- ON ile soft relationship yaptik. Tablo sirasi inner join'de onemli degil.
-----------------------------------------------------
--34-LEFT JOIN: Baz aldığımız sütundaki, SOL(ilk) tablodaki tüm kayıtları getirir.
--RIGHT JOIN: Baz aldığımız sütundaki, SAĞ(ikinci) tablodaki tüm kayıtları getirir.

/*Senaryo 2: companies2 tablosundaki tüm kayıtların şirket id, şirket ismi,
sipariş tarihini, sipariş id'sini listeleyiniz.*/

/*Scenario 2: Company id, company name of all records in companies2 table,
list order date, order id.*/

--1.yol-join
select c.sirket_id,sirket_isim,siparis_tarihi,siparis_id 
from companies2 as c
LEFT JOIN orders as o ON c.sirket_id=o.sirket_id;
--2.yol-subquery
SELECT c.sirket_id, c.sirket_isim,  
       (SELECT o.siparis_tarihi FROM orders o WHERE o.sirket_id = c.sirket_id LIMIT 1) AS siparis_tarihi,  
       (SELECT o.siparis_id FROM orders o WHERE o.sirket_id = c.sirket_id LIMIT 1) AS siparis_id  
FROM companies2 AS c;

-- Left join doğru tabloları alın aksi durumda yeri değişir...
-------------------------------------------------------------------------------

--ARASTIRMA ODEVI: Normalde bu soruyu subquery ile de yapabilirdik. Peki JOIN ile yapmanin farki ne?
--Bu soruyu subquery ile cozunuz.
/*Farklar

1-Performans:

JOIN kullanmak genellikle daha iyi performans gösterir, çünkü JOIN işlemi genellikle daha verimlidir. Bir JOIN ile, daha az sorgu yazılarak veriler doğrudan bir arada elde edilebilir.
Alt sorgular, özellikle büyük veri setlerinde verimsiz hale gelebilir çünkü her bir satır için alt sorgu çalıştırılır. Bu, toplamda çok fazla sorgunun çalışmasına neden olabilir.

2-Okunabilirlik:

JOIN ifadeleri, veritabanı yapısını ve ilişkileri daha açık bir şekilde gösterir. Karmaşık veritabanı yapılarında daha anlaşılır olabilir.
Alt sorgular ise daha karmaşık hale gelebilir, çünkü ana sorgu içindeki alt sorgular birçok yerde kullanılabilir, bu da sorgunun okunabilirliğini azaltabilir.*/
-------------------------------------------------------------------------------------
/*Senaryo 3: orders tablosundaki tüm kayıtların şirket id, şirket ismi,
sipariş tarihini, sipariş id'sini  listeleyiniz.*/ 

/*Scenario 3: company id, company name of all records in the orders table,
list order date, order id.*/

SELECT * FROM companies2
SELECT * FROM orders 

--1.yol left join
SELECT orders.sirket_id, sirket_isim, siparis_id, siparis_tarihi
FROM orders LEFT JOIN companies2 ON companies2.sirket_id = orders.sirket_id;
--2.yol right JOIN
SELECT orders.sirket_id, sirket_isim, siparis_id, siparis_tarihi
FROM companies2 RIGHT JOIN orders ON companies2.sirket_id = orders.sirket_id;
--NOT:LEFT/RIGHT JOIN tablo sırası değiştirilerek birbirinin yerine alternatif olarak kullanılabilir.
-----------------------------------------------------------------------
--35-FULL JOIN: Baz aldığımız sütundaki, her iki tablodaki tüm kayıtları getirir.

/*Senaryo 4: Her iki tablodaki tüm kayıtları listeleyiniz.*/
/*Scenario 4: List all records in both tables.*/

SELECT *
FROM companies2 
full join orders 
ON companies2.sirket_id = orders.sirket_id;
----------------------------------------------------------
--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar.

CREATE TABLE staff  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO staff VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO staff VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO staff VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO staff VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM staff;
/*Senaryo 5: Her bir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.*/
/*Scenario 5: Create a query that gives the name of each staff member and the name of his/her manager.*/

SELECT p.isim as personel ,m.isim as yonetici
from staff p INNER JOIN staff m
ON p.yonetici_id=m.id
-----------------------------------------------------
--37- LIKE, ILIKE

SELECT * FROM developers;
SELECT * FROM developers WHERE name = 'Ayse Gul';

--wildcard(joker, %): 0 veya daha fazla karakteri temsil eder
-- "_" (Alt tire tek bir karekteri temsil eder..)

--1.LIKE
SELECT * 
FROM developers 
WHERE name LIKE 'A%';--a,A,büyük küçük harfe duyarlıdır..
--1.ILIKE
SELECT * 
FROM developers 
WHERE name ILIKE 'a%';--a,A,büyük küçük harfe duyarsız...
----------------------------------------
--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
--Write QUERY, whose name starts with T and ends with the letter n, to write the names of giants and their salaries

SELECT name,salary 
FROM developers 
WHERE name LIKE 'T%n';--Tan,Tn  büyük küçük harfe duyarlıdır..
-------------------------------------
--Ismi soyismi içinde 'an' olan dev isimlerini ve soyisimlerini ve maaşlarını yazdiran QUERY yazin
--Write QUERY with 'an' in the first name, last name and surname and their salaries

select name,salary
from developers
where name LIKE '%an%';
---------------------------------------------------
--Ismi içinde e ve a olan developerlarin tüm bilgilerini yazdiran QUERY yazin
--Write QUERY that prints all the information of developers with e and a in their name

--1.yol
select * 
from developers
where name LIKE '%e%a%' OR name LIKE '%a%e%';

--2.yol*****
select * 
from developers
where name LIKE '%e%' and name LIKE '%a%';

--underscore(_)=sadece 1 karakteri temsil eder.

--Isminin ikinci harfi u olan developerlarin tum bilgilerini yazdiran QUERY yazin
--Type QUERY, which prints all the information of developers with the second letter u in their name.

select * 
from developers
where name LIKE '_u%';

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan developerlarin tum bilgilerini yazdiran QUERY yazin
--Write QUERY that prints all the information of developers whose prog. language has 4 letters and the third letter is v

select * 
from developers
where prog_lang LIKE '__v_'
AND length(prog_lang)=4;

--ÖDEV1 : Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan developerlarin tum bilgilerini yazdiran QUERY yazin.
select * 
from developers
where prog_lang LIKE 'J____%'
AND length(prog_lang)>=5;
--ÖDEV2:  Isminin 2. harfi e,4. harfi y olan developerlarin tum bilgilerini yazdiran QUERY yazin. 
select * 
from developers
where name ILIKE '_e_y%';
--ÖDEV3:  ismi boşluk içeren developerlarin tum bilgilerini yazdiran QUERY yazin.
select * 
from developers
where name ILIKE '% %';
-----------------------------------------------------------------------------------
--38- Regular Expressions (Regex) Duzenli Ifadeler 
--~;(tilde)Bu operatör büyük küçük harfe duyarlı eşleşme.. 
--~*;Bu operatör büyük küçük harfe duyarsız eşleşme..
--!~;Bu operatör büyük küçük harfe duyarlı değil(duyarsız) eşleşme.. 
--!~*;Bu operatör büyük küçük harfe duyarsız değil(duyarlı) eşleşme.. 
/*Not: PostgreSQL, doğrudan REGEXP_LIKE fonksiyonunu desteklemez. REGEXP_LIKE bir
Oracle SQL fonksiyonudur ve bir metin ifadesinin belirli bir düzenli ifade
(regular expression) kalıbına uyup uymadığını kontrol etmek için kullanılır.

https://www.postgresql.org/docs/current/functions-matching.html
*/

--1. '[cb]at' ==> 'cat' veya 'bat' ile eşleşir. Bir kelimenin icinde cat olsa o da eslesir.
select 'cat' ~ '[cb]at' as result;--true (içinde eşleşme varmı)[]içindeki harfler başlıyor olanlar..
select 'dat' ~ '[cb]at' as result;--false (içinde eşleşme varmı)
--2. [0-9] ==> 0 ile 9 arası
select '4' ~ '[0-9]' as result;--true (içinde varmı diye eşleştirir.. İçinde varmı?)
select '14' ~ '[0-9]' as result;--true (içinde varmı diye eşleştirir..Tek tek sayıları eşleştirir.. İçinde varmı?)
--3. [a-zA-Z] ==> A’dan Z’ye veya a’dan z’ye aralığı
select 'm' ~ '[a-zA-Z]' as result;--true
select '123a' ~ '[a-zA-Z]' as result;--true
select '123' ~ '[a-zA-Z]' as result;--false
--4. [^a-e] ==> a'dan e'ye aralığının dışı
select 'z' ~ '[^a-e]' as result;--true
select 'a' ~ '[^a-e]' as result;--false---(^dışında kalanlar )
--5. ^ - Satırın Başlangıcı
select 'hello world' ~ '^hel' as result;--true(başlangıcı kontrol eder..)
--6. $ - Satırın Sonu
select 'hello world' ~ 'hel$' as result;--false (sonu bitiyor..)
select 'hello world' ~ 'ld$' as result;--true (sonu bitiyor..)
--7. .* - Sıfır veya Daha Fazla Karakter
select '123abc456' ~ '.*abc' as result;--true başı ne olursa olsun içinde daha daha fazla karakter sayısını kontrol eder..
--8. . - Herhangi Bir Tek Karakter
select 'cat' ~ '.a.' as result;--true















































