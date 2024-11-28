------------------Day 7 DT--------------------
--38- Regular Expressions (Regex) Duzenli Ifadeler

------------------
--person tablosundaki soyismi Bulut olanları isme göre (azalan) sıralayarak listeleyiniz.
--List the people whose surname is Bulut in the person table in descending order by name.
SELECT *
FROM person
WHERE soyisim = 'Bulut'
ORDER BY isim DESC;

--alternatif******
SELECT *
FROM person
WHERE soyisim = 'Bulut'
ORDER BY 2 DESC;--2 ilk sütunu sayma ikinci sütun soyisim i buluyor...

CREATE TABLE words
(
 word_id int UNIQUE,
 word varchar(50) NOT NULL,
 number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

select * from words;
---------------------------------------------------------------------------
--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--put the letter a or i after the letter h and then the letter t
--Write QUERY, which prints all the information of the words containing it.
--hat/hit
--ahata,ahit,hatip

--CASE-SENSITIVE
select* 
from words 
where word ~ 'h[ai]t' ;--veya sorusu gelirse [] köşeli parentez içerisinde belirtiyoruz.

---CASE-INSENSITIVE
select* 
from words 
where word ~* 'h[ai]t' ;--veya sorusu gelirse [] köşeli parentez içerisinde belirtiyoruz.
---------------------------------------------------------------------------
--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
--After the letter h, add one of the letters between a and k, then the letter t
--Write QUERY, which prints all the information of the words containing it.
select* 
from words 
where word ~* 'h[a-k]t' ;--ile sorusu gelirse [-] köşeli parentez içerisinde -(a dan k ye) belirtiyoruz.Büyük-küçük harf duyarsız..
---------------------------------------------------------------------------
-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- Type QUERY, which prints all the information of words containing m or i
--mat,ilk
select* 
from words 
where word ~* '[mi]' ;
---------------------------------------------------------------------------
-- ^:kelimenin başlangıcını gösterir
-- $:kelimenin sonunu gösterir 

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words starting with a
select* 
from words 
where word ~* '^a' ;
---------------------------------------------------------------------------
-- m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words ending with m
SELECT *
FROM words
WHERE word ~* 'm$';
---------------------------------------------------------------------------
--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
-- type QUERY which prints all information of words starting with a or s
SELECT *
FROM words
WHERE word ~* '^[as]';
---------------------------------------------------------------------------
-- (.*):0 veya daha fazla karakteri temsil eder. (% gibi)
-- (.):sadece 1 karakteri temsil eder. (_ gibi)

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
-- Type QUERY, which prints all the information of words starting with y and ending with f
SELECT *
FROM words
WHERE word ~* '^y.f$';--yaf
SELECT *
FROM words
WHERE word ~* '^y(...)f$';--yusuf
SELECT *
FROM words
WHERE word ~* '^(y.*)f$';--yusuf,yaf
--------------------------------------------------------------
--39-String Fonksiyonlar

CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,	
city varchar(20),
course_name varchar(20),
salary real	
);
INSERT INTO teachers VALUES(111,'AhmeT  ','  Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran ',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,' Bilal','Fan ',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal',' San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz',' Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'ekreM','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'fatiH','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);

SELECT * FROM teachers;
------------------------------------------------------
--teachers tablosundaki tüm kayıtların 
--firstname değerlerini büyük harfe, 
-- lastname değerlerini küçük harfe çevirerek, 
--uzunlukları ile birlikte listeleyiniz.

--all records in the teachers table
--firstname values to uppercase,
-- converting lastname values to lowercase,
--list them with their lengths.

select UPPER(firstname) as fname, Length(firstname),lower(lastname)as lname,length(lastname) 
from teachers;
------------------------------------------------------
--teachers tablosunda firstname ve lastname değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

--in the firstname and lastname values in the teachers table
--remove the starting and trailing spaces.
UPDATE teachers
SET firstname = TRIM(firstname),lastname=TRIM(lastname);
SELECT * FROM teachers;
------------------------------------------------------------
--teachers tablosunda tüm kayıtların firstname değerlerini
-- ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

--get the firstname values of all records in the teachers table
-- display by changing the first letter to uppercase and the rest to lowercase.
SELECT INITCAP(firstname)
FROM teachers;
--------------------------------------------------------------
--teachers tablosunda firstname değerlerinde ‘Celal’ kelimesini ‘Cemal’ ile değiştiriniz.
--Replace the word ‘Celal’ with ‘Cemal’ in the firstname values in the teachers table.
UPDATE teachers 
SET firstname=REPLACE(firstname,'Celal','Cemal');

------------------------------------------------------------------
SELECT * FROM employees4;

--employees4 tablosunda isyeri='Vakko' olan kayıtlarda 
--son ' Şubesi' ifadesini siliniz.

--in records with workplace='Vakko' in the employees4 table
--end Delete the ‘ Şubesi' statement.
select substring (' Şubesi',1,7); 

UPDATE employees4
SET sehir = substring (sehir, 1,length(sehir)-7)
WHERE isyeri= 'Vakko';

--Sadece ilk harfleri istese;
select SUBSTRING(sehir,1,1)
from employees4;
SELECT SUBSTRING(sehir, 2, 4)
FROM employees4; --2'den basla 4 karakter al, stan

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.
--Display all words and the first 2 letters of all words in the words table.

select * from words;
select word,SUBSTRING(word,1,2)
from words;
----------------------------------------------------------
--40- LIMIT / OFFSET - FETCH NEXT n ROW ONLY

SELECT * FROM developers

Example:
SELECT * 
FROM developers 
ORDER BY id OFFSET 5 ROWS FETCH NEXT 3 ROWS ONLY;--ilk beş satırı atla sonrasında 3 satırı getir..--6-7-8satırları getirir.
--------------------------------------------------------
--Senaryo 1: developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.
--Scenario 1: Get the first 3 records from the developers table in order of insertion.
--1.yol
SELECT *
FROM developers
FETCH NEXT 3 ROW ONLY;--iLK 3 satırı getirir.
--2.yol
SELECT * 
FROM developers
LIMIT 3;--İLK 3 satırı getirir.
------------------------------------------------------
/*Senaryo 2: developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.*/
/*Scenario 2: Fetch the first 3 records after the first 2 records from the developers table in order of insertion.*/
SELECT *
FROM developers
OFFSET 2--ilk 2 kaydı atla
LIMIT 3;--sonraki 3 kaydı al..
------------------------------------------------------
/*Senaryo 3: developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.*/
/*Scenario 3: Bring the first 3 records with the lowest salaries from the developers table.*/
SELECT *
FROM developers
ORDER BY salary--küçükten büyüğe sıralar
LIMIT 3;--ilk 3 kaydı getirir.
------------------------------------------------------
/*Senaryo 4: developers tablosundan maaşı en yüksek 2. developer'ın tüm 
bilgilerini getiriniz.*/

/*Scenario 4: From the developers table, the developer with the 2nd highest salary
Please bring your information.*/
SELECT *
FROM developers
ORDER BY salary DESC--büyükten küçüğe sıralar
OFFSET 2--1 tane atla
LIMIT 1;--1 kayıt al
-----------------------------------------------------------------
--41- ALTER TABLE ifadesi-DDL
/*Senaryo 1: employees4 tablosuna yas (int) seklinde yeni sutun ekleyiniz.*/
/*Scenario 1: Add a new column in the form of age (int) to the employees4 table.*/

alter table employees4 add column yas INT;
select * from employees4;
-------------------------------------------------------------------------------
/*Senaryo 2: employees4 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
varsayılan olarak remote değeri TRUE olsun*/
/*Scenario 2: Add a new column as remote (boolean) to the employees4 table.
By default, the remote value is TRUE */

alter table employees4 add column remote boolean DEFAULT true;
-------------------------------------------------------------------------------
/*Senaryo 3: employees4 tablosunda yas sutununu siliniz.*/
/*Scenario 3: Delete the age column in the employees4 table.*/

alter table employees4
drop column yas;
-------------------------------------------------------------------------------
/*Senaryo 4: employees4 tablosundaki maas sutununun data tipini 
real olarak güncelleyiniz.*/
/*Scenario 4: Set the data type of the salary column in the employees4 table
Update it to real.*/

ALTER TABLE employees4
alter column maas
type real;
select * from employees4;
-------------------------------------------------------------------------------
/*Senaryo 5: employees4 tablosundaki maas sutununun ismini 
gelir olarak güncelleyiniz.*/
/*Scenario 5: Name the salary column in the employees4 table
Update as income.*/
ALTER TABLE employees4
rename column maas to gelir;

select * from employees4;
-------------------------------------------------------------------------------
/*Senaryo 6: employees4 tablosunun ismini employees5 olarak güncelleyiniz.*/
/*Scenario 6: Update the name of the employees4 table to employees5.*/

alter table employees4
rename to employees5;

select * from employees5;
-------------------------------------------------------------------------------
/*Senaryo 7: employees5 tablosunda id sütununun data tipini 
varchar(20) olarak güncelleyiniz.*/
/*Scenario 7: Set the data type of the id column in the employees5 table
Update it to varchar(20).*/

alter table employees5
alter column id type varchar(20);
-------------------------------------------------------------------------------
/*Senaryo 8: employees5 tablosunda id sütununun data tipini 
int olarak güncelleyiniz.*/
/*Scenario 8: Set the data type of the id column in the employees5 table
Update as int.*/
alter table employees5
alter column id type integer USING id::integer;
-------------------------------------------------------------------------------
/*Senaryo 9: employees5 tablosunda isim sütununa 
NOT NULL constrainti ekleyiniz.*/
/*Scenario 9: Name column in employees5 table
Add NOT NULL constraint.*/

alter table employees5
alter column isim set Not Null;
insert into employees5 (id,sehir)values(123,'Ankara');--null value in column "isim" of relation "employees5" violates not-null constraint

-------------------------------------------------------------------------------
/*Senaryo 1: companies2 tablosunda sirket_id sütununa PRIMARY KEY constraint'i ekleyiniz.*/
/*Scenario 1: Add the PRIMARY KEY constraint to the company_id column in the companies2 table.*/
--NOT: içinde kayıtlar bulunan bir tablo güncellenirken,
--NOT NULL,PK,FK,UNIQUE,CHECK kısıtlamalarını ekleyebilmek için
--bu sütunun değerleri, ilgili kısıtlamayı sağlıyor olmalıdir
ALTER TABLE companies2
ADD /*CONSTRAINT companies2_pk */ PRIMARY KEY(sirket_id);

select * from companies2;
--------------------------------------------------------------
/*Senaryo 2: companies2 tablosunda sirket_isim sütununa UNIQUE constrainti ekleyiniz.*/
/*Scenario 2: Add UNIQUE constraint to the company_name column in the companies table.*/
ALTER TABLE companies2
ADD UNIQUE(sirket_isim);
-----------------------------------------------------
--Bir tablodaki kisitlamalari gosterir
SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 
(SELECT oid FROM pg_class WHERE relname = 'companies2');

-------------------------------------------------------------------------------






































