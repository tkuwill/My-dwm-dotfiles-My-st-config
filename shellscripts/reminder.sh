#!/bin/zsh


echo "Input mins:"
read mins
echo "Input reminder messages:"
read msg
echo "Now time is "
date "+%T"
echo "Set a timer for ${mins} minute(s)."
sleep ${mins}m && notify-send -u critical -t 10000 ${msg}
mpv ~/Music/lovesongs/God\ knows...\ \'\'The\ Melancholy\ of\ Haruhi\ Suzumiya\'\'.mp3 --start=10 --end=20 --keep-open=no --no-resume-playback --no-terminal --no-video
