--------------------------------------------------------------------------------
--9-Tabloya UNIQUE constraint'i ekleme
--Bir sütuna tekrarlı verilerin eklenememesi için tablo ve sütunları tanımlanırken UNIQUE kısıtlaması eklenir.

/*Senaryo: "programmers" adında bir tablo oluşturun ve şu sütunları ekleyin:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
ve email'i unique yapin*/

/*Scenario: Create a table named "programmers" and add the following columns:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
and make the email unique*/

CREATE TABLE programmers(
id SERIAL,
NAME VARCHAR(30),
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20)
);

SELECT * FROM programmers;

insert into programmers(name,email,salary,prog_lang) values ('Tom', 'mail@mail.com', 5000, 'Java' );
--insert into programmers(name,email,salary,prog_lang) values ('Jerry', 'mail@mail.com', 4000, 'SQL' );
--HATA,mail unique olmalıydı.

insert into programmers(name,email,salary,prog_lang) values ('Jerry', 'jerry@mail.com', 5000, 'Java' );

----ALTER SEQUENCE programmers_id_seq RESTART WITH 10;

----------------------------------------------------------------------------------------
--10-Tabloya NOT NULL constraint'i ekleme
--Bir sütuna NULL değerlerin  eklenememesi için tablo ve sütunları tanımlanırken NOT NULL kısıtlaması eklenir.

--name bilgisini girmeyelim. 

insert into programmers (email,salary,prog_lang)values('python1@gmail.com', 4000, 'Python');

CREATE TABLE programmers1(
id SERIAL,
NAME VARCHAR(30) not null,
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20)
);

SELECT * FROM programmers1;

insert into programmers1(name,email,salary,prog_lang) values ('Tom', 'mail@mail.com', 5000, 'Java' );
insert into programmers1(name,email,salary,prog_lang) values ('Jerry', 'jerry@mail.com', 4000, 'SQL' );
insert into programmers1 (email,salary,prog_lang)values('python1@gmail.com', 4000, 'Python');
------------------------------------------------------------------------------------------------------
--11-Tabloya PK constraint'i ekleme
--1.yol: PK secilecek sutunun yanina ekleme

/*Senaryo: "actors1" adında bir tablo oluşturun ve şu sütunları ekleyin:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Not: Id'yi primary key olarak belirleyin*/

/*Scenario: Create a table called "actors1" and add the following columns:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Note: Set Id as primary key*/

CREATE TABLE actors1(
	id INTEGER PRIMARY KEY, --NOT NULL ve Unique
	name VARCHAR(30),
	surname VARCHAR(30),	
	film VARCHAR(50)
);
select * from actors1;

CREATE TABLE actors2(
	id INTEGER,
	name VARCHAR(30),
	surname VARCHAR(30),	
	film VARCHAR(50),
	CONSTRAINT act_pk PRIMARY key (id)
);

select * from actors2;

----composite key //birden fazla primary key i tek bir key olarak birleştiriyor..
create table company (
  --job_id integer primary key, --pk//hatalı bu iki ayrı primary key aynı tabloda kullanamayız
  --name varchar(30) primary key,--pk
  job_id integer,
  name varchar(30), 
  company varchar(30),
  CONSTRAINT com_pk primary key (job_id, name) --burda birleştirildi.. Ayrı ayrı görülüyor ama ayrı değil...

);

select * from company;

------------------------------------------------------
--Not 1: "Parent Table"da olmayan bir id'ye sahip datayi "Child Table"'a ekleyemezsiniz
--Not 2: Child Table'i silmeden Parent Table'i silemezsiniz. Once "Child Table" silinir, 
--sonra  "Parent Table" silinir.

------------------------------------------------------------------------------------

--12-Tabloya FK constraint'i ekleme

/*Senaryo: "companies" ve "employees" adlarinda iki tablo oluşturun.

companies tablosu sütunları: 
sirket_id INTEGER, sirket VARCHAR(50), personel_sayisi INTEGER
employees tablosu sütunları:
id INTEGER, isim VARCHAR(50), sehir VARCHAR(50), maas REAL, sirket VARCHAR(50)*/

/*Scenario: Create two tables named "companies" and "employees".

Companies table columns: 
company_id INTEGER, company VARCHAR(50), number_of_employees INTEGER
employees table columns:
id INTEGER, name VARCHAR(50), city VARCHAR(50), salary REAL, company VARCHAR(50)*/

create table companies(
sirket_id integer,
sirket varchar(50),
personel_sayisi integer,

select * from companies;

create table employees(
id integer,
isim varchar(50),
sehir varchar(50),
maas real,
sirket varchar(50),
constraint per_fk foreign key(sirket) REFERENCES companies(sirket)
);

select * from employees;

---------------------------------------------------------------------------
--13-Tabloya CHECK constraint’i ekleme
--CHECK ile bir alana girilebilecek değerleri sınırlayabiliriz.

/*Senaryo: "person" adinda bir tablo oluşturun.
person tablosu sütunları: 

id INTEGER, name VARCHAR(50), salary REAL, age INTEGER olsun. Salary 5000’den kucuk ve yas negatif girilemesin*/

/*Scenario: Create a table named "person".
person table columns: 

id INTEGER, name VARCHAR(50), salary REAL, age INTEGER. Salary cannot be less than 5000 and age cannot be negative*/

CREATE TABLE person(
	id INTEGER,
	name VARCHAR(50),
	salary REAL CHECK(salary>5000), --5000 den az kabul etmez
	age INTEGER CHECK(age>0) --negatif kabul etmez
);

INSERT INTO person VALUES(11, 'Ali Can', 6000, 35);
--INSERT INTO person VALUES(11, 'Ali Can', 6000, -3); --HATA, person_age_check
--INSERT INTO person VALUES(11, 'Ali Can', 4000, 45); --HATA, person_salary_check

SELECT * FROM person;

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

INSERT INTO worker VALUES('10002', 'Donatello' ,12000, '2018-04-14'); --başarılı
INSERT INTO worker VALUES('10003', null, 5000, '2018-04-14');--unique:NULL kabul eder
INSERT INTO worker VALUES('10004', 'Donatello', 5000, '2018-04-14');--HATA name unique olmalı
INSERT INTO worker VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--başarılı
INSERT INTO worker VALUES('10006', 'Leonardo', null, '2019-04-12');--HATA MAAS NOT NULL BOŞ GEÇEMEZ
INSERT INTO worker VALUES('10007', 'Raphael', '', '2018-04-14');----HATA, maas int bekliyor biz bos String gonderdik
INSERT INTO worker VALUES('', 'April', 2000, '2018-04-14');---Hiçliği primary key olarak kabul ediyor...
INSERT INTO worker VALUES('', 'Ms.April', 2000, '2018-04-14');



