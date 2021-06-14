Write-Host "Starting Client Verison..."
If((test-path "$PSScriptRoot\GuR_GI_Update.ps1")) {
    Move-Item -Path $PSScriptRoot\GuR_GI_Update.ps1 -Destination ..\GuR_GI_Update.ps1 -Force | out-null
}
function checkForUpdates {
	Write-Host "Script auf Updates prüfen"
    & "$PSScriptRoot\git\cmd\git.exe" fetch origin main
    & "$PSScriptRoot\git\cmd\git.exe" reset --hard
    & "$PSScriptRoot\git\cmd\git.exe" pull
    If((test-path "$PSScriptRoot\GuR_GI_Update.ps1")) {
        Move-Item -Path $PSScriptRoot\GuR_GI_Update.ps1 -Destination ..\GuR_GI_Update.ps1 -Force | out-null
    }
    Write-Host "checkForUpdates done"
    Read-Host "unicode:"
}
checkForUpdates
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" -verb runAs
Write-Host "Done..." -foregroundColor green