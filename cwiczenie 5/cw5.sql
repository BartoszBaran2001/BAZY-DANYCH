CREATE DATABASE firma

CREATE SCHEMA IF NOT EXISTS ksiegowosc

CREATE TABLE ksiegowosc.pracownicy(
id_pracownika INT PRIMARY KEY NOT NULL,
imie VARCHAR(40)NOT NULL, 
nazwisko VARCHAR(50)NOT NULL, 
adres VARCHAR(70), 
telefon VARCHAR(9)
);

CREATE TABLE ksiegowosc.godziny(
id_godziny INT PRIMARY KEY NOT NULL,
data DATE NOT NULL, 
liczba_godzin INT NOT NULL, 
id_pracownika INT NOT NULL
);

CREATE TABLE ksiegowosc.pensja(
id_pensji INT PRIMARY KEY NOT NULL,
stanowisko VARCHAR(50) NOT NULL, 
kwota DECIMAL(10,2) NOT NULL 
);

CREATE TABLE ksiegowosc.premia(
id_premii INT PRIMARY KEY NOT NULL,
rodzaj VARCHAR(50), 
kwota DECIMAL(10,2) NOT NULL 
);

CREATE TABLE ksiegowosc.wynagrodzenie(
id_wynagrodzenia INT PRIMARY KEY NOT NULL, 
data DATE NOT NULL,
id_pracownika INT NOT NULL,
id_godziny INT NOT NULL,
id_pensji INT NOT NULL,
id_premii INT NOT NULL
);

ALTER TABLE ksiegowosc.godziny ADD CONSTRAINT fkid_pracownika FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie  ADD CONSTRAINT fkid_pracownika FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie  ADD CONSTRAINT fkid_godziny FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie  ADD CONSTRAINT fkid_pensji FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie  ADD CONSTRAINT fkid_premii FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
('1','Hubert','Pietrzak','ul. Zamczysko 134, Bydgoszcz','770644261'),
('2','Eustachy', 'Woźniak','ul. Czeremchowa 88, Lublin','873449533'),
('3','Weronika', 'Pawlak','ul. Puszkina Aleksandra 92, Opole','986497329'),
('4','Konrad','Wasilewski','ul. Platynowa 7, Gdynia','938479239'),
('5','Radosław','Gajewski','ul. Otyńska 19, Wrocław','403883905'),
('6','Martyna', 'Witkowska','ul. Modlińska 100, Warszawa','630686462'),
('7','Edward','Jaworski','ul. Głogowska 138, Poznań','193269568'),
('8','Paulina','Pawlak','ul. Krótka 49, Mikołów','507787172'),
('9','Andrzej','Włodarczyk','ul. Bagno 52, Warszawa','442515102'),
('10','Olga','Zalewska','ul. Janosika 3, Poznań','481221454');

INSERT INTO ksiegowosc.godziny (id_godziny,data,liczba_godzin,id_pracownika)
VALUES
('1','2021-07-10','8','6'),
('2','2021-07-11','4','3'),
('3','2021-07-12','10','1'),
('4','2021-07-12','2','8'),
('5','2021-07-15','6','7'),
('6','2021-07-15','6','2'),
('7','2021-07-15','4','10'),
('8','2021-07-16','10','5'),
('9','2021-07-17','2','9'),
('10','2021-07-19','8','4');

INSERT INTO ksiegowosc.premia (id_premii,rodzaj,kwota)
VALUES
('1','uznaniowa','125.00'),
('2','uznaniowa','50.00'),
('3','regulaminowa','300.00'),
('4','regulaminowa','300.00'),
('5','uznaniowa','100.00'),
('6','uznaniowa','50.00'),
('7','regulaminowa','300.00'),
('8','uznaniowa','150.00'),
('9','uznaniowa','100.00'),
('10','regulaminowa','300.00');

INSERT INTO ksiegowosc.pensja (id_pensji,stanowisko,kwota)
VALUES
('1','Księgowy','4853.24'),
('2','Zastępca Kierownika','6125.00'),
('3','Analityk','4600.00'),
('4','Analityk','4900.00'),
('5','Programista','6200.00'),
('6','Analityk','5300.00'),
('7','Administrator','4000.00'),
('8','Księgowy','5000.34'),
('9','Programista','6000.00'),
('10','Kierownik','6600.60');

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
('1','2021-07-10','6','1','2','2'),
('2','2021-07-11','1','3','5','10'),
('3','2021-07-12','10','7','4','6'),
('4','2021-07-12','8','4','10','1'),
('5','2021-07-15','5','8','8','5'),
('6','2021-07-15','9','9','7','8'),
('7','2021-07-15','4','10','3','4'),
('8','2021-07-16','2','6','1','3'),
('9','2021-07-17','7','5','6','9'),
('10','2021-07-19','3','2','9','7')

--6a)
SELECT id_pracownika,nazwisko FROM ksiegowosc.pracownicy
--6b)
SELECT id_pracownika,kwota FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji WHERE kwota > 1000
--6c)
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji WHERE id_premii IS NULL AND kwota > 1200
--6d)
SELECT nazwisko,imie FROM ksiegowosc.pracownicy 
WHERE imie LIKE 'J%'
--6e)
SELECT nazwisko,imie FROM ksiegowosc.pracownicy 
WHERE imie LIKE '%a' AND nazwisko LIKE '%n%'
--6f)
SELECT imie,nazwisko,
CASE WHEN liczba_godzin>160 THEN liczba_godzin - 160
ELSE 0
END
AS nadgodziny
FROM ksiegowosc.pracownicy JOIN ksiegowosc.godziny ON pracownicy.id_pracownika=godziny.id_pracownika 
--6g)
SELECT imie,nazwisko FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika 
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji 
WHERE kwota > 1500 AND kwota < 3000
--6h)
SELECT imie,nazwisko FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika 
JOIN ksiegowosc.godziny ON godziny.id_godziny=wynagrodzenie.id_godziny 
WHERE id_premii=NULL AND liczba_godzin > 7
--6i)
SELECT pracownicy.id_pracownika,imie,nazwisko,kwota FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika 
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
ORDER BY kwota
--6j)
SELECT pracownicy.id_pracownika,imie,nazwisko,pensja.kwota,premia.kwota FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika 
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
JOIN ksiegowosc.premia ON wynagrodzenie.id_premii=premia.id_premii
ORDER BY pensja.kwota DESC,premia.kwota DESC
--6k)
SELECT COUNT(stanowisko) AS ilosc,stanowisko FROM ksiegowosc.pensja
GROUP BY stanowisko
--6l)
SELECT stanowisko,AVG(kwota) AS SREDNIA,MIN(kwota) AS minimum,MAX(kwota) AS maximum FROM ksiegowosc.pensja WHERE stanowisko='Gleboznawca'
GROUP BY stanowisko
--6m)
SELECT SUM(kwota) AS suma FROM ksiegowosc.pensja
--6f)
SELECT stanowisko, SUM(kwota) AS sumawyn FROM ksiegowosc.pensja
GROUP BY stanowisko
--6g) 
SELECT stanowisko,COUNT(wynagrodzenie.id_premii) FROM ksiegowosc.pensja 
JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji=wynagrodzenie.id_pensji 
JOIN ksiegowosc.premia ON wynagrodzenie.id_premii=premia.id_premii
GROUP BY stanowisko
--h)
ALTER TABLE ksiegowosc.godziny DROP CONSTRAINT fkid_pracownika;
ALTER TABLE ksiegowosc.wynagrodzenie DROP CONSTRAINT fkid_pracownika;
DELETE FROM ksiegowosc.pracownicy
USING ksiegowosc.pensja,ksiegowosc.wynagrodzenie
WHERE wynagrodzenie.id_pracownika=pracownicy.id_pracownika 
AND pensja.id_pensji=wynagrodzenie.id_pensji
AND pensja.kwota < 1200



