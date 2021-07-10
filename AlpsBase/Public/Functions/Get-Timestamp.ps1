function Get-Timestamp {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        [DateTime]$DateTime
    )
    process {
        if ($null -eq $DateTime) {$DateTime = Get-Date}
        $DateTime.ToString('yyyyMMdd_HHmmss_fff')
    }
}
