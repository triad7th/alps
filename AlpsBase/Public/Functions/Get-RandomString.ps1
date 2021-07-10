function Get-RandomString {
    [CmdletBinding()]
    param (
        $Length = 32,
        [int]$nCapitals = 10,
        [int]$nNumbers = 10,
        [int]$nSpChars = 0
    )
    end {
        function RandomString($nAlphabets, $nNumbers, $nSpChars)
        {
            # from
            # http://www.theservergeeks.com/how-to-powershell-password-generator/
        
            $alphabets = ('a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,' * 256).Trim(',')
            $numbers = (0..9 * 256)
            # $specialCharacters = ('~,!,@,#,$,%,^,&,*,(,),>,<,?,\,/,_,-,=,+,' * 256).Trim(',')
            $specialCharacters = ('!,@,#,$,%,^,&,_,-,=,+,' * 256).Trim(',')
        
            $array = @()
            $array += $alphabets.Split(',') | Get-Random -Count $nAlphabets
            0..($nCapitals - 1) | foreach {$array[$_] = $array[$_].ToUpper()}
            if($Numbers -gt 0){$array += $numbers | Get-Random -Count $nNumbers}
            if($nSpChars -gt 0){$array += $specialCharacters.Split(',') | Get-Random -Count $nSpChars}
            return (($array | Get-Random -Count $array.Count) -join "")    
        }
        RandomString `
        -nAlphabets ($Length - $nNumbers - $nSpChars) `
        -nNumbers $nNumbers `
        -nSpChars $nSpChars
    }    
}