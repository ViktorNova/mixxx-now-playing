#!/usr/bin/env bash
TMPFILE=~/mixxx-now-playing.txt
touch $TMPFILE
echo "+"  > $TMPFILE
while true; do

	while pidof mixxx; do
	xdotool search --name "\| Mixxx" getwindowname > $TMPFILE
	sleep 5
	done

sleep 60
done
