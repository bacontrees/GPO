if not exist "C:\Policies\" mkdir C:\Policies
bitsadmin /transfer printbrm https://download.canyoncs.com/printbrm.printerExport c:\Policies\printbrm.printerExport
%Windir%\System32\spool\tools\printbrm.exe -r -noACL -f c:\Policies\printbrm.printerExport -o force
