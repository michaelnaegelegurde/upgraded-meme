    #Microsoft-Udate Einstellungen
    Write-Host "Aktiviere Microsoft-Update..."
    New-Item -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Force | out-null
    New-Item -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Force | out-null
    New-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'AllowMUUpdateService' -value '1' -Force | out-null
    Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'AllowMUUpdateService' -value '1' -Force | out-null
    Write-Host "Erledigt..." -foregroundColor green