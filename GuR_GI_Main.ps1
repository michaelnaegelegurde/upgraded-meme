Write-Host "GuR Grundinstallations-Script" -ForegroundColor Green
$url_git = "https://static.gur.de/GIScripts/dvs.zip"
$output_git = "dvs.zip"
Import-Module BitsTransfer
Write-Host "Checking for Updates..."
Start-BitsTransfer -Source $url_git -Destination $output_git | out-null
Expand-Archive -LiteralPath dvs.zip -DestinationPath $PSScriptRoot\ -Force
#Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" -verb runAs
#Write-Host "Done" -ForegroundColor Green -NoNewline;