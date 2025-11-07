--1. Imamo že obstoječe poročilo, ki vrača vsote prodaj po country/region (USA; Združeno
--kraljestvo) in po State/Province (England, California, Colorado,…).

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;

------------------posodobljeno------------------

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY 
	grouping sets(
		(),
		(a.CountryRegion),
		(a.CountryRegion, a.StateProvince)
	)
order by a.CountryRegion, a.StateProvince;

--2. Spremeni poizvedbo tako, da bo vsebovala nov atribut Level, ki bo opisoval tip delne vsote.
SELECT a.CountryRegion, a.StateProvince, 
	case
	when grouping(a.CountryRegion) = 1 and grouping(a.StateProvince) = 1 then 'Total'
	when grouping(a.CountryRegion) = 0 and grouping(a.StateProvince) = 1 then a.CountryRegion
	else a.StateProvince + ' subtotal'
end as Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY 
	grouping sets(
		(),
		(a.CountryRegion),
		(a.CountryRegion, a.StateProvince)
	)
order by a.CountryRegion, a.StateProvince;

--3. Razširi poizvedbo tako, da bo vsebovala tudi mesta.
SELECT a.CountryRegion, a.StateProvince, a.City,
	case
	when grouping_id(a.CountryRegion) = 1 and grouping_id(a.StateProvince) = 1 and grouping_id(a.City) = 1 then 'Total'
    when grouping_id(a.CountryRegion) = 0 and grouping_id(a.StateProvince) = 1 and grouping_id(a.City) = 1 then a.CountryRegion + ' Subtotal'
    when grouping_id(a.CountryRegion) = 0 and grouping_id(a.StateProvince) = 0 and grouping_id(a.City) = 1 then a.StateProvince + ' Subtotal'
        else a.City + ' Subtotal'
    end as Level,
SUM(soh.TotalDue) as Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY 
	grouping sets(
		(),
		(a.CountryRegion),
		(a.CountryRegion, a.StateProvince),
		(a.CountryRegion, a.StateProvince, a.City)
	)
order by a.CountryRegion, a.StateProvince;