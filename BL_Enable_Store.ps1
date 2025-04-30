[cmdletbinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string] $OSDrive = $env:SystemDrive
    )
    try{
        $ErrorActionPreference = "stop"
        # Enable Bitlocker using TPM
        try {
            Enable-BitLocker -MountPoint $OSDrive -UsedSpaceOnly -TpmProtector -SkipHardwareTest -ErrorAction Stop
            Enable-BitLocker -MountPoint $OSDrive -UsedSpaceOnly -RecoveryPasswordProtector -SkipHardwareTest

        } catch {
            if ($_.Exception.Message -like "*This key protector cannot be added.*") {
                Write-Host "BitLocker is already enabled on drive $OSDrive. Skipping to the next step."

            } else {
                throw "Error while enabling BitLocker: $_"
            }
        }

        # Get recovery password ID
        $bitlockerVolume = Get-BitLockerVolume -MountPoint $OSDrive
        $numericalId = ($bitlockerVolume.KeyProtector | Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"}).KeyProtectorId

        # Backup the key for the numerical password protector to Azure AD
        BackupToAAD-BitLockerKeyProtector -MountPoint $OSDrive -KeyProtectorId "$numericalId"

        }
        catch {
        Write-Error "Error while setting up AAD Bitlocker, make sure that you are AAD joined and are running the cmdlet as an admin: $_"
    }