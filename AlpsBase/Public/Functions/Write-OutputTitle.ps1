function Write-OutputTitle {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        [string]$String,
        [switch]$NewLine,
        [switch]$Large,
        [switch]$Medium
    )
    process {
        if ($NewLine) {
            Write-Output ""
        }
        if ($Large) {            
            $Body = "│  $String  │"
            $Blank = "│  $(' ' * $String.Length)  │"
            $Top = "┌──$('─' * $String.Length)──┐"
            $Bottom = "└──$('─' * $String.Length)──┘"
            Write-Output $Top
            Write-Output $Blank
            Write-Output $Body
            Write-Output $Blank
            Write-Output $Bottom
        } elseif ($Medium) {
            $Body = "   $String   "
            $Bottom = "───$('─' * $String.Length)───"
            Write-Output $Body
            Write-Output $Bottom
        } else {
            $Body = "$String"
            $Bottom = "$('-' * $String.Length)"
            Write-Output $Body
            Write-Output $Bottom
        }
    }
}
