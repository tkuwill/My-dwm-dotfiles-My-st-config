#!/bin/sh
# ram.png is from <a href="https://www.flaticon.com/free-icons/ram" title="ram icons">Ram icons created by Freepik - Flaticon</a>.
# music.png is from <a href="https://www.flaticon.com/free-icons/google-play-music" title="google play music icons">Google play music icons created by Mayor Icons - Flaticon</a>
# battery.png is from <a href="https://www.flaticon.com/free-icons/full-battery" title="full battery icons">Full battery icons created by Pixel perfect - Flaticon</a>.
# cpu.png is from <a href="https://www.flaticon.com/free-icons/thermometer" title="thermometer icons">Thermometer icons created by Smashicons - Flaticon</a>.
# fan.png is from <a href="https://www.flaticon.com/free-icons/fan" title="fan icons">Fan icons created by Nikita Golubev - Flaticon</a>.
# You have to install lm_sensors, acpi, libnotify, playerctl and a notification package (like dunst) in order to use this script.

function mem {
    free -h | grep 'Mem' | awk '{print "Mem is used : "$3" / "$2"."}'
}

function battime {
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
        if [ "$STATUS" = "Discharging" ]; then
	    acpi | grep "Battery 0" | awk '{print "BAT-time : " $5,$6"."}'
        elif [ "$STATUS" = "Charging" ]; then
	    acpi | grep "Battery 0" | awk '{print "BAT-time : " $5,$6,$7"."}'
        elif [ "$STATUS" = "Not charging" ]; then
        acpi | grep "Battery 0" | awk '{print "Now BAT is "$5"."}'
        fi
}

function cpu_fan {
    sensors | grep 'cpu_fan'
}



function cpu_temp {
    sensors | grep 'Core 1' | sed '1 s/+/\ /g' | awk '{print "CPU temp : "$3"."}'
}

function bat_temp {
    acpi --thermal | grep -Eo '[0-9][0-9].[0-9]' | awk '{print "BAT temp : "$1"°C."}'
}


function sysinfo {
    options="Cancel\nMemory\nBAT-remaining\ncpu_fan\ncpu_temp\nBAT_temp\ntty_clock"
    selected=$(echo -e $options | dmenu -i -p "System info")
    if [[ $selected = "Memory" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/ram.png -t 8000 "$(mem)" 
    elif [[ $selected = "BAT-remaining" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/battery.png -t 8000 "$(battime)"  
    elif [[ $selected = "cpu_fan" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/fan.png -t 5000 "$(cpu_fan)"
    elif [[ $selected = "cpu_temp" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/cpu.png -t 5000 "$(cpu_temp)"
    elif [[ $selected = "BAT_temp" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/battery.png -t 8000 "$(bat_temp)"  
    elif [[ $selected = "tty_clock" ]]; then 
      st -e zsh -c 'tty-clock -s -c -r -B -D -C 6; zsh'
      elif [[ $selected = "Cancel" ]]; then 
        return
    fi

}

sysinfo
