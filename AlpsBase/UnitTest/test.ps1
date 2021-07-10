. "$PSScriptRoot\enter.ps1"

Write-OutputTitle "Test: Write-OutputColor" -NewLine
Write-OutputColor "asdadaadsa"
Write-OutputColor "asdadaadsa" -BackgroundColor Red
Write-OutputColor "asdadaadsa"
Write-OutputColor "asdadaadsa"
Write-OutputColor "asdadaadsaasdsadasd" -BackgroundColor DarkGray
Write-OutputColor "asdadaadsa"
Write-OutputColor "asdadaadsa"

Write-OutputTitle "Test: Get-Timpstamp" -NewLine
(Get-Date), (sleep 1),  (Get-Date) | Get-Timestamp

Write-OutputTitle "Test: Invoke-StringReplace" -NewLine -Large
ls *.sql | Invoke-StringReplace -Pattern '[test].[Transactions_ProdTest_042821]' -Replacement '[test].[Transactions_Reference]' -WhatIf

Write-OutputTitle "Test: Select-AnsiString" -NewLine
"boi boi my precious greatboiyeah" | Select-AnsiString greatboiyeah Red -Style Bold | Select-AnsiString boi Blue -Style Inverted 