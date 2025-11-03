--1. Poišči ID produkta, ime in ceno produkta (list price) za vsak produkt, kje je cena produkta
--večja od povprečne cene na enoto (unit price) za vse produkte, ki smo jih prodali
select ProductID, Name, ListPrice
from SalesLT.Product
where ListPrice > (
    select AVG(UnitPrice)
    from SalesLT.SalesOrderDetail
);


--2. Poišči ID produkta, ime in ceno produkta (list price) za vsak produkt, kjer je cena (list) 100$ ali
--več in je bil produkt prodan (unit price) za manj kot 100$.
select ProductID, name, listprice 
from [SalesLT].[Product]
where ListPrice>=100 and productid in (select productid from [SalesLT].[SalesOrderDetail] where UnitPrice<100);
--Ta poizvedba:
--najprej poi��e vse razli�ne ProductID-je, ki se pojavijo v SalesOrderDetail s UnitPrice < 100;
--potem v zunanji poizvedbi izpi�e po en izdelek na ProductID, saj Product tabela ima en zapis na izdelek.
-- Torej � rezultat ima en zapis na produkt (unikaten ProductID).


select p.ProductID, name, listprice,unitprice, SalesOrderID from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] sod on  p.ProductID=sod.ProductID
where ListPrice>=100 and unitprice <100
order by productid
--Ta poizvedba:
--naredi povezavo 1:n med produkti in vrsticami prodajnih podrobnosti (SalesOrderDetail);
--�e se nek produkt pojavi v ve� naro�ilih ali ve�krat v isti tabeli SalesOrderDetail, bo vsaka taka vrstica vrnila svojo kopijo istega produkta.
-- Torej � rezultat ima toliko vrstic, kolikor je ustreznih vrstic v SalesOrderDetail, ne glede na to, ali gre za iste izdelke.

--3. Poišči ID produkta, ime in ceno produkta (list price) in proizvodno ceno (standardcost) za vsak
--produkt skupaj s povprečno ceno, po kateri je bil produkt proda
select 
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.StandardCost,
    avg(sod.UnitPrice) as AvgSoldPrice
from SalesLT.Product p
join SalesLT.SalesOrderDetail sod on p.ProductID = sod.ProductID
group by p.ProductID, p.Name, p.ListPrice, p.StandardCost;

select 
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.StandardCost,
    (
        select avg(sod.UnitPrice)
        from SalesLT.SalesOrderDetail sod
        where sod.ProductID = p.ProductID
    ) as AvgSoldPrice
from SalesLT.Product p;

--4. Filtriraj prejšnjo poizvedbo, da bo vsebovala samo produkte, kjer je cena proizvodnje (cost
--price) večja od povprečne prodajne cene.
select 
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.StandardCost,
    avg(sod.UnitPrice) as AvgSoldPrice
from SalesLT.Product p
join SalesLT.SalesOrderDetail sod on p.ProductID = sod.ProductID
group by p.ProductID, p.Name, p.ListPrice, p.StandardCost
having p.StandardCost > avg(sod.UnitPrice);

select 
    p.ProductID,
    p.Name,
    p.ListPrice,
    p.StandardCost,
    (
        select avg(sod.UnitPrice)
        from SalesLT.SalesOrderDetail sod
        where sod.ProductID = p.ProductID
    ) as AvgSoldPrice
from SalesLT.Product p
where p.StandardCost > (
    select avg(sod.UnitPrice)
    from SalesLT.SalesOrderDetail sod
    where sod.ProductID = p.ProductID
);


select * from [SalesLT].[SalesOrderHeader] soh
cross apply [SalesLT].[udfMaxUnitPrice](soh.SalesOrderID) as mup;

--narobe
--select * from [SalesLT].[SalesOrderHeader] soh
--join [SalesLT].[udfMaxUnitPrice](soh.SalesOrderID) as mup
--on mup.SalesOrderID=soh.SalesOrderID;

--5. Poišči ID naročila, ID stranke, Ime in priimek stranke in znesek dolga za vsa naročila v
--SalesLT.SalesOrderHeader s pomočjo funkcije dbo.ufnGetCustomerInformation
select soh.SalesOrderID, c.CustomerID,  c.FirstName, c.LastName, soh.TotalDue
from [SalesLT].[SalesOrderHeader] soh
cross apply dbo.ufnGetCustomerInformation(soh.CustomerID) c;


--6. Poišči ID stranke, Ime in priimek stranke, naslov in mesto iz tabele SalesLT.Address in iz
--tabele SalesLT.CustomerAddress s pomočjo funkcije dbo.ufnGetCustomerInformation
select c.CustomerID,  c.FirstName, c.LastName, a.AddressLine1, a.City
from [SalesLT].[Address] a
join [SalesLT].[CustomerAddress] ca 
on ca.AddressID=a.AddressID
cross apply dbo.ufnGetCustomerInformation(ca.CustomerID) c;