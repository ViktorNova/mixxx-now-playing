#!/usr/bin/env bash

TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE
# TODO: fail here if the file is not writeable

echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"

while true; do
	while pgrep -i mixxx > /dev/null; do

	if [ $OS == "Linux" ]; then
		xdotool search --name "\| Mixxx" getwindowname |cut -d\| -f1 | sed 's/,/ -/' | awk '{ print toupper($0) }' >  $TXTFILE
	elif [ $OS == "Darwin" ]; then
		python -c " 
import Quartz
print(Quartz.CGWindowListCopyWindowInfo(Quartz.kCGWindowListExcludeDesktopElements|Quartz.kCGWindowListOptionOnScreenOnly,Quartz.kCGNullWindowID))
" | grep "| Mixxx" | cut -d'"' -f 2 |cut -d\| -f1 | sed 's/,/ -/' | awk '{ print toupper($0) }' | sed 's/$/          /' > $TXTFILE
	fi

	# TODO: don't write the file if the value is the same (better for disk I/O)
	# TODO: unify write command for both OSs
	sleep 5
	done


sleep 60
done
