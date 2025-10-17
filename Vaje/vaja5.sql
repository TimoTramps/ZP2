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