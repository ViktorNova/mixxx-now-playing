#!/usr/bin/env bash

TXTFILE=~/SHARED/mixxx-now-playing.txt

touch $TXTFILE
echo " "  > $TXTFILE
while true; do

	while pidof mixxx > /dev/null; do
	xdotool search --name "\| Mixxx" getwindowname |cut -d\| -f1 | sed 's/,/ -/' > $TXTFILE
	sleep 5
	done

sleep 60
done
