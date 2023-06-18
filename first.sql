DECLARE @date date, @i INT, @rand Int 
SET @i = 1;
SET @date = getdate();
SET @rand = 1;
WHILE @i <= 100
    BEGIN
        SET @rand =  RAND()*(8-2)+2;
        SET @date = dateadd(d, @rand,cast(@date as date))
        SET @i = @i + 1
        PRINT @date
    END;
 
