declare @varProdukti as table
(ProductID int, ime nvarchar(50));
select * from @varProdukti;

create table #temp
(
	ProductID int, ime nvarchar(50)
);
insert into #temp select ProductID, name from [SalesLT].[Product]
where Color='Red';
select* from #temp;

--izpeljane tabele / 
select year(OrderDate) as 'leto', count(distinct CustomerID)
from [SalesLT].[SalesOrderHeader]
group by OrderDate;

select leto, count(distinct CustomerID) from
(
	select year(OrderDate) as leto,
	CustomerID
	from [SalesLT].[SalesOrderHeader]
) as izpeljano_leto(leto, CustomerID)
group by leto;

--common table expression / cte
with novaTabela(letoNar, kupId)
as
(
	select year(OrderDate),
	CustomerID
	from [SalesLT].[SalesOrderHeader]
)
select letoNar, count(kupId) 
from novaTabela
group by letoNar;

with DirectReports(ManagerID, EmployeeID, Title, EmployeeLevel)
as
(
	select ManagerID,
	EmployeeID,
	Title, 0
	from [dbo].[MyEmployees]
	where ManagerID is null
	union all
	select e.ManagerID, e.EmployeeID, e.Title, EmployeeLevel+1 from [dbo].[MyEmployees] e
	join DirectReports d on e.ManagerID=d.EmployeeID
)
select *
from DirectReports
order by ManagerID;

--1. Izdelaj poizvedbo, ki bo vsebovala Id produkta, ime produkta in povzetek produkta
--(Summary) iz SalesLT.Product tabele in SalesLT.vProductModelCategoryDescription
--pogleda.
select p.ProductID, p.Name, pm.ProductDescriptionID as Summary
from [SalesLT].[ProductModelProductDescription] pm
join [SalesLT].[Product] p 
on p.ProductModelID=pm.ProductModelID
order by p.ProductID;

--2. Izdelaj tabelarièno spremenljivko in jo napolni s seznamom razliènih barv iz tabele
--SalesLT.Product. Nato uporabi spremenljivko kot filter poizvedbe, ki vraèa ID
--produkta, ime, barvo iz tabele SalesLT.Product in samo tiste izdelke, ki imajo barvo v
--zgoraj definirani zaèasni tabeli (rezultat vsebuje 245 vrstic)
declare @colors table
(
    Color nvarchar(50)
);

insert into @colors (Color)
select distinct Color
from [SalesLT].[Product]
where Color is not null;

select ProductID, Name, Color
from [SalesLT].[Product]
where Color in (select Color from @colors);

--3. Podatkovna baza AdventureWorksLT vsebuje funkcijo dbo.ufnGetAllCategories, ki vraèa
--tabelo kategorij produktov (na primer 'Road Bikes') in roditeljske kategorije (na primer
--'Bikes'). Napiši poizvedbo, ki uporablja to funkcijo in vraèa seznam izdelkov, skupaj s
--kategorijo in roditeljsko kategorijo.
select 
    p.ProductID,
    p.Name as ProductName,
    c.ProductCategoryName,
    c.ParentProductCategoryName
from 
    [SalesLT].[Product] p
inner join
    dbo.ufnGetAllCategories() c
    on p.ProductCategoryID = c.ProductCategoryID;


--4. Poišèi seznam strank v obliki Company (Contact Name), skupni prihodki za vsako
--stranko. Uporabi izpeljano tabelo, da poišèeš naroèila, nato pa naredi poizvedbo po
--izpeljani tabeli, da agregiraš in sumiraš podatke.

select 
    CompanyName + ' (' + ContactName + ')' as Customer,
    sum(LineTotal) as TotalRevenue
from 
(
    select 
        c.CustomerID,
        c.CompanyName,
        c.FirstName + ' ' + c.LastName as ContactName,
        od.UnitPrice * od.OrderQty as LineTotal
    from 
        SalesLT.Customer c
    inner join
        SalesLT.SalesOrderHeader soh on c.CustomerID = soh.CustomerID
    inner join
        SalesLT.SalesOrderDetail od on soh.SalesOrderID = od.SalesOrderID
) as CustomerOrders
group by 
    CompanyName,
    ContactName
order by
    TotalRevenue desc;


--5. Ista naloga kot prej, le da namesto izpeljane tabele uporabiš CTE
with CustomerOrders as
(
    select 
        c.CustomerID,
        c.CompanyName,
        c.FirstName + ' ' + c.LastName as ContactName,
        od.UnitPrice * od.OrderQty as LineTotal
    from 
        SalesLT.Customer c
    inner join
        SalesLT.SalesOrderHeader soh on c.CustomerID = soh.CustomerID
    inner join
        SalesLT.SalesOrderDetail od on soh.SalesOrderID = od.SalesOrderID
)

select 
    CompanyName + ' (' + ContactName + ')' as Customer,
    sum(LineTotal) as TotalRevenue
from 
    CustomerOrders
group by 
    CompanyName,
    ContactName
order by
    TotalRevenue desc;