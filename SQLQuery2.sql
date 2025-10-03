--1. izpi�i vse podatke o �lanih (rezultat ima 760 vrstic)
select * from �lan;

--2. izpi�i vse podatke o �lanih, urejene po priimku �lana
select * from �lan
order by Ime asc;

--3. izpi�i vse podatke o �lanih, urejene po �tevilki vasi, nato pa po imenih
select * from �lan
order by Vas, Ime;

--4. izpi�i ime �lana, naslov in ime vasi, urejene po imenu vasi, nato po imenih �lana
select c.Ime, c.Naslov, v.Ime_vasi from �lan c
inner join Vasi v on c.Vas=v.Sifra_vas
order by v.Ime_vasi, c.Ime;

--5. izpi�i imena �lanov, ki vsebujejo besedo 'FRANC' (17 takih je)select Ime from �lan
where Ime like '%franc%';

--6. izpi�i skupno koli�ino pripeljanega grozdja po posameznem �lanu iz tabele prevzem. V izpisu naj bo �ifra
-- �lana in skupna koli�ina grozdja, izpis uredi po �ifri �lana
select sum(p.Kolicina) as 'Skupna kolicina', c.Ime 
from �lan c
inner join Prevzem p on p.Sifra_clan=c.Sifra_clan
group by c.Ime;

--7. izpi�i skupno koli�ino grozdja po letnikih iz tabele Prevzem
select sum(Kolicina) as 'Skupna kolicina', Letnik
from Prevzem
group by Letnik;

--8. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sum(Kolicina), Sorta
from Prevzem
where Letnik = 2000
group by Sorta
order by Sorta;

--9. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah, uporabi imena sort
select sum(p.Kolicina), s.ImeS
from Prevzem p
inner join Sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik = 2000
group by s.ImeS
order by s.ImeS;

--10. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 
--urejeno po odkupni koli�ini padajo�e, uporabi imena sort
select sum(p.Kolicina) as 'skupno', s.ImeS
from Prevzem p
inner join Sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik = 2000
group by s.ImeS
order by 'skupno' desc;

--11. kateri �lan je pripeljal najve� grozdja naenkrat? Izpi�i �ifro �lana (9270120)
select sum(p.Kolicina) as 'Skupna kolicina', c.Sifra_clan 
from �lan c
inner join Prevzem p on p.Sifra_clan=c.Sifra_clan
group by c.Sifra_clan
order by 'Skupna kolicina' desc;

--12. izpi�i ime �lana, ki je pripeljal najve� grozdja naenkrat (Koncut Damijan)
--13. izpi�i �ifro �lana, ki je v letu 2003 pripeljal najve� grozdja (9330030)
--14. Koliko je vseh �lanov (760)
--15. Koliko �lanov je pripeljalo grozdje v letu 2001 (720)