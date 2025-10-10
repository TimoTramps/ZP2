
select Sellstartdate, convert(nvarchar,Sellstartdate, 140)
from SalesLT.Product;


--case
select Name, 
	case when Size ='S' then 'Small'
		when Size='M' then 'Medium'
		when Size='L' then 'Large'
		else Size
	end as Velikost
from SalesLT.Product;

--varianta
select Name, 
   case Size when 'S' then 'Small'
		when 'M' then 'Medium'
		when 'L' then 'Large'
		else Size
	end as Velikost
from SalesLT.Product;

--1. Poišèi vse stranke iz tabele Customers
select FirstName, LastName 
from SalesLT.Customer
order by LastName, FirstName;

--2. Izdelaj seznam strank, ki vsebuje ime kontakta, naziv, ime, srednje ime (èe ga kontakt ima),
--priimek in dodatek (èe ga kontakt ima) za vse stranke.
select concat(Title, FirstName, MiddleName, LastName, Suffix) as 'Kontakt'
from SalesLT.Customer
where MiddleName is not Null and EmailAddress is not Null and Title is not Null
order by FirstName, LastName;

select Title, FirstName, MiddleName, LastName, EmailAddress
from SalesLT.Customer
where MiddleName is not Null and EmailAddress is not Null and Title is not Null
order by FirstName, LastName;

select *
from SalesLT.Customer
order by LastName;

--3. Iz tabele Customers izdelaj seznam, ki vsebuje:
--a. Prodajalca (SalesPerson)
--b. Stolpec z imenom »ImeStranke«, ki vsebuje priimek in naziv kontakta (na primer Mr
--Smith)
--c. Telefonsko številko stranke
select SalesPerson, concat(Title, ' ', LastName) as 'ImeStranke', Phone
from SalesLT.Customer;

--4. Izpiši seznam vseh strank v obliki <Customer ID> : <Company Name> na primer 78: Preferred
--Bikes.
select concat(CustomerID, ' : ', CompanyName)
from SalesLT.Customer
order by CustomerID;

--5. Iz tabele SalesOrderHeader (vsebuje podatke o naroèilih) izpiši podatke
--a. Številka naroèila v obliki <Order Number> (<Revision>) –na primer SO71774 (2).
--b. Datum naroèila spremenjen v ANSI standarden format (yyy.mm.dd – na primer
--2015.01.31)select *
from SalesLT.SalesOrderHeader;select 
	concat(SalesOrderNumber, ' (', RevisionNumber, ')') as 'Naroèilo', 
	format(OrderDate, 'yyyy.MM.dd') as 'Datum naroèila'
from SalesLT.SalesOrderHeaderorder by SalesOrderNumber;--6. Ponovno je treba izpisati vse podatke o kontaktih, èe kontakt nima srednjega imena v obliki
--<first name> <last name>, èe ga pa ima <first name> <middle name> <last name> (na primer
--Keith Harris, Jane M. Gates)
select FirstName, MiddleName, LastName
from SalesLT.Customer
where MiddleName is not Null
order by FirstName, LastName;

select concat(FirstName, ' ',  isnull(MiddleName, ''), ' ', LastName) as 'Kontakt'
from SalesLT.Customer;
--7. Stranka nam je posredovala e-mail nalov, telefon ali oboje. Èe je dostopen e-mail, ga
--uporabimo za primarni kontakt, sicer uporabimo telefonsko številko. Napiši poizvedbo, ki
--vrne CustomerID in stolpec »PrimarniKontakt«, ki vsebuje e-mail ali telefonsko številko. (v
--podatkovni bazi imajo vsi podatki e-mail. Èe hoèeš preveriti ali poizvedba deluje pravilno
--najprej izvedi stavek
select *
from SalesLT.Customer;

select CustomerID, coalesce(EmailAddress, Phone) as 'Primarni Kontakt'
from SalesLT.Customer;



--8. Izdelaj poizvedbo, ki vraèa seznam naroèil (order ID), njihove datume in stolpec
--»StatusDobave«, ki vsebuje besedo »Dobavljeno« za vsa naroèila, ki imajo znan datum
--dobave in »Èaka« za vsa naroèila brez datuma dobave. V bazi imajo vsa naroèila datum
--dobave. Èe želiš preveriti, ali poizvedba deluje pravilno, predhodno izvedi stavekselect *
from SalesLT.SalesOrderHeader;

select SalesOrderID, OrderDate,
 case
 when ShipDate is null then 'Dobavljeno'
 else 'Èaka'
 end as ShippingStatus
from SalesLT.SalesOrderHeader;