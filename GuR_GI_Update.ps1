Write-Host "GuR Grundinstallations-Script-Updater 2.0" -ForegroundColor Green
$url_git = "https://static.gur.de/GIScripts/git.zip"
$output_git = "git.zip"
Import-Module BitsTransfer
Write-Host "Checking for Updates..."
If(!(test-path "$PSScriptRoot\$output_git")) {
    Start-BitsTransfer -Source $url_git -Destination $output_git | out-null
    Expand-Archive -LiteralPath git.zip -DestinationPath $PSScriptRoot\ -Force
    Set-ItemProperty $PSScriptRoot\git\ -Name Attributes -Value "Hidden"
}
Set-Location $PSScriptRoot\
If(!(test-path "$PSScriptRoot\upgraded-meme\")) {
    & "$PSScriptRoot\git\cmd\git.exe" clone https://github.com/marcusbierer/upgraded-meme.git
} else {
    Set-Location $PSScriptRoot\upgraded-meme\
    & "$PSScriptRoot\git\cmd\git.exe" fetch origin main
    & "$PSScriptRoot\git\cmd\git.exe" reset --hard
    & "$PSScriptRoot\git\cmd\git.exe" pull
}
Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList '-NoExit', '-File', """$PSScriptRoot\upgraded-meme\GuR_GI_Main.ps1""" -verb runAs
Write-Host "Done" -ForegroundColor Green -NoNewline