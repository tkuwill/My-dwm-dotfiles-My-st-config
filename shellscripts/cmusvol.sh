#!/bin/bash
#
PS3="What you want in cmus: "

items=("Vol" "Loop_current_track" "Loop_all_playlist" "quit")
select opt in "${items[@]}" 
	  do

	  case $opt in
	    Vol)
	      echo -n  "cmus Volume (from 0.0~1.0): " 
	      read fig
	      playerctl -p cmus volume ${fig}
	      dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/volume-up.png -t 4500 "cmus Volume ${fig}"
              break
	      ;;
	    Loop_current_track)
	      playerctl -p cmus loop track
	      dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/music.png -t 4500 "cmus Repeat Current Track"
              break
	      ;;
	    Loop_all_playlist)
	      playerctl -p cmus loop playlist
	      dunstify -a "changeVolume" -i /home/will/Pictures/sysicon/music.png -t 4500 "cmus Repeat All Playlist"
              break
	      ;;
            quit)
              break
              ;;
	      *) 
              echo "Invalid option $REPLY"
              ;;
              esac
	      done
