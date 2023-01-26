#!/bin/sh
# if you want to use this script of dmenu, you have to install "playerctl", "mpv" and "copyq" at first.

function now_play {
    playerctl metadata --format "{{ title }} 
{{ artist }} - {{ album }}"
}

function urls {
    copyq read
}

function burls {
    copyq read | cut -c 1-44
}


function player {
    options="Cancel\nPlay-pause\nNext\nPrev\nNow_playing\nOpen_with_mpv_Yt\nOpen_with_mpv_BiliBili\ncmus_option"
    selected=$(echo -e $options | dmenu -i -p "playerctl")
    if [[ $selected = "Play-pause" ]]; then 
        playerctl play-pause    
    elif [[ $selected = "Next" ]]; then 
        playerctl next
    elif [[ $selected = "Prev" ]]; then 
        playerctl previous
    elif [[ $selected = "Now_playing" ]]; then 
        dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/music.png -t 5000 "$(now_play)"
    elif [[ $selected = "Open_with_mpv_Yt" ]]; then 
	mpv $(urls)
    elif [[ $selected = "Open_with_mpv_BiliBili" ]]; then 
	mpv --referrer="https://www.bilibili.com" $(burls)
    elif [[ $selected = "cmus_option" ]]; then 
        st -t scratchpadname -g 32x10 -e zsh -c '/home/will/shellscripts/cmusvol.sh; zsh'
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

player
