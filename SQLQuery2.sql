--1. izpiši vse podatke o èlanih (rezultat ima 760 vrstic)
select * from Èlan;

--2. izpiši vse podatke o èlanih, urejene po priimku èlana
select * from Èlan
order by Ime asc;

--3. izpiši vse podatke o èlanih, urejene po številki vasi, nato pa po imenih
select * from Èlan
order by Vas, Ime;

--4. izpiši ime èlana, naslov in ime vasi, urejene po imenu vasi, nato po imenih èlana
select c.Ime, c.Naslov, v.Ime_vasi from Èlan c
inner join Vasi v on c.Vas=v.Sifra_vas
order by v.Ime_vasi, c.Ime;

--5. izpiši imena èlanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select Ime from Èlan
where Ime like '%franc%';

--6. izpiši skupno kolièino pripeljanega grozdja po posameznem èlanu iz tabele prevzem. V izpisu naj bo šifra
-- èlana in skupna kolièina grozdja, izpis uredi po šifri èlana
select sum(p.Kolicina) as 'Skupna kolicina', c.Ime 
from Èlan c
inner join Prevzem p on p.Sifra_clan=c.Sifra_clan
group by c.Ime;

--7. izpiši skupno kolièino grozdja po letnikih iz tabele Prevzem
select sum(Kolicina) as 'Skupna kolicina', Letnik
from Prevzem
group by Letnik;

--8. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sum(Kolicina), Sorta
from Prevzem
where Letnik = 2000
group by Sorta
order by Sorta;

--9. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah, uporabi imena sort
select sum(p.Kolicina), s.ImeS
from Prevzem p
inner join Sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik = 2000
group by s.ImeS
order by s.ImeS;

--10. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 
--urejeno po odkupni kolièini padajoèe, uporabi imena sort
select sum(p.Kolicina) as 'skupno', s.ImeS
from Prevzem p
inner join Sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik = 2000
group by s.ImeS
order by 'skupno' desc;

--11. kateri èlan je pripeljal najveè grozdja naenkrat? Izpiši šifro èlana (9270120)
select c.Sifra_clan from Èlan c
join Prevzem p on p.Sifra_clan=c.Sifra_clan
where kolicina = (select max(kolicina) from Prevzem);

--12. izpiši ime èlana, ki je pripeljal najveè grozdja naenkrat (Koncut Damijan)
select c.Ime from Èlan c
join Prevzem p on p.Sifra_clan=c.Sifra_clan
where kolicina = (select max(kolicina) from Prevzem);

--13. izpiši šifro èlana, ki je v letu 2003 pripeljal najveè grozdja (9330030)
select top 1 Sifra_clan from Prevzem
where Letnik=2003
group by Sifra_clan
order by sum(Kolicina) desc;

--14. Koliko je vseh èlanov (760)
select count(*) from Èlan;

--15. Koliko èlanov je pripeljalo grozdje v letu 2001 (720)
select count(distinct Sifra_clan) from Prevzem
where letnik=2001;

select count(distinct c.Sifra_clan) from Èlan c
inner join Prevzem p on p.Sifra_clan=c.Sifra_clan
where letnik=2001;

--16. Koliko èlanov ni pripeljalo grozdja v letu 2001 (40)
select count(*) from Èlan 
where Sifra_clan not in (select distinct Sifra_clan from Prevzem where Letnik=2001);

--17. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2001, uredi po imenu
select Ime, Naslov from Èlan 
where Sifra_clan not in (select distinct Sifra_clan from Prevzem where Letnik=2001)
order by Ime;

--18. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2000 ali 2001 ali 2002 ali 2003, 
--uredi po imenu
select Ime, Naslov from Èlan 
where Sifra_clan not in 
(select distinct Sifra_clan 
from Prevzem where Letnik between 2000 and 2003)
order by Ime;

--19. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in povpreèna 
-- stopnja sladkorje povpreèno sladkorno stopnjo izraèunamo kot povreèje kolièina*sladkor nato delimo s kolièino, 
-- izpis uredi po letnikih in po sladkornih stopnjah, padajoèe
select Letnik, s.ImeS, 
	sum(Kolicina), 
	sum(kolicina*sladkor)/sum(kolicina) as [Povreèni sladkor]
	from Prevzem p
join Sorta s on p.Sorta=s.Sifra_sorta
group by Letnik, s.ImeS
order by Letnik, imes desc;

--20. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in 
-- povpreèna stopnja sladkorje
select Letnik, s.ImeS, 
	sum(Kolicina), 
	avg(kolicina*sladkor)/sum(kolicina) as [Povreèni sladkor]
	from Prevzem p
join Sorta s on p.Sorta=s.Sifra_sorta
group by Letnik, s.ImeS
order by Letnik, imes desc;


--2. vstavi v tabelo podatke o sortah iz tabele sorta
insert into Grozdje select * from Sorta;
--3. vstavi v tabelo grozdje sorto 501 z imenom Laški rizling
insert into Grozdje values
(501, 'Laški rizling', null, null, null);

--4. popravi barvo vseh sort, kjer je vrednost barve null v belo
update Grozdje 
set Barva='belo' where Barva=null;

--5. izbriši podatke iz tabele Grozdje
delete from Grozdje;

--6. izbriši tabelo Grozdje
drop table Grozdje;