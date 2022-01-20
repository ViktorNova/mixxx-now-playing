#!/usr/bin/env bash
#TODO: MAKE ME PROPER, PASTE IN STUFF FROM OTHER SCRIPT
TRACKLISTFILE="/Users/n0va/Documents/VirtualDJ/History/tracklist.txt"
TXTFILE=~/mixxx-now-playing.txt

touch $TXTFILE
# TODO: fail here if the file is not writeable

echo " "  > $TXTFILE

while true; do
	while pgrep  VirtualDJ > /dev/null; do

	CURRENT_SONG=`cat $TRACKLISTFILE |\
	tail -n 1 |\
	tr [:lower:] [:upper:] |\
	cut -c 8-`

	#if [[ "$VAR1" == "$VAR2" ]]; then
    	#	echo "Strings are equal."
	#else
    	#	echo "Strings are not equal."
	#fi

	echo $CURRENT_SONG > $TXTFILE

	# TODO: don't write the file if the value is the same
	# (better for disk I/O)
	sleep 5
	done

sleep 60
done
