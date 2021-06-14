Clear-Host
Set-Location -Path $PSScriptRoot
Start-BitsTransfer -Source https://static.gur.de/GIScripts/GuR_GI_Client.ps1 -Destination $PSScriptRoot\GuR_GI_Client.ps1 | out-null
Start-BitsTransfer -Source https://static.gur.de/GIScripts/GuR_GI_Main.ps1 -Destination $PSScriptRoot\GuR_GI_Main.ps1 | out-null
function checkForUpdates {
	Write-Host "Script auf Updates prüfen"
	If(!(test-path "$PSScriptRoot\filedepot\")) {New-Item -ItemType Directory -Force -Path $PSScriptRoot\filedepot\ | out-null}
	If(!(test-path "$PSScriptRoot\sources\")) {New-Item -ItemType Directory -Force -Path $PSScriptRoot\sources\ | out-null}
    If(!(test-path "$PSScriptRoot\sources\PSFiles")) {New-Item -ItemType Directory -Force -Path $PSScriptRoot\sources\PSFiles\ | out-null}
	If(!(test-path "$PSScriptRoot\custom\")) {New-Item -ItemType Directory -Force -Path $PSScriptRoot\custom\ | out-null}
    If(!(test-path "$PSScriptRoot\Script-Sammlung\")) {New-Item -ItemType Directory -Force -Path $PSScriptRoot\Script-Sammlung\ | out-null}
	If(!(test-path "$PSScriptRoot\custom_urls.txt")) {New-Item -Path $PSScriptRoot\ -Name "custom_urls.txt" -ItemType "file" | out-null}
	Start-BitsTransfer -Source https://static.gur.de/GIScripts/sources/version.txt -Destination $PSScriptRoot\sources\version_new.txt
	$version = Get-Content -Path $PSScriptRoot\sources\version.txt -ErrorAction SilentlyContinue
	$version_new = Get-Content -Path $PSScriptRoot\sources\version_new.txt -ErrorAction SilentlyContinue
	Remove-Item -Path $PSScriptRoot\sources\version_new.txt -Force
	if($version -ne $version_new) {
		Write-Host "Version installiert:	$version"
		Write-Host "Version verfügbar:	$version_new"
		Write-Host "Es ist eine Aktualisierung des Scripts verfügbar!" -foregroundColor Red
		$version_update = Read-Host "Soll die Aktualisierung durchgeführt werden (j/n)"
		switch ($version_update)
		{
			'j' {
			Start-BitsTransfer -Source https://static.gur.de/GIScripts/sources/filelist.txt -Destination $PSScriptRoot\sources\filelist.txt
			Start-BitsTransfer -Source https://static.gur.de/GIScripts/sources/release-notes.txt -Destination $PSScriptRoot\sources\release-notes.txt
			New-Item -Path $PSScriptRoot\sources\ -Name "version.txt" -ItemType "file" -value "$version_new" -Force | out-null
			Start-BitsTransfer -Source https://static.gur.de/GIScripts/GuR_GI_Client.ps1 -Destination $PSScriptRoot\GuR_GI_Client.ps1
			Start-BitsTransfer -Source https://static.gur.de/GIScripts/GuR_GI_Main.ps1 -Destination $PSScriptRoot\GuR_GI_Main.ps1
			Write-Host "Aktualisierung abgeschlossen. Bitte Starten Sie das GuR_GI_Main-Script neu!"
			Read-Host
			exit
			}
			'n' {}
		}
	} else { 
	Write-Host "Keine Aktualisierung verfügbar!" -ForegroundColor Green
	}
	Write-Host "Enter zum fortfahren"
	Read-Host
}
function cleanupFiles {
    Write-Host "Fortfahren? Alle Setups (auch Custom-Setups!) werden entfernt und neu heruntergeladen! (j/n)" -foregroundColor red
    $gieingabe = Read-Host "(j/n)"
    Clear-Host
    switch ($gieingabe)
        {
            'j' {
	            Remove-Item $PSScriptRoot\custom\ -Recurse -Force
                Remove-Item $PSScriptRoot\filedepot\ -Recurse -Force
                Remove-Item $PSScriptRoot\Script-Sammlung\ -Recurse -Force
                Remove-Item $PSScriptRoot\SIW-Files\ -Recurse -Force
                Remove-Item $PSScriptRoot\sources\ -Recurse -Force
                Write-Host "Erledigt..." -foregroundColor green
                checkForUpdates
            }
        }
}
function updateFiles {
    Write-Host "Dateien aktualisieren (alte Setups bleiben bestehen!)"
	Start-BitsTransfer -Source https://static.gur.de/GIScripts/filedepot/wget.exe -Destination $PSScriptRoot\filedepot\wget.exe
    Set-Location -Path $PSScriptRoot\filedepot\
    & "$PSScriptRoot\filedepot\wget.exe" -nc --restrict-file-names=nocontrol --content-disposition -i $PSScriptRoot\sources\filelist.txt
	Set-Location -Path $PSScriptRoot\custom\
	& "$PSScriptRoot\filedepot\wget.exe" -nc --restrict-file-names=nocontrol --content-disposition -i $PSScriptRoot\custom_urls.txt
    Set-Location -Path $PSScriptRoot\Script-Sammlung\
	& "$PSScriptRoot\filedepot\wget.exe" -r --ftp-user=f012578b --ftp-password=Nrk664C5tgZs56Ho -nH --no-glob ftp://w00dcf29.kasserver.com
    Set-Location -Path $PSScriptRoot\sources\PSFiles\
	& "$PSScriptRoot\filedepot\wget.exe" --recursive --no-parent -nd -R "index.html*" -N https://static.gur.de/GIScripts/sources/PSFiles/
    Get-ChildItem -Filter *index* | Remove-Item

	Write-Host "Erledigt..." -foregroundColor green
	Write-Host "Enter zum fortfahren"
	Read-Host
}


If(!(test-path "$PSScriptRoot\sources\version.txt")) {checkForUpdates}
else {
checkForUpdates

$version = Get-Content -Path $PSScriptRoot\sources\version.txt
$host.ui.RawUI.WindowTitle = "GuR Grundinstallations-Script Clients $version"
$n=1
Import-Module BitsTransfer
while ($n -gt 0){
function GuRGIMenue
{
    Clear-Host
    If(!(test-path "$PSScriptRoot\filedepot\wget.exe")) {
    Write-Host "!ACHTUNG! !ACHTUNG! !ACHTUNG! !ACHTUNG!" -ForegroundColor Red
    Write-Host "Es wurden noch keine Installations-Dateien heruntergeladen!" -ForegroundColor Red
    Write-Host "Bitte Punkt 99 ausführen!" -ForegroundColor Red
    }
	Write-Host "GuR Grundinstallations-Script Clients $version" -ForegroundColor Green 
	Write-Host "================================"
    Write-Host "1: Standard-Installation"
	Write-Host "   7-Zip, Firefox, Adobe Reader"
	Write-Host 
	Write-Host "2: Werkzeuge kopieren"
	Write-Host "   Copy TeamViewer, AnyDesk"
	Write-Host 
	Write-Host "3: Reg-Keys einspielen"
	Write-Host "   Microsoft-Update aktivieren, RDP aktivieren, Disable Standby"
	Write-Host 
	Write-Host "4: SIW-Datei erzeugen"
	Write-Host "   legt im GI-Script Ordner SIW die XML-Files ab"
	Write-Host 
	Write-Host "5: Vorinstallierte APPs entfernen"
	Write-Host
	Write-Host "6: Office entfernen"
	Write-Host
	Write-Host	
	Write-Host "96: Versionshistorie"
	Write-Host 
	Write-Host "97: Script auf Updates prüfen"
	Write-Host
	Write-Host "98: Verzeichnisse bereinigen"
	Write-Host 
	Write-Host "99: Dateien aktualisieren (alte Setups bleiben bestehen!)"
	Write-Host
	Write-Host
	Write-Host "Q: Programm beenden"
}
GuRGIMenue

Write-Host
Write-Host "================================"
$gieingabe = Read-Host "Bitte treffen Sie eine Auswahl"
Clear-Host
switch ($gieingabe)
    {
        '1' {
    Clear-Host
    Write-Host "Standard-Installation"
    Write-Host "Installiere Firefox..."
    Set-Location -Path $PSScriptRoot\filedepot\
    $firefox_version  = Get-ChildItem -Filter *Firefox*.exe | Select-Object -last 1 | Get-ChildItem -Name
    & "$PSScriptRoot\filedepot\$firefox_version" /S -Wait
    Start-Sleep -s 10
    Write-Host "Firefox Installation abgeschlossen." -foregroundColor green
    
    Write-Host "Installiere 7-Zip..."
    & "$PSScriptRoot\filedepot\7z1900-x64.exe" /S -Wait
    Start-Sleep -s 3
    Write-Host "7-Zip Installation abgeschlossen." -foregroundColor green
    
    Write-Host "Installiere Adobe Reader..."
    & "$PSScriptRoot\filedepot\AcroRdrDC2100120135_de_DE.exe" /sPB -Wait
    Start-Sleep -s 10
    Write-Host "Adobe Reader Installation abgeschlossen." -foregroundColor green

    Write-Host "Enter zum fortfahren"
	Read-Host
	Clear-Host
   }
  '2' {
    Write-Host "Werkzeuge kopieren"
		If(!(test-path "C:\GuR\"))
		{
      		New-Item -ItemType Directory -Force -Path "C:\GuR\" | out-null
		}
		Copy-Item "$PSScriptRoot\filedepot\teamviewer_quicksupport.exe" -Destination "C:\GuR\teamviewer.exe"
		Copy-Item "$PSScriptRoot\filedepot\AnyDesk.exe" -Destination "C:\GuR\anydesk.exe"

        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\GuR AnyDesk.lnk")
        $Shortcut.TargetPath = "C:\GuR\anydesk.exe"
        $Shortcut.Save()

        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\GuR TeamViewer.lnk")
        $Shortcut.TargetPath = "C:\GuR\teamviewer.exe"
        $Shortcut.Save()

        Write-Host "Erledigt..." -foregroundColor green
		Read-Host "Enter zum Fortfahren"
		Clear-Host
   }
  '3' {
    Write-Host "Reg-Keys einspielen"
    #Microsoft-Udate Einstellungen
    &"$PSScriptRoot\sources\PSFiles\reg.msupdate.ps1"
    
    #RDP Einstellungen
    &"$PSScriptRoot\sources\PSFiles\reg.rdpconfig.ps1"

    #Standby Einstellungen
    &"$PSScriptRoot\sources\PSFiles\reg.standby.ps1"

    Read-Host "Enter zum Fortfahren"
	Clear-Host
   }
  '4' {
    Write-Host "SIW-Datei erzeugen"
    If(!(test-path "$PSScriptRoot\SIW-Files\")) {
        New-Item -ItemType Directory -Force -Path $PSScriptRoot\SIW-Files\ | out-null
        }
        If(!(test-path "$PSScriptRoot\SIW-Files\SIW\")) {
        Expand-Archive -LiteralPath $PSScriptRoot\filedepot\SIWPortable.zip -DestinationPath $PSScriptRoot\SIW-Files\SIW\
        }
    Start-Sleep -s 10
    Set-Location $PSScriptRoot\SIW-Files\
    $pcname = hostname
    $date = get-date -Format yyyymmddHHmm
    $siwfile = $date + '_' + $pcname
    & "$PSScriptRoot\SIW-Files\SIW\siw.exe" /log:xml[=$siwfile /silent
    Write-Host "Erledigt..." -foregroundColor green
    Write-Host "Bitte beachten, dass die Erstellung der SIW-Datei im Hintergrund mehrere Minuten in Anspruch nehmen kann!" -foregroundColor red
    Read-Host "Enter zum Fortfahren"
   }
  '5' {
    Write-Host "Vorinstallierte APPs entfernen"
    #Remove Perinstalled Apps
    &"$PSScriptRoot\sources\PSFiles\del.apps.ps1"
    Read-Host "Enter zum Fortfahren"
	Clear-Host
   }
  '6' {
    Write-Host "Office entfernen"
    #Remove Office
#	Set-Location -Path $PSScriptRoot\filedepot\
    & "$PSScriptRoot\filedepot\ODT.exe" /configure "$PSScriptRoot\sources\PSFiles\del.office.xml"
    Read-Host "Enter zum Fortfahren"
	Clear-Host
   }
  '96' {
    Write-Host "Versionshistorie"
    Get-Content -Path $PSScriptRoot\sources\release-notes.txt
	Read-Host
	Clear-Host
   }
  '97' {
    checkForUpdates
	Clear-Host
   }
  '98' {
    cleanupFiles
	Clear-Host
   }
  '99' {
	updateFiles
	Clear-Host
   }
  'q' {
    exit
   }
  default {
     #Add CODE witch is run if the user enters a wrong number
     #exit
    }
    }

}


}