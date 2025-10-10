/* ==========================================================
   1️  Ustvarimo testno tabelo z različnimi tipi podatkov
   ========================================================== */
CREATE TABLE PrimerTipov
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Znesek_Decimal DECIMAL(18,2),
    Znesek_Numeric NUMERIC(18,2),
    Znesek_Money MONEY,
    Znesek_SmallMoney SMALLMONEY
);



/* ==========================================================
   2️ Vstavimo nekaj primerov podatkov
   ========================================================== */
INSERT INTO PrimerTipov (Znesek_Decimal, Znesek_Numeric, Znesek_Money, Znesek_SmallMoney)
VALUES 
(1234.56, 1234.56, 1234.56, 1234.56),
(0.1, 0.1, 0.1, 0.1),
(99999999999999.99, 99999999999999.99, 99999999999999.99, 214748.36); -- največje vrednosti


/* ==========================================================
   3️  Preverimo shranjene vrednosti
   ========================================================== */
SELECT 
    ID,
    Znesek_Decimal,
    Znesek_Numeric,
    Znesek_Money,
    Znesek_SmallMoney
FROM PrimerTipov;
GO


/* ==========================================================
   4️  Preverimo natančnost računanja
   ========================================================== */

-- Decimal in Numeric: natančni izračuni
SELECT 
    (0.1 * 3) AS TestDecimalNumeric
;

-- Money in Smallmoney: lahko pride do binarnih napak
DECLARE @m MONEY = 0.1;
SELECT 
    @m * 3 AS TestMoney
;

-- Primer v isti tabeli: množimo vsoto z 3
SELECT 
    Znesek_Decimal * 3 AS Rezultat_Decimal,
    Znesek_Numeric * 3 AS Rezultat_Numeric,
    Znesek_Money * 3 AS Rezultat_Money
    --Znesek_SmallMoney * 3 AS Rezultat_SmallMoney
FROM PrimerTipov;
GO
SELECT 
    CASE 
        WHEN CAST(Znesek_SmallMoney AS MONEY) * 3 BETWEEN -214748.3648 AND 214748.3647 
        THEN Znesek_SmallMoney * 3
        ELSE NULL
    END AS Rezultat_SmallMoney
FROM PrimerTipov;

/* ==========================================================
   5️  Očistimo po koncu testa
   ========================================================== */
 DROP TABLE PrimerTipov;


 CREATE TABLE NapredniTipi
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Hierarhija hierarchyid,
    Varianta sql_variant,
    CasovniZig timestamp, -- namesto tega uporabljamo rowversion
    Guid uniqueidentifier,
    XmlPodatek xml,
    GeoTočka geography,
    Geometrija geometry
);

 CREATE TABLE NapredniTipi1
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Hierarhija hierarchyid,
    Varianta sql_variant,
    CasovniZig rowversion, -- namesto tega uporabljamo rowversion, edinstven v bazi, ni povezan s časom
    Guid uniqueidentifier,
    XmlPodatek xml,
    GeoTočka geography,
    Geometrija geometry
);
INSERT INTO NapredniTipi1 
(
    Hierarhija,
    Varianta,
    Guid,
    XmlPodatek,
    GeoTočka,
    Geometrija
)
VALUES
(
    hierarchyid::GetRoot().GetDescendant(NULL, NULL),  -- korenski element
    CAST(123.45 AS sql_variant),                        -- lahko bi bilo tudi N'Tekst' ali GETDATE()
    NEWID(),                                            -- ustvari naključni GUID
    '<Oseba><Ime>Janez</Ime><Priimek>Novak</Priimek></Oseba>', -- XML primer
    geography::Point(46.056946, 14.505751, 4326),       -- Ljubljana (lat, lon, SRID=4326)
    geometry::Point(100, 200, 0)                        -- 2D točka
);
GO
SELECT 
    ID,
    Hierarhija.ToString() AS HierarhijaPot,
    Varianta,
	CasovniZig,
    Guid,
    XmlPodatek.value('(/Oseba/Ime/text())[1]', 'nvarchar(50)') AS ImeIzXML,
    GeoTočka.Lat AS Latituda,
    GeoTočka.Long AS Longituda,
    Geometrija.STAsText() AS GeometrijaText
FROM NapredniTipi1;