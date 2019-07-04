#!/bin/bash

# Script for xautolock to only lock screen with i3lock once

checki3lock=`pgrep -f i3lock | wc -l`

if [[ $checki3lock = 0 ]]
then
	i3lock &
	sleep 1
	sudo pm-suspend	
else
	sudo pm-suspend
fi
