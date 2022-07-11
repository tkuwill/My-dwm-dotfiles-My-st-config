#!/bin/sh

function calendar {
    options="Cancel\nthis-month\nthis-year\nthe-next-twelve-months"
    selected=$(echo -e $options | dmenu -i -p "Calendar")
    if [[ $selected = "this-month" ]]; then 
        st -e zsh -c 'cal; zsh'
    elif [[ $selected = "this-year" ]]; then 
        st -e zsh -c 'cal -y; zsh'
    elif [[ $selected = "the-next-twelve-months" ]]; then 
        st -e zsh -c 'cal -Y; zsh'
    elif [[ $selected = "Cancel" ]]; then 
        return
    fi
}

calendar
