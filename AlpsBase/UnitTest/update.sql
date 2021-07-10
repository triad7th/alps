USE [PqReport]	

DROP TABLE IF EXISTS [test].[test]
SELECT * INTO [test].[test] FROM (
	SELECT 1 AS [Id], CAST('test1' AS NVARCHAR(MAX)) AS [Value] 
	UNION
	SELECT 2 AS [Id], CAST('test2' AS NVARCHAR(MAX)) AS [Value]
) a
GO

SELECT * FROM [test].[test]
UPDATE [test].[test] SET [Value] = 'NewTest2'
SELECT * FROM [test].[test]