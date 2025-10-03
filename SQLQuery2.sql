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

--5. izpiši imena èlanov, ki vsebujejo besedo 'FRANC' (17 takih je)select Ime from Èlan
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
select sum(p.Kolicina) as 'Skupna kolicina', c.Sifra_clan 
from Èlan c
inner join Prevzem p on p.Sifra_clan=c.Sifra_clan
group by c.Sifra_clan
order by 'Skupna kolicina' desc;

--12. izpiši ime èlana, ki je pripeljal najveè grozdja naenkrat (Koncut Damijan)
--13. izpiši šifro èlana, ki je v letu 2003 pripeljal najveè grozdja (9330030)
--14. Koliko je vseh èlanov (760)
--15. Koliko èlanov je pripeljalo grozdje v letu 2001 (720)