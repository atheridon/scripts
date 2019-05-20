#!/bin/bash

# Script for xautolock to only lock screen with i3lock once

checki3lock=`pgrep -f i3lock-next | wc -l`

if [[ $checki3lock = 0 ]]
then
	i3lock-next &
	sleep 1
	systemctl suspend
else
	systemctl suspend
fi
