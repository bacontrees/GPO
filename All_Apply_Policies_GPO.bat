if not exist "C:\Policies\" mkdir C:\Policies
bitsadmin /transfer Policies https://raw.githubusercontent.com/bacontrees/GPO/refs/heads/main/Policies.ps1 C:\Policies\Policies.ps1
powershell.exe -ExecutionPolicy bypass -File C:\Policies\Policies.ps1
