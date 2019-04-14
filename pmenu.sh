#!/bin/bash

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -yoffset 60 -xoffset -28 -width 15 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 -font "IBMPlex Mono 10" <<< "Sleep|Logout|Reboot|Shutdown")"
            case "$MENU" in
                *Sleep) /home/flo/ownCloud/Linux/scripts/i3locksuspend.sh & ;;
                *Logout) i3-msg exit;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff
esac
