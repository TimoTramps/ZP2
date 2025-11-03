--1. Izdelati moraš poroèilo o raèunih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa še ID naroèila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.

select c.CompanyName, oh.salesOrderID, oh.totalDue
from SalesLT.Customer c
join SalesLT.SalesOrderHeader oh on oh.CustomerID=c.CustomerID;

--2. Razširi poizvedbo tako, da dodaš še naslov »Main Office« za vsakega kupca (naslov ulice,
--mesto, državo/provinco, poštno številko in regijo). Pri tem upoštevaj, da ima vsaka stranka
--veè naslovov v tabeli Address. Zato je naèrtovalec PB ustvaril še tabelo CustomerAddress, da
--je rešil povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati prikljuèeno
--tabelo CustomerAddress, tako da vzame samo naslov »Main Office«.select c.CompanyName, oh.salesOrderID, oh.totalDue
from SalesLT.Customer c
join SalesLT.SalesOrderHeader oh on oh.CustomerID=c.CustomerID;