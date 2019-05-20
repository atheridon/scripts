#!/bin/bash

# Script for xautolock to only lock screen with i3lock once

checki3lock=`pgrep -f i3lock-next | wc -l`

if [[ $checki3lock = 0 ]]
then
	i3lock-next "`uname -r`" IBMPlexMono 15 &
	sleep 1
	sudo s2ram
else
	sudo s2ram
fi
