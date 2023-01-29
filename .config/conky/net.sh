#!/bin/sh

    STATUS=$(nmcli device | sed '2 q' | sed '1 d' | awk '{print $3}')
        if [ "$STATUS" = "connected" ]; then
	    nmcli device | sed '2 q' | sed '1 d' | awk '{print $4,$5,$3}'
        elif [ "$STATUS" = "disconnected" ]; then
            nmcli device | sed '2 q' | sed '1 d' | awk '{print $2,$3}'
        fi
