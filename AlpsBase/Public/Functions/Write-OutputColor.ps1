. "$PSScriptRoot\..\..\Private\Functions\Ansi\Enums.ps1"
. "$PSScriptRoot\..\..\Private\Functions\Ansi\Helpers.ps1"
function Write-OutputColor {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        [string[]]$Item,
        [string]$ForegroundColor,
        [string]$BackgroundColor,
        [switch]$WhatIf
    )
    begin {
    }
    process {
        if ($Item) {
            $Item = $Item | Out-String -NoNewLine
            $AnsiLine += Ansi -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -WhatIf $WhatIf
            $AnsiLine += $Item
            $AnsiLine += Ansi -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -WhatIf $WhatIf -Reset
            $AnsiLine
        }
    }
    end {        
    }
}