. "$PSScriptRoot\Enums.ps1"

function Ansi($ForegroundColor, $BackgroundColor, $WhatIf, [switch]$Reset) {
    if ($Reset) { $ansi = "0" }
    else { 
        if ($Style) { $ansi += "$($Styles."$Style");"}
        if ($ForegroundColor) { $ansi += "$($ForegroundColors."$ForegroundColor");"}
        if ($BackgroundColor) { $ansi += "$($BackgroundColors."$BackgroundColor");"}
        if($ansi) { $ansi = $ansi.TrimEnd(';'); }
    }
    if ($WhatIf) {
        return "'e[$($ansi)m"
    } else {
        return "`e[$($ansi)m"
    }
}
function AnsiRecover($Line) {
    $matched = ($Line | Select-String "`e\[(.*?)m" -AllMatches).Matches
    if ($matched) {
        if ($matched[$matched.Length - 1].Groups[1]) {
            return $matched[$matched.Length - 1].Value
        }
    }
}