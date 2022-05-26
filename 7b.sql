--Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako argument wejœciowy liczbê n. 
--Generowanie ci¹gu Fibonacciego musi zostaæ zaimplementowane jako osobna funkcja, wywo³ywana przez procedurê.
CREATE FUNCTION dbo.FIBO
(@n INT)
RETURNS @ciag_fib TABLE(nr_fib INT)
AS
BEGIN
	DECLARE @n1 INT = 0, @n2 INT =1, @i INT=1, @temp INT 
	INSERT INTO @ciag_fib VALUES(@n1),(@n2)
	WHILE (@i <= @n-2)
	BEGIN 			
		INSERT INTO @ciag_fib VALUES(@n2+@n1)
		SET @temp = @n2
		SET @n2 = @n2 + @n1
		SET @n1 = @temp
		SET @i += 1
	END	
	RETURN
	END;
	

DROP FUNCTION dbo.FIBO


CREATE PROCEDURE dbo.show_fib
@nr INT
AS
BEGIN
Select * from dbo.FIBO (@nr) 
END;

DROP PROCEDURE dbo.show_fib

EXEC dbo.show_fib 15

--Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami.

CREATE TRIGGER upper_last_name
ON Person.Person
AFTER
INSERT
AS
BEGIN
UPDATE Person.Person
SET LastName= UPPER(LastName)
END


-- Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%.
CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
SELECT SalesTaxRate.TaxRate FROM Sales.SalesTaxRate
INNER JOIN inserted AS i ON SalesTaxRate.TaxRate = i.TaxRate
WHERE i.TaxRate > 1.3 * SalesTaxRate.TaxRate OR i.TaxRate < 0.7* SalesTaxRate.TaxRate
BEGIN
		RAISERROR('zbyt duza podwyzka',16,1)
ROLLBACK TRANSACTION
END


 SELECT * FROM Sales.SalesTaxRate