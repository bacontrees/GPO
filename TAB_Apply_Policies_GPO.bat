if not exist "C:\Policies\" mkdir C:\Policies
bitsadmin /transfer Policies https://raw.githubusercontent.com/bacontrees/GPO/refs/heads/main/Policies_TAB.ps1 C:\Policies\Policies_TAB.ps1
powershell.exe -ExecutionPolicy bypass -File C:\Policies\Policies_TAB.ps1
