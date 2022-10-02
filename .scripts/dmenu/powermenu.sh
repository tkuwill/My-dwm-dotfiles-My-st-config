#!/bin/sh
# power.png is from https://www.flaticon.com/free-icon-font/power_3917748?page=1&position=1&term=power

function ck {
    date "+%T"
}

function powermenu {
    options="Cancel\nLock\nSuspend\nShutdown\nRestart"
    selected=$(echo -e $options | dmenu -i -p "What do you want to do ?")
    if [[ $selected = "Shutdown" ]]; then 
	    notify-send -i /home/will/Pictures/sysicon/power.png -u critical -t 0 "Now time is $(ck) . 
ASUS 'll be shutdown in 1 min. Use 'shutdown -c' to cancel." && shutdown
    elif [[ $selected = "Restart" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/restart.png -u critical -t 0 "Computer will be rebooted in 30 secs." && sleep 30s && reboot
    elif [[ $selected = "Suspend" ]]; then 
        sleep 1s && systemctl suspend
    elif [[ $selected = "Lock" ]]; then
       slock
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

powermenu
