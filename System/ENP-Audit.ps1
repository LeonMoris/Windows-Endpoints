#-------------------------------------------------------------------------------------------------------------------------------------------------#
#          _             _                _            _            _   _         _                 _          _          _             _         #
#         / /\          /\_\             /\ \         /\ \         /\_\/\_\ _    / /\              /\ \       /\ \       /\ \     _    /\ \       #
#        / /  \        / / /         _   \_\ \       /  \ \       / / / / //\_\ / /  \             \_\ \      \ \ \     /  \ \   /\_\ /  \ \      #
#       / / /\ \       \ \ \__      /\_\ /\__ \     / /\ \ \     /\ \/ \ \/ / // / /\ \            /\__ \     /\ \_\   / /\ \ \_/ / // /\ \_\     #
#      / / /\ \ \       \ \___\    / / // /_ \ \   / / /\ \ \   /  \____\__/ // / /\ \ \          / /_ \ \   / /\/_/  / / /\ \___/ // / /\/_/     #
#     / / /  \ \ \       \__  /   / / // / /\ \ \ / / /  \ \_\ / /\/________// / /  \ \ \        / / /\ \ \ / / /    / / /  \/____// / / ______   #
#    / / /___/ /\ \      / / /   / / // / /  \/_// / /   / / // / /\/_// / // / /___/ /\ \      / / /  \/_// / /    / / /    / / // / / /\_____\  #
#   / / /_____/ /\ \    / / /   / / // / /      / / /   / / // / /    / / // / /_____/ /\ \    / / /      / / /    / / /    / / // / /  \/____ /  #
#  / /_________/\ \ \  / / /___/ / // / /      / / /___/ / // / /    / / // /_________/\ \ \  / / /   ___/ / /__  / / /    / / // / /_____/ / /   #
# / / /_       __\ \_\/ / /____\/ //_/ /      / / /____\/ / \/_/    / / // / /_       __\ \_\/_/ /   /\__\/_/___\/ / /    / / // / /______\/ /    #
# \_\___\     /____/_/\/_________/ \_\/       \/_________/          \/_/ \_\___\     /____/_/\_\/    \/_________/\/_/     \/_/ \/___________/     #
#                            _              _        _            _       _                _        _    _        _                               #
#                           / /\      _    /\ \     /\ \         / /\    / /\             /\ \     /\ \ /\ \     /\_\                             #
#                          / / /    / /\   \ \ \    \_\ \       / / /   / / /             \ \ \   /  \ \\ \ \   / / /                             #
#                         / / /    / / /   /\ \_\   /\__ \     / /_/   / / /              /\ \_\ / /\ \ \\ \ \_/ / /                              #
#                        / / /_   / / /   / /\/_/  / /_ \ \   / /\ \__/ / /              / /\/_// / /\ \ \\ \___/ /                               #
#                       / /_//_/\/ / /   / / /    / / /\ \ \ / /\ \___\/ /      _       / / /  / / /  \ \_\\ \ \_/                                #
#                      / _______/\/ /   / / /    / / /  \/_// / /\/___/ /      /\ \    / / /  / / /   / / / \ \ \                                 #
#                     / /  \____\  /   / / /    / / /      / / /   / / /       \ \_\  / / /  / / /   / / /   \ \ \                                #
#                    /_/ /\ \ /\ \/___/ / /__  / / /      / / /   / / /        / / /_/ / /  / / /___/ / /     \ \ \                               #
#                    \_\//_/ /_/ //\__\/_/___\/_/ /      / / /   / / /        / / /__\/ /  / / /____\/ /       \ \_\                              #
#                        \_\/\_\/ \/_________/\_\/       \/_/    \/_/         \/_______/   \/_________/         \/_/                              #
#                                                                                                                                                 #
#-------------------------------------------------------------------------------------------------------------------------------------------------#
# Disclaimer:                                                                                                                                     #
#                                                                                                                                                 #
# This script comes with no guarantees. The cmdlets in this script functioned as is on the moment of creating the script.                         #
# It is possible that during the lifecycle of the product this script is intended for, updates were performed to the systems and the script       #
# might not, or might to some extent, no longer function.                                                                                         #
#                                                                                                                                                 #
# Therefor, I would suggest running the script in a test environment first, cmdlet per cmdlet, before effectively running it in production        #
# environments.                                                                                                                                   #
#                                                                                                                                                 #
# Created by Leon Moris                                                                                                                           #
# Website: www.switchtojoy.be                                                                                                                     #
# Github: https://github.com/Joy-Leon                                                                                                             #
#-------------------------------------------------------------------------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------------------------------------------------------------------------#
# Declared functions.
function func_logging {   
    param ($String) 
    func_writeok $string
    Start-Sleep -Seconds 3 
    return "[{0:dd/MM/yy} {0:HH:mm:ss}] $String" -f (Get-Date)  | Out-File $logfile -append
}
function func_writeok {
    param ($string)
    write-host ""
    write-host $string -f green
}
function func_writenok {
    param ($string)
    write-host ""
    write-host $string -f red
}

function func_directory {
    param($Path)
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | out-null
    }
}

#-------------------------------------------------------------------------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------------------------------------------------------------------------#
# Declared variables.
$Root = "C:\Joy"
func_directory $Root
(get-item $Root).Attributes += 'Hidden'

$logfile = "$Root\logfile.txt"
if (Test-Path $logfile) {
    if (Test-Path "$logfile.old") {
        Remove-Item "$logfile.old"
    }
    move-item $logfile -destination "$logfile.old"
}
new-item $logfile | func_logging "A logfile has been created at $logfile"

$Hostname = hostname
func_directory $root\$hostname
$Audit = "$hostname\Audit"
func_directory $Audit

$Disks = "$Audit\Disks.csv"
$System = "$Audit\System.csv"
$WLANprofiles = "$Audit\WLANProfiles.csv"
$WlanProfileInfo = "$Audit\WirelessProfiles"
$Appinfo = "$Audit\Applications.csv"
$Users = "$Audit\Users.csv"
$Edge = "$Audit\EdgeProfile"
$Chrome = "$Audit\GoogleChromeProfile"
$Firefox = "$Audit\FirefoxProfile"
$AVGSecureBrowser = "$Audit\AVGSecureProfile"
#-------------------------------------------------------------------------------------------------------------------------------------------------#

# Auditing disk information
Get-Disk | out-file $Disks
Get-Partition | select-object PartitionNumber, Driveletter, size, type | out-file $Disks -append
Get-Volume | out-file $Disks -append
func_logging "The disk information has been stored at $root\$disks"

# Auditing system information
get-computerinfo | select-object BiosBIOSVersion, BiosFirmwareType, BiosManufacturer, BiosSeralNumber, CsDNSHostname, CsDomain, CsManufacturer, CsModel, CsProcessors, CsSystemFamily, CsPhyicallyInstalledMemory, CsUserName, OsName, OSVersion, OsBuildNumber, OsLocale, OSInstallDate, OsArchitecture, OSLanguage | out-file $System
func_logging "The system information has been stored at $root\$System"

# Auditing network information
netsh wlan show profiles | Out-File $Wlanprofiles
Get-NetAdapter | out-file $System -append
func_logging "The wireless profiles have been stored at $root\$WLANprofiles"

# Export Wireless Profiles
$WLANprofiles = $WlanProfileInfo
func_directory "$Audit\WLANprofiles"
netsh wlan export profile key=clear folder="$Audit\WLANprofiles" | out-null

# Audit installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize | out-file $Appinfo
get-appxpackage | Select-Object Name, Version, Architecture | out-file $Appinfo -append
func_logging "The list of installed software has been stored at $root\$appinfo"

# Audit system users
Get-LocalUser | Where-Object {$_.Enabled -eq "True"} | Export-Csv $Users
func_logging "The list of active users has been stored at $root\$users"

# Audit browser data
$Browsers = Import-Csv $Users | Select-Object Name
foreach ($user in $Browsers) {
    $Username = $user.name
    $EdgeProfile = "C:\Users\$Username\AppData\Local\Microsoft\Edge\User Data"
    $GoogleChromeProfile = "C:\Users\$Username\AppData\Local\Google\Chrome\User Data"
    $MozillaFirefoxProfile = "C:\Users\$Username\AppData\Roaming\Mozilla\Firefox\Profiles"
    $AVGSecureProfile = "C:\Users\$username\Appdata\Local\AVG\Browser\User Data"

    if (Test-Path $EdgeProfile) {
        func_directory $Edge
        Copy-Item -path $EdgeProfile -destination $Edge
        func_logging "The Edge profile of $username has been stored at $root\$edge"
    }
    if (Test-Path $GoogleChromeProfile) {
        func_directory $Chrome
        Copy-Item -path $GoogleChromeProfile -destination $Chrome
        func_logging "The Chrome profile of $username has been stored at $root\$chrome"
    }
    if (Test-Path $MozillaFirefoxProfile) {
        func_directory $Firefox
        Copy-Item -path $MozillaFirefoxProfile -destination $Firefox
        func_logging "The Firefox profile of $username has been stored at $root\$firefox"
    }
    if (Test-Path $AVGSecureProfile) {
        func_directory $AVGSecureBrowser
        Copy-Item -path $AVGSecureProfile -destination $AVGSecureBrowser
        func_logging "The AVGSecure profile of $username has been stored at $root\$AVGSecureBrowser"
    }
}
