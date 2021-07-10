function Reset-AnsiString {
    [CmdletBinding()]
    param (        
        [Parameter(ValueFromPipeLine)]
        [string[]]$Item        
    )
    begin {
    }
    process {
        $Line = $Item | Out-String -NoNewLine
        $Line -replace "`e.*?m", ''
    }
    end {        
    }
}