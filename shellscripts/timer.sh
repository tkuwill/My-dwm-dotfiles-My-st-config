#!/bin/zsh




echo "Input mins:"
read mins
echo "Now time is "
date
echo "Set a timer for ${mins} minute(s)."
sleep ${mins}m && notify-send -u critical -t 10000 ${mins} 'min(s) timer has Finished.'
mpv ~/Music/lovesongs/God\ knows...\ \'\'The\ Melancholy\ of\ Haruhi\ Suzumiya\'\'.mp3 --start=10 --end=20 --keep-open=no --no-resume-playback --no-terminal --no-video

