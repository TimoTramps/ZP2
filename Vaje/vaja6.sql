--1. Napišite poizvedbo, ki vraèa ID produkta, ime produkta z velikimi tiskanimi èrkami in stolpec
--Teža, ki zaokroži težno na prvo celo število.
select ProductID, Upper(Name) as 'Ime', round(Weight, 0) as 'Teža'
from [SalesLT].[Product];

--2. Razširite prvo poizvedbo tako, da dodate LetoZaèetkaProdaja, ki vsebuje leto atributa
--SellStartDate in MesecZaèProdaje, ki vsebuje mesec istega atributa. V stolpcu naj bo ime
--meseca (na primer 'January')
select ProductID, Upper(Name) as 'Ime', round(Weight, 0) as 'Teža', 
datename(yyyy, SellStartDate) as 'Leto', datename(MM, SellStartDate) as 'Mesec'
from [SalesLT].[Product];

--3. Dodajte poizvedbi še stolpec z imenom Tip, ki vsebuje prvi dve èrki atributa ProductNumber.
select ProductID, Upper(Name) as 'Ime', round(Weight, 0) as 'Teža', 
datename(yyyy, SellStartDate) as 'Leto', datename(MM, SellStartDate) as 'Mesec',
left(ProductNumber, 2)
from [SalesLT].[Product];

--4. Dodajte poizvedbi še filter, tako da bodo rezultat samo tisti produkti, ki imajo pod atributom
--Size napisano število (ne pa 'S', 'M' ali 'L').
select ProductID, Upper(Name) as 'Ime', round(Weight, 0) as 'Teža', 
datename(yyyy, SellStartDate) as 'Leto', datename(MM, SellStartDate) as 'Mesec',
left(ProductNumber, 2) as 'Tip', Size
from [SalesLT].[Product]
where isnumeric(Size)=1
order by Size;

--5. Napišite poizvedbo, ki vrne seznam imen podjetji in njihovo mesto v rangu, èe jih rangirate
--glede na najvišjo vrednost atributa TotalDue iz tabele SalesOrderHeader
select c.CompanyName, sum(soh.TotalDue) as 'Vsota'
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh
on soh.CustomerID=c.CustomerID
group by c.CompanyName
order by 'Vsota' desc;

--6. Napišite poizvedbo, ki izpiše imena produktov in skupno vsoto izraèunano kot vsoto atributa
--LineTotal iz SalesOrderDetail tabele. Rezultat naj bo urejen po padajoèi vrednosti skupne
--vsote.
select p.Name, sum(sod.LineTotal) as TotalRevenue
from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] sod
on sod.ProductID=p.ProductID
group by p.Name
order by TotalRevenue desc;

--7. Spremenite prejšnjo poizvedbo tako, da vkljuèuje samo tiste produkte, ki imajo atribut
--ListPrice veè kot 1000$.
select p.Name, sum(sod.LineTotal) as TotalRevenue
from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] sod
on sod.ProductID = p.ProductID
where p.ListPrice > 1000
group by p.Name
order by TotalRevenue desc;

--8. Spremenite prejšnjo poizvedbo, da bo vsebovala samo skupine, ki imajo skupno vrednost
--prodaje veèjo kot 20.000$.
select p.Name, sum(sod.LineTotal) as TotalRevenue
from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] sod
on sod.ProductID = p.ProductID
where p.ListPrice > 1000
group by p.Name
having sum(sod.LineTotal) > 20000
order by TotalRevenue desc;
