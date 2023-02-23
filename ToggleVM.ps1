#
Connect-AzAccount

#Toggle Virtual Machine On/Off

#IF the machine is ON, turn it OFF
#ELSE if the machine is OFF, turn it ON


$vmName = "vmGeneral"
$RGName = "rgFitbit_API"    
$VM_STATUS_ON = "VM running"
$VM_STATUS_OFF = "VM deallocated"


$VMstatus = (Get-AzVM -ResourceGroupName $RGName -Name $vmName -Status).Statuses #| out-null
$PowerState = $VMstatus[1].DisplayStatus

"PowerState for $vmName is $PowerState"

#if($PowerSt)
if($PowerState -eq $VM_STATUS_ON){

    #Shutdown VM      
    "Shutdown Starting on VM"
    Stop-AzVM -ResourceGroupName $RGName -Name $vmName -Force -AsJob
}
elseif ($PowerState -eq $VM_STATUS_OFF) {
    
    #Start VM
    "VM Starting"
    Start-AzVM -ResourceGroupName $RGName -Name $vmName -AsJob    
    
}




