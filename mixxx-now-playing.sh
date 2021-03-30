#!/usr/bin/env bash

TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE
# TODO: fail here if the file is not writeable

echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"
#TODO switch out the db path depending on OS

while true; do
	PLID=$(sqlite3 ~/Library/Application\ Support/Mixxx/mixxxdb.sqlite "select playlist_id from PlaylistTracks pt where id = (select max(id) from PlaylistTracks)")
	echo "Using Playlist ID: "$PLID
	while pgrep -i mixxx > /dev/null; do
		sqlite3 ~/Library/Application\ Support/Mixxx/mixxxdb.sqlite "SELECT library.artist, library.title, library.year  FROM "main"."library" WHERE id = (SELECT track_id from PlaylistTracks WHERE playlist_id = $PLID ORDER BY position DESC limit 1)" |
		sed 's/$/|/' |
		sed 's/|/ | /g' |
		sed 's/|  |/|/g' |
		sed -e '1s/^/NOW PLAYING: /' > $TXTFILE
	sleep 5
	done


sleep 60
done
