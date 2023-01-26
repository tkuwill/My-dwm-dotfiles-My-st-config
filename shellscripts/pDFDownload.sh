#!/bin/zsh
# Description: be used to download pdfs on https://www.pref.okinawa.lg.jp/site/chijiko/kichitai/documents/
#
# change ${urls} when downloading different files.
#

echo -e "\e[34mInput the NUMBER of the file:"
read urls
curl -o shiryou${urls}.pdf https://www.pref.okinawa.lg.jp/site/chijiko/kichitai/documents/shiryou${urls}.pdf

