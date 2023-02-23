<#
 .Synopsis
 Toggles an AzureVM on and off

 .Parameter vmName
  Virtual Machine Name

 .Parameter rgName
  Resource Group Name

 .Example
   ToggleVM -vmName "vmGeneral" -rgName "DefaultResourceGroup-EUS"
#>
function ToggleVM {
    param(
        [string] $vmName,
        [string] $rgName
    )

    $VM_STATUS_ON = "VM running"
    $VM_STATUS_OFF = "VM deallocated"


    $VMstatus = (Get-AzVM -ResourceGroupName $RGName -Name $vmName -Status).Statuses #| out-null
    $PowerState = $VMstatus[1].DisplayStatus

    #"PowerState for $vmName is $PowerState"

    #if($PowerSt)
    if ($PowerState -eq $VM_STATUS_ON) {

        #Shutdown VM      
        "Shutdown Starting on VM"
        Stop-AzVM -ResourceGroupName $RGName -Name $vmName -Force -AsJob
    }
    elseif ($PowerState -eq $VM_STATUS_OFF) {
    
        #Start VM
        "VM Starting"
        Start-AzVM -ResourceGroupName $RGName -Name $vmName -AsJob    
    
    }
    else {
        Write-Output "NO CHANGE:VM is in an intermediate state!"
    }

        Write-Output "Script Done!"
    
}
Export-ModuleMember -Function ToggleVM