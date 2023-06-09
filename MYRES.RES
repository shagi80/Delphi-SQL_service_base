        ��  ��                  �      ��
 ��     0         CREATE TABLE #TYPERES
(ID INT IDENTITY, TID INT, DESCR NVARCHAR(20),TCNT INT, TPCNT INT, PROCENT MONEY)

DECLARE @TOTCNT INT
SELECT @TOTCNT=COUNT(T1.ID) FROM [NOVA].[DBO].[NOVATEKPRODCODES] AS T1

DECLARE @TYPEID INT
DECLARE @TYPECNT INT
/*Объявляем курсор*/
DECLARE @CURSOR CURSOR
/*Заполняем курсор*/
SET @CURSOR  = CURSOR SCROLL
FOR
SELECT T1.[ID] FROM [NOVA].[dbo].[PRODUCTIONTYPES] AS T1
/*Открываем курсор*/
OPEN @CURSOR
/*Выбираем первую строку*/
FETCH NEXT FROM @CURSOR INTO @TYPEID
/*Выполняем в цикле перебор строк*/
WHILE @@FETCH_STATUS = 0 BEGIN
	SET @TYPECNT=0
	SELECT @TYPECNT=COUNT(T3.[CODE])
		FROM [NOVA].[DBO].[NOVATEKPRODCODES] AS T3 INNER JOIN [NOVA].[DBO].[PRODUCTIONTYPES] AS T2 ON T2.[ID]=@TYPEID
		WHERE (SUBSTRING(T3.[CODE],1,2) IN (SELECT T2.[IDFORCODES] FROM [NOVA].[DBO].[PRODUCTIONMODELS] AS T2 WHERE T2.[TYPE]=@TYPEID ))
		GROUP BY T2.[DESCR]    
	IF (@TYPECNT>0) INSERT #TYPERES VALUES (@TYPEID,'DSAF',@TOTCNT,@TYPECNT,@TYPECNT*100/@TOTCNT)
	/*Выбираем следующую строку*/
	FETCH NEXT FROM @CURSOR INTO @TYPEID
END
CLOSE @CURSOR

SELECT * FROM #TYPERES

DROP TABLE #TYPERES 