function Write-Process($Process, $Level) {
    [PSCustomObject]@{
        Id = $Process.Id
        ProcessName = $Process.Name
        Level = $Level
    }
}
function Show-Process($Process, $Level) {
    if ($Process.Parent) {
        if ($Level -eq 0) {
            Write-Process -Process $Process -Level "Current"
        } else {
            Write-Process -Process $Process -Level "Parent"
        }
    } else {
        if ($Level -eq 0) {
            Write-Process -Process $Process -Level "Current / Root"            
        } else {
            Write-Process -Process $Process -Level "Root"
        }
    }
}
function Get-ParentProcess {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeLine)]
        $TargetProcess = $pid,
        [int]$Level = 0,
        [switch]$Recurse
    )
    process {
        if ($TargetProcess -is [PSObject]) {
            if ($TargetProcess.PSObject.TypeNames[0] -eq 'System.Diagnostics.Process') {
                $TargetProcess = $TargetProcess.Id
            } else {
                throw "TargetProcess is invalid!"
            }
        }
        $current = Get-Process -Id $TargetProcess
        $parent = $current.Parent
        Show-Process -Process $current -Level $Level
        if ($parent) {
            if ($Recurse) {
                Get-ParentProcess -TargetProcess $parent.Id -Recurse -Level ($Level + 1)
            } else {
                Show-Process -Process $current.Parent
            }
        } else {  
            ""
            return
        }
    }
}
