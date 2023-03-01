<#
 .Synopsis
 Gets the path of the running script

.Example
Get-ScriptPath
#>
function Get-ScriptPath()
{
    # If using PowerShell ISE
    if ($psISE)
    {
        $ScriptPath = Split-Path -Parent -Path $psISE.CurrentFile.FullPath
    }
    # If using PowerShell 3.0 or greater
    elseif($PSVersionTable.PSVersion.Major -gt 3)
    {
        $ScriptPath = $PSScriptRoot
    }
    # If using PowerShell 2.0 or lower
    else
    {
        $ScriptPath = split-path -parent $MyInvocation.MyCommand.Path
    }

    # If still not found
    # I found this can happen if running an exe created using PS2EXE module
    if(-not $ScriptPath) {
        $ScriptPath = [System.AppDomain]::CurrentDomain.BaseDirectory.TrimEnd('\')
    }

    # Return result
    return $ScriptPath
}


<#
 .Synopsis
 Encrypts a plain text password to a secure string and writes to password.txt. Useful to prevent plain text password from
 appearing on the screen, however, anyone can decrypt this password if they have the file.

 .Parameter vmName
  Plain Text Password

 .Parameter rgName
  Resource Group Name

 .Example
   ToggleVM -vmName "vmGeneral" -rgName "DefaultResourceGroup-EUS"
#>
function Write-PasswordFile {
    param([string]$pwPlainText)
    $pathRoot = Get-ScriptPath
    $newPassword | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pathRoot\password.txt -Verbose
}

