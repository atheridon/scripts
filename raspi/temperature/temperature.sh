#!/bin/bash

declare -i cpu_temp
cpu_temp=`cat /sys/class/thermal/thermal_zone0/temp`/1000

if [ $cpu_temp -ge 75 ]
then
	printf "!!!! Raspberry Pi Temperature !!!!\n`date`\n\nCPU Temperature is very high:\n$cpu_temp degree celcius" > /home/pi/scripts/temperature/notify_temperature.txt
	python3 /home/pi/scripts/temperature/telegram_notify.py
elif [ $cpu_temp -ge 88 ]
then
	printf "!!!! Raspberry Pi Temperature !!!!\n`date`\n\nCPU Temperature is TOO HIGH:\n$cpu_temp degree celcius\n Shutting down Raspberry Pi" > /home/pi/scripts/temperature/notify_temperature.txt
	python3 /home/pi/scripts/temperature/telegram_notify.py
	sudo shutdown now
fi
