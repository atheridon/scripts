#!/bin/bash

pid="/tmp/lowbat.pid"

if [ -e $pid ]; then
	exit
else
	echo $$ > $pid
fi

while true
do
	# check if battery is charging or discharging
	if [[ `acpi -b | cut -f 3 -d " "` == Discharging, ]]
	then
		# check if battery level is less or equal to 5%
		if [[ `acpi -b | grep -P -o '[0-9]+(?=%)'` -le 5 ]]
        	then
            		/usr/bin/notify-send "Shutting down in 10 seconds..."
            		sleep 10
			# check if battery is charging again and not discharging anymore
			if [ `acpi -b | cut -f 3 -d " "` == Discharging, ]
			then
				shutdown now	
			fi
		elif [[ `acpi -b | grep -P -o '[0-9]+(?=%)'` -le 10 ]]
		then
			/usr/bin/notify-send "Battery low!" "`acpi -b | grep -P -o '[0-9]+(?=%)'`% remaining"
		fi
	fi
	sleep 300
done
