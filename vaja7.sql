--create view MojPogledTest
--as 
--select ProductID, name, ListPrice 
--from [SalesLT].[Product]
--where ListPrice>=100 and ProductID in(
--	select ProductID 
--	from [SalesLT].[SalesOrderDetail]
--);

declare @mojŠ int
set @mojŠ=1
print (@mojŠ);

declare @ImeSpr nvarchar(50)
set @ImeSpr=N'Amy'
select distinct FirstName, LastName from [SalesLT].[Customer]
where FirstName=@ImeSpr;

declare @varProdukti as table--dosegljiva v enem 'batch'
(ID int, Ime nvarchar(50))
select * from @varProdukti;

--začasne tabele
create table #temp --dosegljiva v okvirju ene seje
(ID int, Ime nvarchar(50))


select * from #temp;