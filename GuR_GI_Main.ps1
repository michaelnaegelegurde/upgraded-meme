Write-Host "Starting Client Verison..."
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" -verb runAs
Write-Host "Done" -ForegroundColor Green -NoNewline;