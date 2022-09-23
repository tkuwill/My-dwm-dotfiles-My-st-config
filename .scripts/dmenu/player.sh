#!/bin/sh
# if you want to use this script of dmenu, you have to install "playerctl", "mpv" and "xclip" at first.

function now_play {
    playerctl metadata --format "{{ title }} 
{{ artist }} - {{ album }}"
}

function urls {
    copyq read
}


function player {
    options="Cancel\nPlay-pause\nNext\nPrev\nNow_playing\nOpen with mpv"
    selected=$(echo -e $options | dmenu -i -p "playerctl")
    if [[ $selected = "Play-pause" ]]; then 
        playerctl play-pause    
    elif [[ $selected = "Next" ]]; then 
        playerctl next
    elif [[ $selected = "Prev" ]]; then 
        playerctl previous
    elif [[ $selected = "Now_playing" ]]; then 
        notify-send -i /home/will/Pictures/sysicon/music.png -t 5000 "$(now_play)"
    elif [[ $selected = "Open with mpv" ]]; then 
	mpv $(urls)
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

player
