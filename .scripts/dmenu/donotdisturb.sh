#!/bin/sh

function notification {
    options="Cancel\nDo not disturb\nNormal"
    selected=$(echo -e $options | dmenu -i -p "Notification Mode")
    if [[ $selected = "Do not disturb" ]]; then 
        dunstctl set-paused true
    elif [[ $selected = "Normal" ]]; then 
        dunstctl set-paused false
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

notification
