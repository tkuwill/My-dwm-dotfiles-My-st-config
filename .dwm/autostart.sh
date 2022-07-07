#!/bin/sh
# General stuff
arandr &
xfce4-power-manager &
thunderbird &
picom &
copyq &
feh --bg-fill /home/will/Pictures/DesktopBackground/wallpaperdwm.jpg &

# xsetroot for dwm
dwm_date () {
  date '+%Y年%m月%d日 %a %H:%M'
}

dwm_battery () {
    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATUS" = "Charging" ]; then
            printf "🔌 %s%% %s" "$CHARGE" "$STATUS"
        else
            printf "🔋 %s%% %s" "$CHARGE" "$STATUS"
        fi
    else
        printf "BAT %s%% %s" "$CHARGE" "$STATUS"
    fi
    printf "%s\n" "$SEP2"
}

bat_time () {
  acpi | grep 'Battery 0' | grep  -Eo '[0-9][0-9]:[0-9][0-9]'
}

while true
do
    xsetroot -name "$(dwm_date) | $(dwm_battery) | $(bat_time)-remaining"
    sleep 1 
done
