#!/bin/sh

    STATUS=$(cat /sys/class/power_supply/BAT0/status)
        if [ "$STATUS" = "Discharging" ]; then
	    acpi | grep "Battery 0" | awk '{print "BAT-time : " $5,$6"."}' | xargs -n 2
        elif [ "$STATUS" = "Charging" ]; then
	    acpi | grep "Battery 0" | awk '{print "BAT-time : " $5,$6,$7"."}' | xargs -n 3
        elif [ "$STATUS" = "Not charging" ]; then
        acpi | grep "Battery 0" | awk '{print "Now BAT is "$5"."}'
        fi
