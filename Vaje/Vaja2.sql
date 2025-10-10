--ostranjevanje
select Name, ListPrice from [SalesLT].[Product]
order by ListPrice desc offset 310 rows
fetch next 10 rows only;

select Name, ProductCategoryID from [SalesLT].[Product]
where ProductCategoryID in (5,6,7);



--1. Iz tabele Address izberi vsa mesta in province, odstrani duplikate. (atributi City,
--Province)
select distinct City, StateProvince
from SalesLT.Address
order by City;

--2. Iz tabele Product izberi 10% najte�jih produktov (izpi�i atribut Name, te�a je v
--atributu Weight)

select top (10) percent Name, Weight
from SalesLT.Product
where Weight is not null
order by Weight desc;

--3. Iz tabele Product izberi najte�jih 100 produktov, izpusti prvih 10 najte�jih.
SELECT Name, Weight
FROM SalesLT.Product
WHERE Weight IS NOT NULL
ORDER BY Weight DESC
OFFSET 10 ROWS
FETCH NEXT 100 ROWS ONLY;

--4. Poi��i ime, barvo in velikost produkta, kjer ima model produkta ID 1. (atributi Name,
--Color, Size in ProductModelID)
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID=1;

--5. Poi��i �tevilko produkta in ime vseh izdelkov, ki imajo barvo 'black', 'red' ali 'white' in
--velikost 'S' ali 'M'. (Izpi�i ProductNumber, primerjaj Color in Size)
SELECT Name, Color, Size, ProductModelID
FROM SalesLT.Product
WHERE color in ('black', 'red', 'white') and Size in ('S','M');

--6. Poi��i �tevilko produktov, ime in ceno produktov, katerih �tevilka se za�ne na BK-.
--(atributi ProductNumber, Name, ListPrice, primerjaj ProductNumer)
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
where ProductNumber like 'BK-%';

--7. Spremeni prej�njo poizvedbo tako, da bo� iskal produkte, ki se za�nejo na 'BK-' sledi
--katerikoli znak razen R in se kon�ajo na ��dve �tevki�. (atributi ProductNumber,
--Name, ListPrice, primerjaj ProductNumer, primer: BK-F1234J-11)
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
where ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';
