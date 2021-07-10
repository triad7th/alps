. "$PSScriptRoot\..\..\Private\Functions\Ansi\Enums.ps1"
. "$PSScriptRoot\..\..\Private\Functions\Ansi\Helpers.ps1"
function Select-AnsiString {
    [CmdletBinding()]
    param (        
        [string]$Pattern,
        [string]$ForegroundColor,
        [string]$BackgroundColor,
        [string]$Style,
        [switch]$Clear,
        [switch]$WhatIf,
        [Parameter(ValueFromPipeLine)]
        [string[]]$Item        
    )
    begin {
    }
    process {
        if ($Item) {
            $Line = $Item | Out-String -NoNewLine
            if ($Clear) {
                $AnsiLine = $Line -replace "`e.*?m", ''
            } else {
                $Selected = $Line | Select-String $Pattern -AllMatches
                $index, $AnsiLine = 0, ''
                foreach ($found in $Selected.Matches) {
                    if ($found.Index -gt 0) {
                        $AnsiLine += ($Line[$index..($found.Index - 1)] -join '')
                    }                
                    if ($ForegroundColor -or $BackgroundColor -or $Style) {
                        $AnsiRecover = AnsiRecover $AnsiLine
                        $AnsiLine += Ansi -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -WhatIf $WhatIf
                        $AnsiLine += $found.Value
                        $AnsiLine += Ansi -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -WhatIf $WhatIf -Reset
                        $ansiLine += $AnsiRecover
                    } else {
                        $AnsiLine += $found.Value
                    }                        
                    $index = $found.Index + $found.Length
                }
                if ($index -lt $Line.Length) {
                    $AnsiLine += ($Line[$index..($Line.Length - 1)] -join '')
                }            
            }        
            $AnsiLine
        }
    }
    end {        
    }
}