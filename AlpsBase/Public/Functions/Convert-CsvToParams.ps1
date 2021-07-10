function Convert-CsvToParams {
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
            "'$((Get-Clipboard) -join "', '")'".TrimEnd(" '").TrimEnd(",")
        } else {
            Write-Verbose "from array"
            "'$(($Csvs) -join "', '")'".TrimEnd(" '").TrimEnd(",")
        }
    }
}