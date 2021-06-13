Write-Host "GuR Grundinstallations-Script" -ForegroundColor Green
If(!(test-path "$PSScriptRoot\GuR_GI_Client.ps1"))
	{
    Import-Module BitsTransfer
    Write-Host "Checking for Updates..."
    Start-BitsTransfer -Source https://static.gur.de/GIScripts/GuR_GI_Client.ps1 -Destination $PSScriptRoot\GuR_GI_Client.ps1
    }
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" –verb runAs
Write-Host "Done" -ForegroundColor Green -NoNewline;
Start-Sleep -s 2