uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
date_formatted=$(date "+%a %F %H:%M")
linux_version=$(uname -r | cut -d '-' -f1)
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
echo ↑ $uptime_formatted 🐧$linux_version 🔋 $battery_percentage% $date_formatted
