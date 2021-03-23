#!/usr/bin/env bash

# Linux - Mixxx
BINNAME='mixxx'
PROCNAME='Mixxx'
TITLEPATTERN='(.+)| Mixxx'

# Windows - VLC
#BINNAME='vlc.exe'
#PROCNAME='VLC'
#TITLEPATTERN='(.+) - VLC media player'

TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE

# fail here if the file is not writeable
[ -w $TXTFILE ] && echo "Capturing track titles to [$TXTFILE]" || { echo "Cannot write to [$TXTFILE]"; exit; }

echo " "  > $TXTFILE
OS=`uname`

echo "Detected OS: $OS"

quartzListAllWindows=$'import Quartz\nprint(Quartz.CGWindowListCopyWindowInfo(Quartz.kCGWindowListExcludeDesktopElements|Quartz.kCGWindowListOptionAll,Quartz.kCGNullWindowID))'

lastKnownTitle=" "

FormatAndWriteTitle(){
	if [[ $1 =~ $TITLEPATTERN ]]; then
		currentTitle="${BASH_REMATCH[1]}"

		currentTitle=$(  
		echo "$currentTitle" |
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
	fi
}

IsMixxxRunning(){
	if [ $OS == "Linux" ]; then
		pgrep -i mixxx > /dev/null
	
	elif [ $OS == "Darwin" ]; then
		pgrep -i mixxx > /dev/null

	elif [[ $OS == MSYS_NT* ]]; then
		tasklist | grep "$BINANME" > /dev/null

	else
		# unsupported
		echo "Unsupported OS, cannot detect process"

	fi
}

while true; do
	echo "Checking for $PROCNAME..."

	while IsMixxxRunning > /dev/null; do
	
		if [ $OS == "Linux" ]; then
			xdotool search --name "\| $PROCNAME" getwindowname | 
			FormatAndWriteTitle
		
		elif [ $OS == "Darwin" ]; then
			python -c "$quartzListAllWindows" |
			grep "| $PROCNAME" | 
			cut -d'"' -f 2 |
			FormatAndWriteTitle

		elif [[ $OS == MSYS_NT* ]]; then
			mytitle=$(powershell -Command "& Write-Host (Get-Process -Name $PROCNAME).MainWindowTitle")
			FormatAndWriteTitle "$mytitle"

		else
			# unsupported
			FormatAndWriteTitle "Unrecognized, Unsupported | $PROCNAME"

		fi

		sleep 5
	done

	echo "recovering in 60 seconds... (CTRL-C to quit)"
	sleep 60
done
