---- DAY 8 DT ------------------

--41- ALTER TABLE ifadesi-DDL
/*Senaryo 3: orders tablosunda sirket_id sütununa FOREIGN KEY constraint'i ekleyiniz.*/
/*Scenario 3: Add FOREIGN KEY constraint to the company_id column in the orders table.*/
alter table orders
add foreign key(sirket_id)REFERENCES companies2(sirket_id);

delete from orders where sirket_id in (104,105);
select * from orders;

--!!!!ÖNEMLİ BİR KOD....!!!!kontrol etmek için kod..
SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 
(SELECT oid FROM pg_class WHERE relname = 'orders'); 

--------------------------------------------------------------
/*Senaryo 4: orders tablosundaki FK constraintini kaldırınız.*/
/*Scenario 4: Remove the FK constraint in the orders table.*/

ALTER TABLE orders
DROP CONSTRAINT orders_sirket_id_fkey---KALDIRACAĞIMIZ KISITLAMANIN İSMİNİ YAZDIĞIMIZDA KALDIRABİLİYOR..
--------------------------------------------------------------
/*Senaryo 5: employees5 tablosunda isim sütununda 
NOT NULL constraintini kaldırınız.*/

/*Scenario 5: Name column in employees5 table
Remove the NOT NULL constraint.*/
select * from employees5;

SELECT column_name, is_nullable--No olarak default atıyor yani (notnull aynı)
FROM information_schema.columns
WHERE table_name = 'employees5' AND column_name = 'isim';

ALTER TABLE employees5
alter column isim drop not null;--isnullable--Yes null kısıtlamasını kaldırdık.

insert into employees5(isim) values ('');
insert into employees5(id) values (123321);

----------------------------------------------------------------------
--42- Transaction

/*Senaryo:
1- accounts adında bir tablo oluşturulacak.
2- Tabloya iki kayıt eklenecek.
3- Hesaplar arasında 1000 TL para transferi yapılacaktır.
4- Para transferi sırasında bir hata oluşacaktır.
5- Hata oluştuğunda, ROLLBACK komutu ile transaction iptal edilecek
   ve 1. hesaptan çekilen 1000 TL iade edilecektir.*/

/*Scenario:
1- A table named accounts will be created.
2- Two records will be added to the table.
3- 1000 TL money transfer will be made between accounts.
4- An error will occur during money transfer.
5- When an error occurs, the transaction will be cancelled with the ROLLBACK command
   and the 1000 TL withdrawn from the 1st account will be refunded.*/
--Tablo oluşturma
   CREATE TABLE accounts(
	hesap_no int UNIQUE,
	isim varchar(50),
	bakiye real
   );
--Veri ekleme
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;
--Para transferi
UPDATE accounts SET bakiye = bakiye-1000 where hesap_no=1234;
--Sistemsel hata oluştu. Jack bu 1000 tl’yi alamadi
--UPDATE accounts SET bakiye = bakiye+1000 where hesap_no=5678;--hata ,çalışmadı
delete from accounts;
--------------------------------------------------
--Basarisiz transaction senaryosu
--BEGIN: Transaction başlatmak için kullanılır.
BEGIN;--başlat demek
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

--COMMIT: Transaction'ı onaylamak ve değişiklikleri kalıcı hale getirmek için kullanılır.
COMMIT;--noktayı koymak demek

-----------------------------------------------------

BEGIN;

INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3); 
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

--SAVEPOINT <savepoint_name>: Transaction içinde belirli bir noktada kayıt oluşturmak için kullanılır. Bu, hata durumunda tüm transaction'ı geri almak yerine belirli bir noktaya dönüş yapmayı sağlar.

SAVEPOINT x;

--try{

UPDATE accounts SET bakiye = bakiye - 1000 WHERE hesap_no = 1234;
--UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;HATA
COMMIT;CALISMAZ

--}catch() {

	ROLLBACK TO x;
	COMMIT;
--}

	SELECT * FROm accounts;

--------------------------------------
--BASARILI SENARYOSU.

CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

SAVEPOINT x;
  --try{
UPDATE accounts SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı
UPDATE accounts SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı
COMMIT;

--}catch() {

	ROLLBACK TO x;CALISMAZ cunku try'da hata yok
	
--}

SELECT * FROM accounts;
