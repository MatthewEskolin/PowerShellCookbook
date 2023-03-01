#Test File for Running Library Functions

#load modules
Remove-Module ToggleVM
Import-Module ".\Modules\ToggleVM"

#ToggleVM "vmGeneral" "DefaultResourceGroup-EUS"

#Calling Scratch Commandlet
& ".\Scratch.ps1" -FullPassThru
