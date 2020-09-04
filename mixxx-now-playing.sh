#!/usr/bin/env bash

TXTFILE=~/SHARED/mixxx-now-playing.txt

touch $TXTFILE
echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"

while true; do
	while pgrep mixxx > /dev/null; do

	if [ $OS == "Linux" ]; then
		xdotool search --name "\| Mixxx" getwindowname |cut -d\| -f1 | sed 's/,/ -/' | awk '{ print toupper($0) }'> $TXTFILE
	elif [ $OS == "Darwin" ]; then
		python -c " 
import Quartz
print(Quartz.CGWindowListCopyWindowInfo(Quartz.kCGWindowListExcludeDesktopElements|Quartz.kCGWindowListOptionOnScreenOnly,Quartz.kCGNullWindowID))
" | grep "| Mixxx" | cut -d'"' -f 2 |cut -d\| -f1 | sed 's/,/ -/' | awk '{ print toupper($0) }' > $TXTFILE
	fi

	sleep 5
	done

sleep 60
done
