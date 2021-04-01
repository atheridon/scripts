#!/bin/sh

# fix multiple monitors with different refresh rates using nvidia drivers
# start nvidia-settings and close immediately afterwards
# make this script start with login (autostart)

##
#
# place the following into /etc/environment:
#	CLUTTER_DEFAULT_FPS=144
#	__GL_SYNC_DISPLAY_DEVICE=DP-2
# 	__GL_SYNC_TO_VBLANK=0

# where 144 is your highest monitor's refresh rate (e.g. 60hz + 144hz = 144hz)
# and DP-2 the monitor with the highest refresh rate (use xrandr to find this out)
#
# in nvidia-settings make sure to use 'Force Full Composition Pipeline' on all monitors
# and also disable 'Allow Flipping' and 'Sync to VBlank' in the OpenGL Settings
#
##

if nvidia-settings &> /dev/null &
then
	sleep 1
	killall nvidia-settings
	exit 0
else 
	if [ ! -d $HOME/nvidia-fix ]; then
		mkdir $HOME/nvidia-fix
	fi

	printf '$(date +"%d-%m-%Y %H:%M:%S") - Could not start nvidia-settings' >> $HOME/nvidia-fix/nvidia-fix_error.log
	exit 1
fi
