Function Generate-Synopsis{
    param(
        $Synopsis,
        $Description,
        $Parameters,
        $Inputs,
        $Outputs,
        $Examples,
        $Link
    )
"<#
        .SYNOPSIS
        $Synopsis

        .DESCRIPTION
        $Description

        $($Parameters|ForEach-Object{".PARAMETER $($_[0])`n$($_[1])`n`n"})
        .INPUTS
        $Inputs

        .OUTPUTS
        $Outputs

        $($Examples|ForEach-Object{".EXAMPLE `n$($_[0])`n$($_[1])`n`n"})   
        .LINK
        $Link
    #>"
}

Function Parse-Clipboard {
    [CmdletBinding()]
    param (
        [Parameter(Position=0,Mandatory)]
        [regex]
        $Pattern,
        [Parameter(Position=1,ParameterSetName = 'Join')]
        [String]
        $Join,
        [Parameter(Position=1,ParameterSetName = 'AsObject')]
        [Switch]
        $AsObject
    )
    $Out = Get-Clipboard  |
        Out-String |
        ForEach-Object{
            [Regex]::Matches($_,$Pattern)
        }
    if($AsObject){
        $Out
    }elseif($Join){
        $Out.Value -join $Join|
            Set-Clipboard
    }else{
        $Out.Value|
            Set-Clipboard
    }
}

Export-ModuleMember -Function Generate-Synopsis
Export-ModuleMember -Function Parse-Clipboard