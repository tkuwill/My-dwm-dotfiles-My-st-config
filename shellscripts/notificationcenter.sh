#!/bin/zsh

function cen {
    dunstctl count history   
}

dunstify -a "center" -i /home/will/Pictures/sysicon/chat.png -t 8000 "Notification histories: $(cen)" && sleep 2s && repeat $(cen + 1) { dunstctl history-pop }
