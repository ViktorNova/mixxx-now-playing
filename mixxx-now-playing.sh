#!/usr/bin/env bash
TMPFILE="~/mixxx-now-playing.txt"

while pidof mixxx; do
xdotool search --name Mixxx getwindowname > $TMPFILE
sleep 5
done
