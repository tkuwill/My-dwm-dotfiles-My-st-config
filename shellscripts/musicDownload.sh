#!/bin/zsh
# Description: Download music from YouTube.

echo -e "\e[34mInput the url of the song:"
read urls
echo -e "\e[35mInput the name of the song:"
read name
echo -e "\e[33mcd to Downloads"
cd ~/Downloads

echo -e "\e[32mNow downloading music from YouTube..."
yt-dlp -f 'ba' -x --audio-format mp3 ${urls}  -o 'name.%(ext)s'
mv name.mp3 ${name}.mp3

echo "Download finished !!!"
