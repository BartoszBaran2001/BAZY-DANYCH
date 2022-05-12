--1a)
UPDATE  ksiegowosc.pracownicy  
SET  telefon='(+48)'+telefon 
WHERE  ksiegowosc.pracownicy.telefon IS NOT NULL; 

SELECT * FROM ksiegowosc.pracownicy;

--1b)
UPDATE ksiegowosc.pracownicy  
SET telefon = REPLACE(telefon, ' ', '-')
WHERE  ksiegowosc.pracownicy.telefon IS NOT NULL; 

SELECT * FROM ksiegowosc.pracownicy;

--1c) 
SELECT TOP 1 UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, UPPER(telefon) AS telefon
FROM ksiegowosc.pracownicy
ORDER BY len(nazwisko) DESC;

--1d)
SELECT wynagrodzenie.id_pracownika, imie, nazwisko, kwota AS pensja, HASHBYTES('MD5', CONCAT(wynagrodzenie.id_pracownika, '-', imie, '-', nazwisko, '-', kwota)) AS MD5
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji;

--1f)
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.kwota AS pensja, ksiegowosc.premia.kwota AS premia
FROM ksiegowosc.pracownicy
LEFT OUTER JOIN ksiegowosc.wynagrodzenie
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT OUTER JOIN ksiegowosc.pensja
ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT OUTER JOIN ksiegowosc.premia
ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii;

--1g)
SELECT CONCAT('Pracownik ', imie, ' ', nazwisko, ' w dniu ', wynagrodzenie.data, ' otrzyma³ pensjê ca³kowit¹ na kwotê ',
(pensja.kwota+premia.kwota+((liczba_godzin*20-160)*20)), ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pensja.kwota, ' z³, premia: ',
premia.kwota, ' z³, nadgodziny: ', ((liczba_godzin*20-160)*20)) AS komunikat
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny;