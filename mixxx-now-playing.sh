#!/usr/bin/env bash

TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE
# TODO: fail here if the file is not writeable

echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"

quartzListAllWindows=$'import Quartz\nprint(Quartz.CGWindowListCopyWindowInfo(Quartz.kCGWindowListExcludeDesktopElements|Quartz.kCGWindowListOptionAll,Quartz.kCGNullWindowID))'

lastKnownTitle=" "

FormatAndWriteTitle(){
	currentTitle=$(  
	echo "$1" |
	cut -d\| -f1 |
	sed 's/,/ -/' |
	awk '{ print tolower($0) }' |
	ascii2uni -aU -q|
	awk '{ print toupper($0) }' |
	sed 's/$/          /')

	if [[ $currentTitle != $lastKnownTitle ]]; then
		echo "$currentTitle" > $TXTFILE
		lastKnownTitle=$currentTitle
		curtime=$(date +'%H:%M')
		echo "$curtime] Now playing:  $currentTitle"
	fi
}

IsMixxxRunning(){
	if [ $OS == "Linux" ]; then
		pgrep -i mixxx > /dev/null
	
	elif [ $OS == "Darwin" ]; then
		pgrep -i mixxx > /dev/null

	elif [[ $OS == MSYS_NT* ]]; then
		tasklist | grep "mixxx.exe" > /dev/null

	else
		# unsupported
		echo "Unsupported OS, cannot detect process"

	fi
}

while true; do
	echo "Checking for MIXXX..."

	while IsMixxxRunning > /dev/null; do
	
		if [ $OS == "Linux" ]; then
			xdotool search --name "\| Mixxx" getwindowname | 
			FormatAndWriteTitle
		
		elif [ $OS == "Darwin" ]; then
			python -c "$quartzListAllWindows" |
			grep "| Mixxx" | 
			cut -d'"' -f 2 |
			FormatAndWriteTitle

		elif [[ $OS == MSYS_NT* ]]; then
			#TODO: get window title under Windows
			FormatAndWriteTitle 'Windows, Unsupported | Mixxx'

		else
			# unsupported
			FormatAndWriteTitle 'Unrecognized, Unsupported | Mixxx'

		fi

		sleep 5
	done

	echo "recovering in 60 seconds... (CTRL-C to quit)"
	sleep 60
done
