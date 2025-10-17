--1. Izdelati mora� poro�ilo o ra�unih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa �e ID naro�ila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.
select c.CompanyName, soh.SalesOrderID, soh.TotalDue
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh on c.CustomerID=soh.CustomerID;
--2. Raz�iri poizvedbo tako, da doda� �e naslov �Main Office� za vsakega kupca (naslov ulice,
--mesto, dr�avo/provinco, po�tno �tevilko in regijo). Pri tem upo�tevaj, da ima vsaka stranka
--ve� naslovov v tabeli Address. Zato je na�rtovalec PB ustvaril �e tabelo CustomerAddress, da
--je re�il povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati priklju�eno
--tabelo CustomerAddress, tako da vzame samo naslov �Main Office�.
select c.CompanyName, a.AddressLine1, a.City, a.PostalCode, a.CountryRegion, 
soh.SalesOrderID, soh.TotalDue
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh on c.CustomerID=soh.CustomerID
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where ca.AddressType='Main Office';

--3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naro�ila
--in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso �e ni�esar naro�ili na koncu
--seznama.
select c.CompanyName, c.FirstName, c.LastName, soh.SalesOrderID, soh.TotalDue
from [SalesLT].[Customer] c
left join [SalesLT].[SalesOrderHeader] soh on c.CustomerID=soh.CustomerID
order by c.LastName, c.FirstName;

--4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
--CustomerID, ime podjetja, ime kontakta in telefonska �tevilka vseh, ki nimajo
--podatkov o naslovu.
select c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone
from [SalesLT].[Customer] c
left join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
where ca.AddressID is Null
order by c.LastName, c.FirstName;

--5. Radi bi ugotovili katere stranke �e nikoli niso naro�ile in kateri produkti �e nikoli niso
--bili naro�eni. V ta namen izdelaj poizvedbo, ki vra�a CustomerID za vse stranke, ki
--niso �e ni�esar naro�ile in stolpec productID za vse izdelke, ki �e niso bili naro�eni.
--Vsaka vrstica z ID-jem stranke ima pri ProductID NULL, vsak ProductID vrstica ima
--CustomerID NULL.
select c.CustomerID, null as ProductID
from SalesLT.Customer c
left join SalesLT.SalesOrderHeader soh on c.CustomerID = soh.CustomerID
where soh.SalesOrderID is null
union
select null as CustomerID, p.ProductID
from SalesLT.Product p
left join SalesLT.SalesOrderDetail sod on p.ProductID = sod.ProductID
where sod.SalesOrderID is null
order by ProductID, CustomerID;