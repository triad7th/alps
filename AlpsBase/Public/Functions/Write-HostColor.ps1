function Write-HostColor {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine, mandatory)]
        [Object]$Object,
        [switch]$NoNewLine,
        [string]$ForegroundColor = 'White',
        [string]$BackgroundColor = 'Blue'
    )
    begin {
        $Objects = @()
    }
    process {
        $Objects += $Object
    }
    end {
        Write-Host `
            -Object $Objects `
            -ForegroundColor $ForegroundColor `
            -BackgroundColor $BackgroundColor `
            -NoNewLine
        if ($NoNewLine) { Write-Host -BackgroundColor Black -NoNewLine }
        else { Write-Host -BackgroundColor Black }
    }
}