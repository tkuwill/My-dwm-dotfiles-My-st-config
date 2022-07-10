#!/bin/sh

function powermenu {
    options="Cancel\nLock\nSuspend\nShutdown\nRestart"
    selected=$(echo -e $options | dmenu)
    if [[ $selected = "Shutdown" ]]; then 
        poweroff
    elif [[ $selected = "Restart" ]]; then 
        reboot
    elif [[ $selected = "Suspend" ]]; then 
        i3lock --indicator --inside-color=#fce5ff --radius=110 --ring-width=20 --clock --time-str="%H:%M:%S" --date-str="%Y %b %e %A" --time-font=SauceCodeProNerdFont --greeter-text="Welcome back ! Will" --greeter-color=#00ffff --greeter-font=SauceCodeProNerdFont -p default -f -i /home/will/Pictures/DesktopBackground/sakuraokita-lock.png && systemctl suspend
    elif [[ $selected = "Lock" ]]; then
        i3lock --indicator --inside-color=#fce5ff --radius=110 --ring-width=20 --clock --time-str="%H:%M:%S" --date-str="%Y %b %e %A" --time-font=SauceCodeProNerdFont --greeter-text="Welcome back ! Will" --greeter-color=#00ffff --greeter-font=SauceCodeProNerdFont -p default -f -i /home/will/Pictures/DesktopBackground/sakuraokita-lock.png 
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

powermenu
