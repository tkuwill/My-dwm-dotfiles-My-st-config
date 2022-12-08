#!/bin/sh
# cup-of-drink.png is from <a href="https://www.flaticon.com/free-icons/tea" title="tea icons">Tea icons created by Freepik - Flaticon</a>.
# sleepy.png is from <a href="https://www.flaticon.com/free-icons/tired" title="tired icons">Tired icons created by Freepik - Flaticon</a>.
function nosleep {
    options="Cancel\nWon't sleep\nNormal"
    selected=$(echo -e $options | dmenu -i -p "Screen saver Mode")
    if [[ $selected = "Won't sleep" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/cup-of-drink.png -t 8000 "Now your screen won't sleep." && xset s off -dpms
    elif [[ $selected = "Normal" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/sleepy.png -t 8000 "Your screen lacks caffeine." && xset s on +dpms
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

nosleep
