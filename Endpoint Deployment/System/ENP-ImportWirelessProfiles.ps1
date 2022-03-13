# Set Wireless Profiles
Write-Host "Checking if any wireless profiles are available..."
$TestDirectory = Get-ChildItem $Windows\WirelessProfiles | Measure-Object | Out-Null
func_sleep

if ($TestDirectory.count -eq 0) {
    write-host "There are no wireless profiles to import."
    func_sleep
}
else {
Write-Host "Wireless Profiles have been found and are loaded in..."
func_sleep

$Wlans = Get-ChildItem "$Windows\WirelessProfiles"
foreach ($Wlan in $Wlans) {
    netsh wlan add profile filename=$wlan user=all  | Out-Null
    Write-Host "$wlan has been added to your Wireless Profiles list."
    func_sleep
    }
}
