#!/bin/bash

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -yoffset 25 -xoffset -25 -width 15 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 -font "IBMPlex Mono 10" <<< "Sleep|Logout|Reboot|Shutdown")"
            case "$MENU" in
                *Sleep) i3lock -c 000000 && sudo pm-suspend;;
                *Logout) i3-msg exit;;
                *Reboot) sudo reboot;;
                *Shutdown) sudo halt 
esac
