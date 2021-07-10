USE [PqReport]	

--DROP TABLE [test].[Transactions_Prod]
--SELECT * INTO [test].[Transactions_Prod] FROM [PayQWick.GenX2.Prod.States].[fa].[Transactions]
--GO

DECLARE @lastTrxDate DATETIME = '4-5-2021'--(SELECT MAX([Time]) FROM [test].[Transactions_ProdTest_042821])
SELECT
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([Amount], [Time], [Type], [SubType], [Status], [Id], [FromAccountId], [ToAccountId], [FromExternalAccountId], [ToExternalAccountId])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([Amount], [Time], [Type], [SubType], [Status], [Id], [FromAccountId], [ToAccountId], [FromExternalAccountId], [ToExternalAccountId])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [BasicCheck],
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([CreatedDate])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([CreatedDate])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [CreatedDateCheck],
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([LiabilityDate])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([LiabilityDate])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [LiabilityDate],
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([ApprovalDueDate])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([ApprovalDueDate])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [ApprovalDueDate],
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([ApprovalDate])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([ApprovalDate])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [ApprovalDate],
	CASE WHEN (SELECT CHECKSUM_AGG(CHECKSUM([BankDate])) FROM [test].[Transactions_ProdTest_042821] WHERE [Time] <= @lastTrxDate)
	= (SELECT CHECKSUM_AGG(CHECKSUM([BankDate])) FROM [test].[Transactions_Prod] WHERE [Time] <= @lastTrxDate)
	THEN 'OK' ELSE 'ABC' END AS [BankDate]

SELECT tx1.[LiabilityDate] AS [TxLiabDate], tx2.[LiabilityDate] AS [RefLiabDate], tx1.* FROM [test].[Transactions_Prod] tx1 
INNER JOIN [test].[Transactions_ProdTest_042821] tx2 ON tx1.[Id] = tx2.[Id]
WHERE
	tx1.[Time] <= @lastTrxDate AND
	NOT (ISNULL(tx1.[LiabilityDate], 0) = ISNULL(tx2.[LiabilityDate], 0))

SELECT tx1.[ApprovalDate] AS [TxApvDate], tx2.[ApprovalDate] AS [RefApvDate], tx1.* FROM [test].[Transactions_Prod] tx1 
INNER JOIN [test].[Transactions_ProdTest_042821] tx2 ON tx1.[Id] = tx2.[Id]
WHERE
	tx1.[Time] <= @lastTrxDate AND
	NOT (ISNULL(tx1.[ApprovalDate], 0) = ISNULL(tx2.[ApprovalDate], 0))

SELECT tx1.[BankDate] AS [TxBankDate], tx2.[BankDate] AS [RefBankDate], tx1.* FROM [test].[Transactions_Prod] tx1 
INNER JOIN [test].[Transactions_ProdTest_042821] tx2 ON tx1.[Id] = tx2.[Id]
WHERE
	tx1.[Time] <= @lastTrxDate AND
	NOT (ISNULL(tx1.[BankDate], 0) = ISNULL(tx2.[BankDate], 0))
