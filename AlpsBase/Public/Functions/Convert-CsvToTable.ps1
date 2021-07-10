function Convert-CsvToTable {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        [array]$Csv,
        [array]$Notin = ''
    )
    begin {
        [array]$Csvs = @()
    }
    process {
        $Csvs += $Csv
    }
    end {
        if($null -eq $Csv) {
            Write-Verbose "from clipboard"
            Get-Clipboard | ConvertFrom-Csv -Delimiter "`t" | ft -Property * | Out-String -Width 9064
        } else {
            Write-Verbose "from array"
            $Csvs | ConvertFrom-Csv -Delimiter "`t" | ft -Property * | Out-String -Width 9064
        }
    }
}