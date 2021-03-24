#!/usr/bin/env bash

TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE
# TODO: fail here if the file is not writeable

echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"
#TODO switch out the db path depending on OS

while true; do
	while pgrep -i mixxx > /dev/null; do
		sqlite3 ~/Library/Application\ Support/Mixxx/mixxxdb.sqlite "select library.artist, library.title, library.year from library where library.id = (select PlaylistTracks.track_id from PlaylistTracks where id = (select max(id) from PlaylistTracks));" |
		sed 's/$/|/' |
		sed 's/|/ | /g' > $TXTFILE
	sleep 5
	done


sleep 60
done
