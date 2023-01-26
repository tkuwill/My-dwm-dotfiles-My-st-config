#!/bin/zsh
# Description: record the battery cycle into batterycycle.log, then show the batterycycle.log with bat.
echo -e "\e[34mWriting the battery record into batterycycle.log ..."
date >> /home/will/shellscripts/log/batterycycle.log && upower --show-info /org/freedesktop/UPower/devices/battery_BAT0 | grep 'charge-cycles' >> /home/will/shellscripts/log/batterycycle.log && upower --show-info /org/freedesktop/UPower/devices/battery_BAT0 | grep 'capacity' >> /home/will/shellscripts/log/batterycycle.log
echo -e "\e[34mfinished !"
sleep 1s
bat /home/will/shellscripts/log/batterycycle.log 
