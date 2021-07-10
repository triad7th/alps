function Convert-CsvToColumns {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        [array]$Csv,
        [array]$Notin = ''
    )
    begin {
        [bool]$IsFirstTime = $true        
    }
    process {
        if($IsFirstTime) {
            $IsFirstTime = $false
            if($null -eq $Csv) {
                Write-Verbose "from clipboard"                
                "[$(((Get-Clipboard)[0] -Split "`t" | Where-Object {$_ -notin $Notin}) -join "], [")]"
            } else {
                Write-Verbose "from array"
                "[$(($Csv -Split "`t" | Where-Object {$_ -notin $Notin}) -join "], [")]"
            }
        }
    }
}