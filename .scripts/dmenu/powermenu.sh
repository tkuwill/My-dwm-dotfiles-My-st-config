#!/bin/sh
# power.png is from https://www.flaticon.com/free-icon-font/power_3917748?page=1&position=1&term=power
function powermenu {
    options="Cancel\nLock\nSuspend\nShutdown\nRestart"
    selected=$(echo -e $options | dmenu -i -p "What do you want to do ?")
    if [[ $selected = "Shutdown" ]]; then 
        notify-send -i /home/will/Pictures/DesktopBackground/power.png -u critical -t 0 "Computer will be shutdown in 30 secs." && sleep 30s && poweroff
    elif [[ $selected = "Restart" ]]; then 
        notify-send -i /home/will/Pictures/DesktopBackground/restart.png -u critical -t 0 "Computer will be rebooted in 30 secs." && sleep 30s && reboot
    elif [[ $selected = "Suspend" ]]; then 
        i3lock --indicator --inside-color=#fce5ff --radius=110 --ring-width=20 --clock --time-str="%H:%M:%S" --date-str="%Y %b %e %A" --time-font=SauceCodeProNerdFont --greeter-text="Welcome back ! Will" --greeter-color=#00ffff --greeter-font=SauceCodeProNerdFont -p default -f -i /home/will/Pictures/DesktopBackground/sakuraokita-lock.png && systemctl suspend
    elif [[ $selected = "Lock" ]]; then
        i3lock --indicator --inside-color=#fce5ff --radius=110 --ring-width=20 --clock --time-str="%H:%M:%S" --date-str="%Y %b %e %A" --time-font=SauceCodeProNerdFont --greeter-text="Welcome back ! Will" --greeter-color=#00ffff --greeter-font=SauceCodeProNerdFont -p default -f -i /home/will/Pictures/DesktopBackground/sakuraokita-lock.png 
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

powermenu
