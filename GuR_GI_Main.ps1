Write-Host "Starting Client Verison..."
Move-Item -Path $PSScriptRoot\GuR_GI_Update.ps1 -Destination ..\GuR_GI_Update.ps1 -Force | out-null
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" -verb runAs
Write-Host "Done..." -foregroundColor green