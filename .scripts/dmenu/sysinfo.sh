#!/bin/sh
# ram.png is from <a href="https://www.flaticon.com/free-icons/ram" title="ram icons">Ram icons created by Freepik - Flaticon</a>.
# You have to install lm_sensors, acpi, libnotify, and a notification package (like dunst) in order to use this script.

function mem {
    free -h | grep 'Mem' | cut -c 28-32
}

function allmem {
    free -h | grep 'Mem' | cut -c 16-20
}

function battime {
    acpi | grep 'Battery 0' | grep  -Eo '[0-9][0-9]:[0-9][0-9]'
}

function cpu_fan {
    sensors | grep 'cpu_fan'
}

function cpu_temp {
    sensors | grep 'Core 0' | cut -c 16-23
}

function sysinfo {
    options="Cancel\nMemory\nBAT-remaining\ncpu_fan\ncpu_temp"
    selected=$(echo -e $options | dmenu -i -p "System info")
    if [[ $selected = "Memory" ]]; then 
        notify-send -t 8000 "Mem is used : $(mem)  /  $(allmem)." 
    elif [[ $selected = "BAT-remaining" ]]; then 
        notify-send -t 8000 "BAT-time : $(battime) - remaining."  
    elif [[ $selected = "cpu_fan" ]]; then 
        notify-send -t 5000 "$(cpu_fan)"
    elif [[ $selected = "cpu_temp" ]]; then 
        notify-send -t 5000 "CPU temp: $(cpu_temp) ."
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi

}

sysinfo
