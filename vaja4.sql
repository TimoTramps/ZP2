--1. Napiši poizvedbo, ki vraèa ime, prvo vrstico naslova, mesto in nov stolpec z imenom
--»TipNaslova« in vrednostjo »Za raèune« podjetja za vse stranke, ki imajo tip naslova v
--CustomerAddress tabeli enak 'Main Office'.
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as [Tip naslova]
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
order by c.CompanyName;

--2. Napiši podobno poizvedbo (ime, prva vrstica naslova, mesto in stolpec »Tip naslova« z
--vrednostjo »Za dobavo«) za vse stranke, ki imajo tip naslova v CustomerAddress enak
--'Shipping'
select c.CompanyName, a.AddressLine1, a.City, 'Za dobavo' as [Tip naslova]
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping';

--3. Kombiniraj oba rezultata v seznam, ki vrne vse naslove stranke urejene po strankah, nato po
--TipNalsova.
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as [Tip naslova]
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
union
select c.CompanyName, a.AddressLine1, a.City, 'Za dobavo' as [Tip naslova]
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName, [Tip naslova];

--4. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovom, a
--nimajo 'Shipping' naslova.
select c.CompanyName, a.AddressLine1, a.City
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
except
select c.CompanyName, a.AddressLine1, a.City
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName;

--5. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovomin hkrati
--med podjetji s 'Shipping' naslovom.
select c.CompanyName, a.AddressLine1, a.City
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
intersect
select c.CompanyName, a.AddressLine1, a.City
from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on ca.CustomerID = c.CustomerID
join [SalesLT].[Address] a on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName;