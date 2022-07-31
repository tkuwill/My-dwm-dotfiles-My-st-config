#!/bin/sh
# ram.png is from <a href="https://www.flaticon.com/free-icons/ram" title="ram icons">Ram icons created by Freepik - Flaticon</a>.


function mem {
    free -h | grep 'Mem' | cut -c 28-32
}

function allmem {
    free -h | grep 'Mem' | cut -c 16-20
}

function battime {
    acpi | grep 'Battery 0' | grep  -Eo '[0-9][0-9]:[0-9][0-9]'
}

function sysinfo {
    options="Cancel\nMemory\nBAT-remaining"
    selected=$(echo -e $options | dmenu -i -p "System info")
    if [[ $selected = "Memory" ]]; then 
        notify-send -t 8000 "Mem is used : $(mem)/$(allmem)." 
    elif [[ $selected = "BAT-remaining" ]]; then 
        notify-send -t 8000 "BAT-time : $(battime)-remaining."  
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi

}

sysinfo
