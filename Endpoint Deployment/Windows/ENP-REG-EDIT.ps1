

#Disable Search Bar
Write-Host "Disable Search Bar..."
New-Itemproperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -name "SearchboxTaskbarMode" -value "0" -PropertyType "DWord"
Start-Sleep -s 5

#Set Explorer to This PC
Write-Host "Set Explorer to This PC..."
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "LaunchTo" -value "1" -PropertyType "DWord" 
Start-Sleep -s 5

#Disable Hiberboot
Write-Host "Disable HiberBoot..."
Regedit "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" "HiberbootEnabled" "DWord" "0"
Start-Sleep -s 5

#Enable file type extension
Write-Host "Enable File Type extensions..."
Regedit "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" "DWord" "0" 
Start-Sleep -s 5

# Disable Telemetry
Write-Host "Disable Telemetry..."
Regedit "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" "DWord" "0"
Start-Sleep -s 5

# Disable Bing Search in Start Menu
Write-Host "Disable Bing Search..."
Regedit "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" "DWord" "0"
Start-Sleep -s 5

# Disable Location Tracking
Write-Host "Disable location tracking..."
Regedit "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" "SensorPermissionState" "DWord" "0"
Regedit "HKLM:\System\CurrentControlSet\Services\lfsvc\Service\Configuration" "Status" "DWord" "0"
Start-Sleep -s 5

# Disable Advertising ID
Write-Host "Disable Advertising ID's"
Regedit "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" "DWord" "0"
Start-Sleep -s 5
