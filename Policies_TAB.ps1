Import-Module BitsTransfer

#Transfer BitLocker Task
Start-BitsTransfer -Source https://raw.githubusercontent.com/bacontrees/GPO/refs/heads/main/BL_Enable_Store.ps1 -Destination C:\Policies\BL_Enable_Store.ps1

#Create Action to be run by task
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-ExecutionPolicy bypass -File C:\Policies\BL_Enable_Store.ps1'

#Create trigger for task
$trigger = New-ScheduledTaskTrigger -AtLogon

#Create task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "BitLocker" -User "NT AUTHORITY\SYSTEM"

#Unregister old task
Unregister-ScheduledTask -TaskName "BL_Enable-Backup" -Confirm:$false

#Transfer GPO Reg
Start-BitsTransfer -Source https://raw.githubusercontent.com/bacontrees/GPO/refs/heads/main/GPO/GPO_TAB.reg -Destination C:\Policies\GPO_TAB.reg
reg import C:\Policies\GPO_TAB.reg

New-Item -ItemType file -Path C:\Policies -Name "Policies Applied $(Get-Date -Format 'yyyyMMdd_HHmmss').log" -Force
