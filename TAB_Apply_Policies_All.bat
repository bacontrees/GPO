if not exist "C:\Policies\" mkdir C:\Policies
bitsadmin /transfer Policies https://raw.githubusercontent.com/bacontrees/GPO/refs/heads/main/Policies_TAB.ps1 C:\Policies\Policies_TAB.ps1
powershell.exe -ExecutionPolicy bypass -File C:\Policies\Policies_TAB.ps1

if not exist "C:\Policies\" mkdir C:\Policies
bitsadmin /transfer printbrm https://download.canyoncs.com/printbrm.printerExport c:\Policies\printbrm.printerExport
%Windir%\System32\spool\tools\printbrm.exe -r -noACL -f c:\Policies\printbrm.printerExport -o force
