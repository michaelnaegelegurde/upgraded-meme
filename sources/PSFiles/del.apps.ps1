#Remove Apps
Write-Host "Entferne Vorinstallierte APPs..."
Write-Host
# Create array to hold list of apps to remove
$appname = @(
"*Microsoft.Desktop.Access*"
"*Microsoft.Desktop.Outlook*"
"*Microsoft.Desktop.Word*"
"*Microsoft.Desktop.PowerPoint*"
"*Microsoft.Desktop.Publisher*"
"*Microsoft.MicrosoftOfficeHub*"
"*Microsoft.Office.OneNote*"
"*Microsoft.Office.Sway*"
"*Office.Desktop*"
"Microsoft.ZuneMusic"
"Microsoft.ZuneVideo"
"Microsoft.MicrosoftSolitaireCollection"
"king.com.FarmHeroesSaga"
"SpotifyAB.SpotifyMusic"
"king.com.CandyCrushFriends"
"XINGAG.XING"
"Microsoft.BingNews"
"king.com.CandyCrushSaga"
"A278AB0D.DisneyMagicKingdoms"
"Microsoft.BingSports"
"Microsoft.BingFinance"
"A278AB0D.MarchofEmpires"
"Amazon.com.Amazon"
"PricelinePartnerNetwork.Booking.comEMEABigsavingso"
"4DF9E0F8.Netflix"
"9E2F88E3.Twitter"
)
# Remove apps from current user
ForEach($app in $appname){
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue | out-null
}
# Remove apps from all users - may need to reboot after running above and run this again
ForEach($app in $appname){
    Get-AppxPackage -Allusers -Name $app | Remove-AppxPackage -Allusers -ErrorAction SilentlyContinue | out-null
}
# Remove apps from provisioned apps list so they don't reinstall on new users
ForEach($app in $appname){
    Get-AppxProvisionedPackage -Online | where {$_.PackageName -like $app} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | out-null
}
Write-Host "Erledigt..." -foregroundColor green