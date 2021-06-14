Write-Host "GuR Grundinstallations-Script" -ForegroundColor Green
$url_dvs = "https://static.gur.de/GIScripts/dvs.zip"
$output_dvs = "dvs.zip"
Import-Module BitsTransfer
Write-Host "Checking for Updates..."
If(!(test-path "$PSScriptRoot\$output_dvs")) {
    Start-BitsTransfer -Source $url_dvs -Destination $output_dvs | out-null
    Expand-Archive -LiteralPath dvs.zip -DestinationPath $PSScriptRoot\ -Force
    Set-ItemProperty $PSScriptRoot\.dvs\ -Name Attributes -Value "Hidden"
}
Set-Location $PSScriptRoot\
& "$PSScriptRoot\.dvs\cmd\git.exe" clone https://github.com/marcusbierer/upgraded-meme.git
If((test-path "$PSScriptRoot\upgraded-meme")) {
    Move-Item .\upgraded-meme\* .\ | Out-Null
}
Write-Host "Jetzt kann es los gehen"
Read-Host ""
#Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\GuR_GI_Client.ps1""" -verb runAs
#Write-Host "Done" -ForegroundColor Green -NoNewline;