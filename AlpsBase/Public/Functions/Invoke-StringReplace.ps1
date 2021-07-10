function Invoke-StringReplace {
    [CmdletBinding()]
    param (        
        [Parameter(ValueFromPipeLine=$true, Mandatory)]
        [Object[]]$Item,
        [string]$Pattern,
        [string]$Replacement,
        [switch]$Save,
        [switch]$WhatIf
    )
    begin {
        function FocusedString($Str, $FocusStr, $Width = 30) {
            $selected = $FocusStr ? ($str | Select-String ([regex]::escape($FocusStr))) : $null
            if ($selected) {
                $index = $selected.Matches[0].Index
                ($str[
                    [Math]::Max($index - $Width, 0)..
                    ($index + $FocusStr.Length + $Width - 1)
                ] -join '') -replace '\t', ' '
            } else {

            }
        }
    }
    process {        
        $isFile = (Test-Path $Item) ? (Get-Item $Item) -is [System.IO.FileInfo] : $false
        if ($isFile) { $Item = Get-Item $Item; $lines = Get-Content $Item } else { 
            $lines = @($Item -split "`r`n")
            if($lines.Length -gt 1) {
                $lines = $lines[0..($lines.Length - 2)]
            }
        }
        $objs = @()
        $replacedLines = foreach($line in $lines) {
            $selected = $Pattern ? ($line | Select-String ([regex]::escape($Pattern))) : $null
            $replacedLine = $line -replace [regex]::escape($Pattern), $Replacement            
            if ($selected) {
                $obj = [PSCustomObject]@{
                    Line = $lines.indexOf($line)
                    Index = $selected.Matches[0].Index
                }
                $obj | Add-Member -NotePropertyName "From" -NotePropertyValue "...$(FocusedString $line $Pattern)..."
                $obj | Add-Member -NotePropertyName "=>" -NotePropertyValue "=>"
                $obj | Add-Member -NotePropertyName "To" -NotePropertyValue "...$(FocusedString $replacedLine $Replacement)..."
                $objs += $obj
            }
            $replacedLine
        }
        if ($isFile) { Write-HostTitle $Item.Name }
        $objs | Format-Table | Out-String -Stream 
            | Select-AnsiString "$([regex]::escape($Pattern))" Blue Black
            | Select-AnsiString "$([regex]::escape($Replacement))" Yellow
            | Write-Host
        if ($Save -and $isFile) {
            if (!$WhatIf) {
                $replacedLines | Out-File $Item.FullName -Force -Verbose
            }
        } else {
            if (!$WhatIf) { $replacedLines }
        }
    }
}