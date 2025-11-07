insert into [dbo].[MyEmployees]
values (2345, 'Janez', 'Novak','Gospod',1,1);

insert into [dbo].[MyEmployees]
values (2346, 'Pepi', 'Novak','Gospod',1,1),
	   (2347, 'Meri', 'Novak','Gospa',1,1),
	   (2348, 'Marija', 'Novak','Gospa',1,1);

insert into dbo.MyEmployees
(EmployeeID, FirstName, LastName, Title, DeptID, ManagerID)
values (3000, 'Saška', 'Kranjc','Gospa',1,1);

--posebe vrednosti--
create table T1(
	st1 int identity,
	st2 nvarchar(30)
);

insert into t1 values('vrstica 1');
insert into t1(st2) values('vrstica 2');

select * from t1;

--1. Vstavi v tabelo SalesLT.Product produkt

insert into [SalesLT].[Product]
(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values ('LED Lights - small', 'LT-L123tram', 2.56, 12.99, 37, getdate());

SELECT SCOPE_IDENTITY() AS NewProductID;

--Ko je produkt ustvarjen, preveri kakšna je identiteta zadnjega vstavljenega produkta.
--Pomagaj si s SELECT SCOPE_IDENTITY();
--Opomba : ProductNumber mora biti edinstven. Ker delamo vsi na isti podatkovni bazi,
--zamenjaj ime v LT-L123xxxx, kjer xxxx nadomestiš s prvimi èrkami priimka.

--2.naloga
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES (4, 'Bells and Horns');

INSERT INTO SalesLT.Product
    (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
    ('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
    ('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());

---9.1.-

--ustvarite tabelo z vašim priimkom v PB
CREATE TABLE Priimek1
(
 st2 varchar(30) DEFAULT ('my column default'),
 st1 AS ('Computed column ' + st2),  -- computed column
 st4 varchar(40) NULL,
 st5 nchar(5) UNIQUE,
 st6 rowversion                      -- timestamp / rowversion
);

--1. vstavite vse privzete vrednosti, samo za st5 dajte vrednost 'AAAAA'
--2. kaj je narobe s stavkom, popravite vse tri napake napaki

INSERT INTO Priimek1 (st2, st4, st5)
VALUES (DEFAULT, DEFAULT, 'AAAAA');


--izbiršite tabelo in naredite novo
CREATE TABLE Priimek2
(
 st1 int IDENTITY,
 st2 VARCHAR(30),
 st3 uniqueidentifier
);

--3. vstavite 1,'Barbara' in vrednost, ki jo lahko priredite unique identifierju
INSERT INTO Priimek2 (st2, st3)
VALUES ('Barbara', NEWID());

SET IDENTITY_INSERT Priimek2 ON;

INSERT INTO Priimek2 (st1, st2, st3)
VALUES (5, 'NekaVrednost', NEWID());

SET IDENTITY_INSERT Priimek2 OFF;


--4.preskoèite sedaj zaporedno številko 2 in dodajte zapis z zaporedno številko 5
