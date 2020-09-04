#!/usr/bin/env bash

TXTFILE=~/SHARED/mixxx-now-playing.txt

touch $TXTFILE
echo " "  > $TXTFILE
OS=`uname`

while true; do
	while pgrep mixxx > /dev/null; do

	if [ $OS == "Linux']; then
		xdotool search --name "\| Mixxx" getwindowname |cut -d\| -f1 | sed 's/,/ -/' > $TXTFILE
	elif [ $OS == "Darwin']; then
		FULLTEXT=`python mixxtitle.py`
		echo $FULLTEXT |cut -d\| -f1 | sed 's/,/ -/' > $TXTFILE
	sleep 5
	done

sleep 60
done
