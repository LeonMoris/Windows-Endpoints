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
# Github: https://github.com/LeonMoris                                                                                                            #
#-------------------------------------------------------------------------------------------------------------------------------------------------#

#Sleep Function
Function func_sleep{
    Start-Sleep -s 5
}

# Set Windows Directory
$Root = "C:\Joy"
$Windows = "$root\Windows"

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
