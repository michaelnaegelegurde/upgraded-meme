    #RDP Einstellungen
    Write-Host "Aktiviere RDP..."
    Set-Itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -value '0'
    Set-Itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'UserAuthentication' -value '0'
    Write-Host "Erledigt..." -foregroundColor green