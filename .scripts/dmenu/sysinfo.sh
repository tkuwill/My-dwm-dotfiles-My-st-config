#!/bin/sh
# ram.png is from <a href="https://www.flaticon.com/free-icons/ram" title="ram icons">Ram icons created by Freepik - Flaticon</a>.
# music.png is from <a href="https://www.flaticon.com/free-icons/google-play-music" title="google play music icons">Google play music icons created by Mayor Icons - Flaticon</a>
# battery.png is from <a href="https://www.flaticon.com/free-icons/full-battery" title="full battery icons">Full battery icons created by Pixel perfect - Flaticon</a>.
# cpu.png is from <a href="https://www.flaticon.com/free-icons/thermometer" title="thermometer icons">Thermometer icons created by Smashicons - Flaticon</a>.
# fan.png is from <a href="https://www.flaticon.com/free-icons/fan" title="fan icons">Fan icons created by Nikita Golubev - Flaticon</a>.
# You have to install lm_sensors, acpi, libnotify, playerctl and a notification package (like dunst) in order to use this script.

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


function now_play {
    playerctl metadata --format "{{ title }} 
{{ artist }} - {{ album }}"
}

function cpu_temp {
    sensors | grep 'Core 1' | cut -c 17-23 | grep -Eo '[0-9][0-9].[0-9]'
}



function sysinfo {
    options="Cancel\nMemory\nBAT-remaining\ncpu_fan\ncpu_temp\nNow_playing\ntty_clock"
    selected=$(echo -e $options | dmenu -i -p "System info")
    if [[ $selected = "Memory" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/ram.png -t 8000 "Mem is used : $(mem)  /  $(allmem)." 
    elif [[ $selected = "BAT-remaining" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/battery.png -t 8000 "BAT-time : $(battime) - remaining."  
    elif [[ $selected = "cpu_fan" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/fan.png -t 5000 "$(cpu_fan)"
    elif [[ $selected = "cpu_temp" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/cpu.png -t 5000 "CPU temp: $(cpu_temp) °C."
    elif [[ $selected = "Now_playing" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/music.png -t 5000 "$(now_play)"
    elif [[ $selected = "tty_clock" ]]; then 
      st -e zsh -c 'tty-clock -s -c -r -B -D -C 6; zsh'
      elif [[ $selected = "Cancel" ]]; then 
        return
    fi

}

sysinfo
