Write-Host "GuR Grundinstallations-Script" -ForegroundColor Green
$url_client = "https://static.gur.de/GIScripts/GuR_GI_Client.ps1"
$output_client = "$PSScriptRoot\GuR_GI_Client.ps1"
Import-Module BitsTransfer
Write-Host "Checking for Updates..."
Start-BitsTransfer -Source $url_client -Destination $output_client | out-null
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" –verb runAs
Write-Host "Done" -ForegroundColor Green -NoNewline;