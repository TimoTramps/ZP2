--1. Najboljši kupci po znesku naročil (CTE)
--Poišči prvih 10 kupcev, ki so zapravili največ (glede na vsoto TotalDue iz tabele
--SalesOrderHeader). V nalogi si izdelaj CTE z imenom CustomerTotals, ki vsebuje
--CustomerID+' '+ CompanyName (to poimenuje stranka) iz tabele Customer in TotalDue iz
--tabele SalesOrderHeader (to poimenuje znesek). Nato v naslednji poizvedbi izračunaj vsote in
--izpiši samo prvih 10.
with CustomerTotals as
(
select c.CustomerID, c.CompanyName, soh.TotalDue 
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh
on soh.CustomerID = c.CustomerID
)
select ct.CustomerID,
    ct.CompanyName as Stranka,
    sum(ct.TotalDue) as SkupniZnesek
from CustomerTotals ct
group by ct.CustomerID, ct.CompanyName
order by SkupniZnesek desc
offset 0 rows fetch next 10 rows only;

--2. Najbolje prodajani izdelki
--Poišči 5 izdelkov z največjo prodano količino (skupaj v vseh naročilih). Izdelaj is novo tabelo
--(CTE) z imenom ProductSales, ki vsebuje ProductId+' '+Name (poimenuj Ime) iz tabele
--Products in OrderQty iz tabele SalesOrderDetail (poimenuj Količina). V naslednji poizvedbi
--izračunaj vsoto količin, kih razvrsti padajoče in izpiši samo prvih 5 produktov
with ProductSales(ime, količina) as(
	select 
	convert(nvarchar, p.ProductID) + ' ' +
	p.Name as Ime,
	sod.OrderQty as Količina
	from [SalesLT].[Product] p
	join [SalesLT].[SalesOrderDetail] sod
	on sod.ProductID = p.ProductID
)
select Ime, sum(količina) as SkupnaKoličina
from ProductSales
group by ime
order by SkupnaKoličina desc
offset 0 rows fetch next 5 rows only;

--3. Kupci z nadpovprečno vrednostjo naročil
--Prikaži kupce, katerih povprečna vrednost naročil je nad povprečjem vseh naročil. Uporabi
--izpeljano tabelo, v kateri boš imel CustomerId in povprečno vrednost naročil (povprečje od
--TotalDue iz SalesOrderHeader → to tabelo bo za uporabiti pri join), nato pa uporabi še podpoizvedbo 
--v stavku where, da boš primerjal povprečje ene stranke s celotnim povprečjem
--naročil vseh strank.
with ProductCustomer(id, povpNar) as(
	select c.CustomerID, avg(soh.TotalDue) as Povp
	from [SalesLT].[Customer] c
	join [SalesLT].[SalesOrderHeader] soh
	on soh.CustomerID = c.CustomerID
	group by c.CustomerID
)
select pc.id, pc.povpNar
from ProductCustomer pc
where pc.povpNar>(
	select avg(povpNar)
	from ProductCustomer
)
order by pc.povpNar desc;

--4. Prodaja po letu in mesecu
--Prikaži skupno prodajo (TotalDue) po letu in mesecu, urejeno od najnovejše do najstarejše.
select year(dueDate) as leto,
month(dueDate) as mesec,
sum(TotalDue) as SkupnaProdaja
from [SalesLT].[SalesOrderHeader]
group by year(dueDate), month(dueDate)
order by leto desc, mesec desc;

--5. Izdelki, ki se prodajajo nad povprečno ceno
--Prikaži izdelke, katerih ListPrice je nad povprečno oceno vseh izdelkov