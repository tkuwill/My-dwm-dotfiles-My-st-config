#!/bin/sh
# General stuff
arandr &
xfce4-power-manager &
thunderbird &
picom &
copyq &
feh --bg-fill /home/will/Pictures/DesktopBackground/wallpaperdwm.jpg &
/usr/bin/dunst &
/home/will/.dwm/lowbatremind.sh &
# xsetroot for dwm
dwm_date () {
    date '+%Y年%m月%d日(%a)%H:%M'
}
# by joestandring/dwm-bar

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

dwm_alsa () {
	STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
    	if [ "$STATUS" = "off" ]; then
	            printf "🔇"
    	else
    		#removed this line becuase it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	            printf "🔈 %s%%" "$VOL"
	        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	            printf "🔉 %s%%" "$VOL"
	        else
	            printf "🔊 %s%%" "$VOL"
	        fi
		fi
    else
    	if [ "$STATUS" = "off" ]; then
    		printf "MUTE"
    	else
	        # removed this line because it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	            printf "VOL %s%%" "$VOL"
	        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	            printf "VOL %s%%" "$VOL"
	        else
	            printf "VOL %s%%" "$VOL"
        	fi
        fi
    fi
    printf "%s\n" "$SEP2"
}

while true
do
    xsetroot -name "$(dwm_alsa)|$(dwm_date)|$(dwm_battery)|$(bat_time)-remaining"
    sleep 1 
done

