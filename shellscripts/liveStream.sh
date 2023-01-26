#!/bin/zsh
# Description: Playing live-streaming.
#

PS3="What do you want to play: "

items=("twitch" "bilibili" "quit")
select opt in "${items[@]}" 
	  do

	  case $opt in
	    twitch)
	      echo -n "The Url you want to play: " 
	      read url
	      echo -n "The Quality you want(audio_only,160p,360p,720p,1080p60...): "
	      read qua
	      streamlink -p mpv --twitch-disable-ads ${url} ${qua}
              break
	      ;;
	    bilibili)
	      echo -n "The Url you want to play: " 
	      read url
	      echo -n "The Quality you want(worst,best): "
	      read qua
	      streamlink -p mpv ${url} ${qua}
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


