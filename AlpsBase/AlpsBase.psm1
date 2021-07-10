Write-Host "AlpsBase Powershell Module" -ForegroundColor Black -BackgroundColor Yellow -NoNewLine;
Write-Host -BackgroundColor Black
#region Global Variables
    Write-Host "Loading: `$PQCommon"
    $PQCommon = [PSCustomObject]@{
        Cfg = (Get-Content -Path "$PSScriptRoot\AlpsBase.json" | ConvertFrom-JSON)
    }
#endregion
foreach ($directory in @('Public')) {    
    Get-ChildItem -Path "$PSScriptRoot\$directory\*.ps1" -Recurse -File | ForEach-Object { 
        Write-Host "Loading: $directory\$($_.Name)" -ForegroundColor White -BackgroundColor Black -NoNewLine;
        Write-Host -BackgroundColor Black
        . $_.FullName 
    }
}

Export-ModuleMember -Variable PQCommon