IF OBJECT_ID('Produkty_w_zam', 'U') IS NOT NULL
DROP TABLE Produkty_w_zam

IF OBJECT_ID('Zamowienia', 'U') IS NOT NULL
DROP TABLE Zamowienia

IF OBJECT_ID('Towary', 'U') IS NOT NULL
DROP TABLE Towary

IF OBJECT_ID('Klienci', 'U') IS NOT NULL
DROP TABLE Klienci

IF OBJECT_ID('Handlowcy', 'U') IS NOT NULL
DROP TABLE Handlowcy

IF OBJECT_ID('Oddzial', 'U') IS NOT NULL
DROP TABLE Oddzial
GO

IF OBJECT_ID('Oddzial', 'U') IS NULL
CREATE TABLE Oddzial(
ID INT NOT NULL PRIMARY KEY,
Kraj VARCHAR(30),
Miasto VARCHAR(30),
Adres VARCHAR(50))
SELECT * FROM Oddzial

IF OBJECT_ID('Handlowcy', 'U') IS NULL
CREATE TABLE Handlowcy(
Akronim VARCHAR(30) NOT NULL  PRIMARY KEY,
Oddzial INT NOT NULL,
Dzial VARCHAR(30),
Nazwisko VARCHAR(30),
Stanowisko VARCHAR(30)
FOREIGN KEY(Oddzial) REFERENCES Oddzial(ID))
SELECT * FROM Handlowcy

IF OBJECT_ID('Klienci', 'U') IS NULL
CREATE TABLE Klienci(
Akronim VARCHAR(30) NOT NULL PRIMARY KEY,
Nazwa VARCHAR(30),
Opiekun VARCHAR(30) NOT NULL,
Kraj VARCHAR(30),
FOREIGN KEY(Opiekun) REFERENCES Handlowcy(Akronim))
SELECT * FROM Klienci

IF OBJECT_ID('Towary', 'U') IS NULL
CREATE TABLE Towary(
Kod_glowny VARCHAR(30) NOT NULL PRIMARY KEY,
Nazwa VARCHAR(100),
Cena_zakupu FLOAT NOT NULL,
Cena_glowna FLOAT)
SELECT * FROM Towary

IF OBJECT_ID('Zamowienia', 'U') IS NULL
CREATE TABLE Zamowienia(
ZS_nr INT NOT NULL PRIMARY KEY,
Data_zam DATE,
Magazyn INT NOT NULL,
Handlowiec VARCHAR(30)NOT NULL,
Klient VARCHAR(30) NOT NULL,
FOREIGN KEY(Magazyn) REFERENCES Oddzial(ID),
FOREIGN KEY(Handlowiec) REFERENCES Handlowcy(Akronim),
FOREIGN KEY(Klient) REFERENCES Klienci(Akronim))
SELECT * FROM Zamowienia

IF OBJECT_ID('Produkty_w_zam', 'U') IS NULL
CREATE TABLE Produkty_w_zam(
ID INT NOT NULL PRIMARY KEY,
Kod_towaru VARCHAR(30) NOT NULL,
Cena_ustalona FLOAT NOT NULL,
ZS INT NOT NULL,
Ilosc INT NOT NULL,
FOREIGN KEY(Kod_towaru) REFERENCES Towary(Kod_glowny),
FOREIGN KEY(ZS) REFERENCES Zamowienia(ZS_nr))
SELECT * FROM Produkty_w_zam


INSERT INTO Oddzial (ID, Kraj, Miasto, Adres) VALUES
(101, 'PL', 'Poznan', 'Poznanska 1'),
(102, 'CZ', 'Praga', 'Praska 2'),
(103, 'SK', 'Bratyslawa', 'Bratyslawska 3'),
(104, 'PL', 'Warszawa', 'Warszawska 4')
GO
SELECT * FROM Oddzial

INSERT INTO Handlowcy(Akronim, Oddzial, Dzial, Nazwisko, Stanowisko) VALUES
('BBA', 101, 'Sprzedaz sieci', 'Bartkowski', 'Specjalista'),
('BBE', 101, 'Sprzedaz sieci', 'Bernadecka', 'Specjalista'),
('CCE', 101, 'Sprzedaz sieci', 'Celinska', 'Asystent'),
('DDO', 101, 'Handlowy', 'Dorotowska', 'Przedstawiciel handlowy'),
('EED', 101, 'Detal', ' Edwardzki', 'Specjalista'),
('GGR', 104, 'Handlowy', 'Grazynska', 'Przedstawiciel handlowy'),
('HHA', 104, 'Detal', 'Halinska', 'Specjalista'),
('IIG', 104, 'Eksport', 'Igorski', 'Specjalista'),
('JJA', 104, 'Eksport', 'Janicki', 'Specjalista'),
('KKO', 104, 'Eksport', 'Kowalska', 'Asystent'),
('LLE', 102, 'Sieci eksport', 'Lenska', 'Specjalista'),
('MMO', 102, 'Sieci eksport', 'Monovski', 'Specjalista'),
('NNO', 102, 'Sieci eksport', 'Novicki', 'Asystent'),
('OOL', 103, 'Sieci eksport', 'Olenska', 'Specjalista'),
('PPI', 103, 'Sieci eksport', 'Piotrovski', 'Specjalista'),
('RRO', 103, 'Sieci eksport', 'Romanski', 'Specjalista')
GO
SELECT * FROM Handlowcy

INSERT INTO Klienci(Akronim, Nazwa, Opiekun, Kraj) VALUES
	('BDR', 'Biedronka', 'BBA', 'PL'),
    ('KRB', 'Kaufland', 'BBA', 'PL'),
    ('RTS', 'Rossmann', 'BBA', 'PL'),
    ('TES', 'Tesco', 'BBA', 'PL'),
    ('ASN', 'Auchan', 'BBA', 'PL'),
    ('LDL', 'Lidl', 'BBA', 'PL'),
    ('WLM', 'Walmart', 'BBE', 'US'),
    ('TGT', 'Target', 'BBE', 'US'), 
    ('CST', 'Costco', 'BBE', 'US'),
    ('CRF', 'Carrefour', 'DDO', 'FR'),
    ('GTS', 'Géant', 'DDO', 'FR'),
    ('INA', 'Intermarché', 'DDO', 'FR'),
    ('WLL', 'Woolworths', 'EED', 'AU'),
    ('CWL', 'Coles', 'EED', 'AU'),
    ('ALD', 'Aldi', 'EED', 'AU'),
    ('AMZ', 'Amazon', 'GGR', 'US'),
    ('HDK', 'Home Depot', 'GGR', 'US'),
    ('WLG', 'Walgreens', 'GGR', 'US'),
    ('TSC', 'Tesco', 'HHA', 'GB'),
    ('SNS', 'Sainsbury', 'HHA', 'GB'),
    ('ASD', 'ASDA', 'HHA', 'GB'),
    ('WMT', 'Walmart', 'IIG', 'US'),
    ('TGT1', 'Target', 'IIG', 'US'), 
    ('HME', 'Home Depot', 'IIG', 'US'),
    ('BRC', 'Brico', 'JJA', 'GB'),
    ('LWB', 'Leroy Merlin', 'JJA', 'GB'),
    ('MXT', 'Maxi', 'JJA', 'GB'),
    ('FNK', 'Fnac', 'KKO', 'FR'),
    ('BHR', 'But', 'KKO', 'FR'),
    ('LMR', 'La Maison de la Radio', 'KKO', 'FR'),
    ('HMD', 'Home Depot', 'LLE', 'US'),
    ('LWS', 'Lowes', 'LLE', 'US'),
    ('BDQ', 'Bed Bath & Beyond', 'LLE', 'US'),
    ('SNS1', 'Sainsbury', 'MMO', 'GB'),
    ('SPC', 'Superdrug', 'MMO', 'GB'),
    ('WGS', 'Waitrose', 'MMO', 'GB'),
    ('WLM1', 'Woolworths', 'NNO', 'AU'),
    ('CLU', 'Coles', 'NNO', 'AU'),
    ('KMT', 'Kmart', 'NNO', 'AU'),
    ('CRF1', 'Carrefour', 'OOL', 'FR'),
    ('ITM', 'Intermarché', 'OOL', 'FR'),
    ('LMR1', 'Leclerc', 'OOL', 'FR'), 
    ('WMT1', 'Walmart', 'PPI', 'US'), 
    ('TGT2', 'Target', 'PPI', 'US'), 
    ('CST1', 'Costco', 'PPI', 'US'),
    ('KRB1', 'Kaufland', 'RRO', 'PL'),
    ('BDR1', 'Biedronka', 'RRO', 'PL'),
    ('RTS1', 'Rossmann', 'RRO', 'PL')
GO
SELECT * FROM Klienci


INSERT INTO Towary (Kod_glowny, Nazwa, Cena_zakupu, Cena_glowna)
VALUES
    ('ABC1234', 'Kitchen Pot', 10.0, 14.5),
    ('DEF5678', 'Non-Stick Pan', 15.0, 22.5),
    ('GHI9012', 'Storage Box (Small)', 20.0, 30.0),
    ('JKL3456', 'Dinnerware Set', 12.5, 18.75),
    ('MNO7890', 'Cutlery Organizer', 8.0, 11.6),
    ('PQR2345', 'Glass Tumbler', 18.0, 27.0),
    ('STU6789', 'Cooking Utensil Set', 25.0, 37.5),
    ('VWX0123', 'Food Storage Container (Medium)', 9.5, 13.83),
    ('YZA4567', 'Bathroom Organizer', 14.0, 20.3),
    ('BCD8901', 'Knife Set', 30.0, 45.0),
    ('EFG2345', 'Wine Glasses (Set of 4)', 11.0, 16.15),
    ('HIJ6789', 'Laundry Hamper', 22.0, 33.0),
    ('KLM0123', 'Plastic Drawer Organizer', 16.5, 24.23),
    ('NOP4567', 'Baking Sheet', 13.0, 18.85),
    ('QRS8901', 'Coffee Mug Set (Set of 6)', 17.5, 25.38),
    ('TUV2345', 'Food Storage Container (Large)', 19.0, 28.5),
    ('WXY6789', 'Shoe Rack', 11.5, 16.83),
    ('ZAB0123', 'Casserole Dish', 28.0, 42.0),
    ('CDE4567', 'Hanging Closet Organizer', 9.0, 13.13),
    ('FGH8901', 'Wall Clock', 23.0, 34.5),
    ('IJK2345', 'Pillow Set (Set of 2)', 21.5, 31.73),
    ('LMN6789', 'Garbage Can', 15.0, 22.5),
    ('OPQ0123', 'Bathroom Towel Set (Set of 6)', 12.0, 17.4),
    ('RST4567', 'Cookware Set', 26.0, 39.0),
    ('TUV8901', 'Bed Sheet Set', 10.5, 15.23),
    ('WXY2345', 'Shower Curtain', 27.0, 40.5),
    ('ZAB6789', 'Hanging Planters (Set of 3)', 20.0, 30.0),
    ('CDE0123', 'Dish Rack', 14.5, 21.18),
    ('FGH4567', 'Picture Frame Set (Set of 5)', 11.0, 16.15),
    ('IJK8901', 'Ironing Board', 19.0, 28.5),
    ('LMN2345', 'Soap Dispenser', 25.0, 37.5),
    ('OPQ6789', 'Spice Rack', 18.0, 27.0),
    ('RST0123', 'Bath Mat Set (Set of 2)', 13.5, 19.73),
    ('UVW4567', 'Dustpan and Broom Set', 14.0, 20.3),
    ('XYZ8901', 'Decorative Throw Pillow', 16.0, 23.2),
    ('ABC2345', 'Utensil Holder', 9.0, 13.05),
    ('DEF6789', 'Laptop Stand', 25.0, 37.5),
    ('GHI0123', 'Glass Food Storage Jar', 12.0, 17.4),
    ('JKL4567', 'Drawer Dividers (Set of 4)', 22.0, 33.0),
    ('MNO8901', 'Tea Infuser', 8.5, 12.33),
    ('PQR2346', 'Magnetic Key Holder', 19.0, 28.5),
    ('STU6790', 'Shoe Cleaning Kit', 15.0, 22.5),
    ('VWX0124', 'Wall Shelf', 27.0, 40.5)
GO
SELECT * FROM Towary

INSERT INTO Zamowienia (ZS_nr, Data_zam, Magazyn, Handlowiec, Klient)
VALUES
    (1, '2023-03-01', 101, 'BBE', 'WLM'),
    (2, '2023-03-02', 104, 'IIG', 'WMT'),
    (3, '2023-03-03', 101, 'BBA', 'TES'),
    (4, '2023-03-04', 103, 'DDO', 'CRF'),
    (5, '2023-03-05', 102, 'MMO', 'SNS1'),
    (6, '2023-03-06', 101, 'NNO', 'CLU'),
    (7, '2023-03-07', 104, 'RRO', 'KRB1'),
    (8, '2023-03-08', 103, 'RRO', 'RTS1'),
    (9, '2023-03-09', 102, 'LLE', 'BDQ'),
    (10, '2023-03-10', 101, 'HHA', 'SNS'),
    (11, '2023-03-11', 104, 'HHA', 'ASD'),
    (12, '2023-03-12', 103, 'OOL', 'CRF1'),
    (13, '2023-03-13', 102, 'NNO', 'KMT'),
    (14, '2023-03-14', 101, 'OOL', 'LMR1'),
    (15, '2023-03-15', 104, 'PPI', 'WMT1'),
    (16, '2023-03-16', 103, 'PPI', 'CST1'),
    (17, '2023-03-17', 102, 'RRO', 'KRB1'),
    (18, '2023-03-18', 101, 'RRO', 'RTS1'),
    (19, '2023-03-19', 104, 'RRO', 'BDR1'),
    (20, '2023-03-20', 103, 'NNO', 'WLM1'),
    (21, '2023-03-21', 101, 'BBA', 'ASN'),
    (22, '2023-03-22', 102, 'MMO', 'SNS1'),
    (23, '2023-03-23', 101, 'EED', 'CWL'),
    (24, '2023-03-24', 104, 'PPI', 'TGT2'),
    (25, '2023-03-25', 103, 'DDO', 'CRF'),
    (26, '2023-03-26', 102, 'MMO', 'SPC'),
    (27, '2023-03-27', 101, 'JJA', 'BRC'),
    (28, '2023-03-28', 104, 'OOL', 'LMR1'),
    (29, '2023-03-29', 103, 'PPI', 'WMT1'),
    (30, '2023-03-30', 102, 'NNO', 'CLU'),
    (31, '2023-03-31', 101, 'HHA', 'ASD'),
    (32, '2023-04-01', 104, 'DDO', 'CRF'),
    (33, '2023-04-02', 103, 'NNO', 'KMT'),
    (34, '2023-04-03', 102, 'RRO', 'RTS1'),
    (35, '2023-04-04', 101, 'IIG', 'WMT'),
    (36, '2023-04-05', 104, 'OOL', 'CRF1'),
    (37, '2023-04-06', 103, 'RRO', 'KRB1'),
    (38, '2023-04-07', 102, 'LLE', 'BDQ'),
    (39, '2023-04-08', 101, 'HHA', 'SNS'),
    (40, '2023-04-09', 104, 'HHA', 'ASD'),
    (41, '2023-04-10', 103, 'OOL', 'CRF1'),
    (42, '2023-04-11', 102, 'NNO', 'KMT'),
    (43, '2023-04-12', 101, 'OOL', 'LMR1'),
    (44, '2023-04-13', 104, 'PPI', 'WMT1'),
    (45, '2023-04-14', 103, 'PPI', 'CST1'),
    (46, '2023-04-15', 102, 'RRO', 'KRB1'),
    (47, '2023-04-16', 101, 'RRO', 'RTS1'),
    (48, '2023-04-17', 104, 'RRO', 'BDR1'),
    (49, '2023-04-18', 103, 'NNO', 'WLM1'),
    (50, '2023-04-19', 102, 'BBA', 'ASN')
GO
SELECT * FROM Zamowienia

INSERT INTO Produkty_w_zam (ID, Kod_towaru, Cena_ustalona, ZS, Ilosc) VALUES
(1, 'ABC1234', 15.23, 1, 100),
(2, 'DEF5678', 23.63, 1, 50),
(3, 'GHI9012', 31.50, 2, 500),
(4, 'JKL3456', 19.69, 3, 300),
(5, 'MNO7890', 11.60, 3, 25),
(6, 'PQR2345', 27.00, 3, 70),
(7, 'STU6789', 37.50, 4, 1000),
(8, 'VWX0123', 13.83, 5, 100),
(9, 'YZA4567', 20.30, 5, 200),
(10, 'BCD8901', 45.00, 6, 600),
(11, 'EFG2345', 16.15, 6, 700),
(12, 'HIJ6789', 33.00, 7, 2000),
(13, 'KLM0123', 24.23, 8, 200),
(14, 'NOP4567', 18.85, 9, 3000),
(15, 'QRS8901', 25.38, 10, 70),
(16, 'TUV2345', 28.50, 10, 800),
(17, 'WXY6789', 16.83, 11, 1400),
(18, 'ZAB0123', 42.00, 12, 400),
(19, 'CDE4567', 13.13, 12, 750),
(20, 'FGH8901', 34.50, 13, 5000),
(21, 'IJK2345', 31.73, 14, 2500),
(22, 'LMN6789', 22.50, 15, 200),
(23, 'OPQ0123', 17.40, 15, 150),
(24, 'RST4567', 39.00, 16, 4000),
(25, 'TUV8901', 15.23, 16, 50),
(26, 'WXY2345', 40.50, 17, 3000),
(27, 'ZAB6789', 30.00, 18, 4500),
(28, 'CDE0123', 21.18, 19, 300),
(29, 'FGH4567', 16.15, 19, 240),
(30, 'IJK8901', 28.50, 20, 500),
(31, 'LMN2345', 37.50, 20, 480),
(32, 'OPQ6789', 27.00, 21, 1500),
(33, 'RST0123', 19.73, 22, 370),
(34, 'UVW4567', 20.30, 22, 440),
(35, 'XYZ8901', 23.20, 23, 800),
(36, 'ABC2345', 13.05, 23, 900),
(37, 'DEF6789', 37, 24, 3000),
(38, 'GHI0123', 16.99, 25, 500),
(39, 'JKL4567', 27.50, 25, 400),
(40, 'MNO8901', 19.80, 26, 300),
(41, 'PQR2345', 22.50, 27, 9000),
(42, 'STU6789', 27.90, 28, 220),
(43, 'VWX0123', 9.99, 28, 290),
(44, 'YZA4567', 14.75, 29, 4200),
(45, 'BCD8901', 45.99, 30, 290),
(46, 'EFG2345', 18.30, 30, 700),
(47, 'HIJ6789', 16.80, 31, 2050),
(48, 'KLM0123', 25.50, 31, 300),
(49, 'NOP4567', 19.99, 32, 500),
(50, 'STU6789', 32.99, 33, 800),
(51, 'VWX0123', 13.83, 33, 240),
(52, 'YZA4567', 20.30, 34, 780),
(53, 'BCD8901', 45.00, 35, 6200),
(54, 'EFG2345', 16.15, 36, 900),
(55, 'HIJ6789', 33.00, 37, 680),
(56, 'KLM0123', 24.23, 37, 210),
(57, 'NOP4567', 18.85, 38, 2130),
(58, 'QRS8901', 25.38, 38, 500),
(59, 'TUV2345', 28.50, 39, 900),
(60, 'WXY6789', 16.83, 39, 450),
(61, 'ZAB0123', 42.00, 39, 220),
(62, 'CDE4567', 13.13, 40, 640),
(63, 'FGH8901', 34.50, 40, 500),
(64, 'IJK2345', 31.73, 41, 800),
(65, 'LMN6789', 22.50, 41, 540),
(66, 'OPQ0123', 17.40, 41, 200),
(67, 'RST4567', 39.00, 42, 300),
(68, 'TUV8901', 15.23, 42, 470),
(69, 'WXY2345', 40.50, 42, 500),
(70, 'ZAB6789', 30.00, 43, 700),
(71, 'CDE0123', 21.18, 43, 880),
(72, 'FGH4567', 16.15, 43, 1400),
(73, 'IJK8901', 28.50, 44, 3000),
(74, 'LMN2345', 37.50, 45, 280),
(75, 'OPQ6789', 27.00, 45, 600),
(76, 'RST0123', 19.73, 45, 240),
(77, 'UVW4567', 20.30, 45, 700),
(78, 'XYZ8901', 23.20, 46, 360),
(79, 'ABC2345', 13.05, 46, 1200),
(80, 'DEF6789', 37.50, 47, 280),
(81, 'GHI0123', 17.40, 47, 980),
(82, 'MNO8901', 12.33, 47, 120),
(83, 'PQR2346', 28.50, 48, 930),
(84, 'STU6790', 22.50, 49, 870),
(85, 'VWX0124', 40.50, 49, 200),
(86, 'ABC1234', 15.23, 50, 510),
(87, 'DEF5678', 23.63, 50, 600)
SELECT * FROM  Produkty_w_zam


IF OBJECT_ID('Kraje_wysylek','V') IS NOT NULL
DROP VIEW Kraje_wysylek
GO
CREATE VIEW Kraje_wysylek AS (
SELECT Ilosc_wysylek=COUNT(z.ZS_nr), k.Kraj FROM Zamowienia z
INNER JOIN Klienci k ON z.Klient=k.Akronim
GROUP BY k.Kraj
)
GO
SELECT * FROM Kraje_wysylek
ORDER BY Ilosc_wysylek DESC


IF OBJECT_ID('Srednia_marza','V') IS NOT NULL
DROP VIEW Srednia_marza
GO

CREATE VIEW Srednia_marza AS (
SELECT h.Nazwisko, Srednia_marza=ROUND(AVG((p.Cena_ustalona-t.Cena_zakupu)/p.Cena_ustalona),2)
FROM Handlowcy h
INNER JOIN Zamowienia z ON z.Handlowiec = h.Akronim
INNER JOIN Produkty_w_zam p ON p.ZS = z.ZS_nr
INNER JOIN Towary t ON t.Kod_glowny = p.Kod_towaru
GROUP BY h.Nazwisko
)
GO
SELECT * FROM Srednia_marza
ORDER BY Srednia_marza DESC

IF OBJECT_ID('Produkty_przychod','V') IS NOT NULL
DROP VIEW Produkty_przychod 
GO

CREATE VIEW Produkty_przychod AS (
SELECT t.Nazwa, Ilosc_zam=COUNT(p.ZS),  Ilosc_zam_szt=SUM(p.Ilosc), Przychod = SUM(p.Ilosc*(p.Cena_ustalona-t.Cena_zakupu))
FROM Towary t
INNER JOIN Produkty_w_zam p ON t.Kod_glowny=p.Kod_towaru
INNER JOIN Zamowienia z ON z.ZS_nr = p.ZS
INNER JOIN Klienci k ON k.Akronim = z.Klient
GROUP BY t.Nazwa
)
GO
SELECT * FROM Produkty_przychod
ORDER BY Przychod DESC

--raport: plan sprzedarzowy
IF OBJECT_ID('Ustalenie_planu', 'P') IS NOT NULL
DROP PROCEDURE Ustalenie_planu
GO

CREATE PROCEDURE Ustalenie_planu(
	@Miesiac INT
	) AS
BEGIN
SELECT  z.Handlowiec, NowyPlan=ROUND(SUM(p.Cena_ustalona*p.Ilosc)*1.15, 2)
        FROM Zamowienia z
        JOIN Produkty_w_zam p ON z.ZS_nr=p.ZS
        WHERE MONTH(z.Data_zam) = @Miesiac
        GROUP BY z.Handlowiec
END;
GO


IF OBJECT_ID('Oddzialy_wg_obrotu', 'P') IS NOT NULL
DROP PROCEDURE Oddzialy_wg_obrotu
GO

CREATE PROCEDURE Oddzialy_wg_obrotu(
	@Miesiac INT
	) AS
BEGIN
SELECT  o.ID, o.Miasto, Obrot=SUM(p.Cena_ustalona*p.Ilosc)
        FROM Oddzial o
        JOIN Zamowienia z ON z.Magazyn=o.ID
		JOIN Produkty_w_zam p ON p.ZS=z.ZS_nr
        WHERE MONTH(z.Data_zam) = @Miesiac
        GROUP BY o.ID, o.Miasto
		ORDER BY Obrot DESC
END;
GO
EXEC Oddzialy_wg_obrotu 3;
EXEC Ustalenie_planu 3;