[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Switch]$FullPassThru
)

New-Module -Name TempModule -ScriptBlock {
        function Test-ModuleVerbose
        {
            [CmdletBinding(SupportsShouldProcess=$true)]
            param ()

            Write-Host "1: Module: verbose parameter is bound : $($PSCmdlet.MyInvocation.BoundParameters['Verbose'])"
            Write-Host "2: Module: verbose preference         : $VerbosePreference"

            # Write-Verbose will just work without any change
            Write-Verbose "Verbose"

            # Other commands need the $VerbosePreference passed in
            Set-Item -Path Env:\DEMONSTRATE_PASS_THRU `
                     -Value 'You can safely delete this variable' `
                     -Verbose:$VerbosePreference
        }

        function Test-ModulePreferencePassThru
        {
            [CmdletBinding(SupportsShouldProcess=$true)]
            param()

            Write-Debug   "DebugPreference: $DebugPreference"
            Write-Warning "WarningPreference: $WarningPreference"
            Write-Error   "ErrorActionPreference: $ErrorActionPreference"

            Set-Item -Path Env:\DEMONSTRATE_PASS_THRU `
                     -Value 'You can safely delete this variable' `
                     -Verbose:$VerbosePreference `
                     -WarningAction:$WarningPreference `
                     -ErrorAction:$ErrorActionPreference
        }
    } | Out-Null

function Test-Verbose
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()

    Write-Host ("Verbose preference: $VerbosePreference")
    Test-ModuleVerbose -Verbose:$VerbosePreference
}

function Test-PreferencePassThru
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()

    Test-ModulePreferencePassThru -Verbose:$VerbosePreference
}

try
{
    if ($FullPassThru -eq $false)
    {
        # just demonstrate -verbose pass-through
        Write-Host "verbose pass through"
        Test-Verbose
    }
    else
    {
        # most of the preferences can be explicitly passed-through, however:
        #
        #  -Debug  : $DebugPreference is automatically passed-through
        #            and -Debug forces $DebugPreference to 'Inquire'
        #  -WhatIf : automatically passed-through
        Write-Host "test modulepreferencepassthru" 
        Test-ModulePreferencePassThru -Verbose:$VerbosePreference `
                                        -WarningAction:$WarningPreference `
                                        -ErrorAction:$ErrorActionPreference | Out-Null
    }
}
finally
{
    # cleanup
    Remove-Item -Path Env:\DEMONSTRATE_PASS_THRU -Force | Out-Null
}