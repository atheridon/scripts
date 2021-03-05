#!/bin/bash

# Variables 
MAC_hpserver="9c:b6:54:04:57:da"
IP_hpserver="10.0.0.250"
IP_vm="10.0.0.249"
SSH_hpserver="/home/pi/.ssh/hpserver/id_rsa"
SSH_vm="/home/pi/.ssh/hpserver_vm/id_rsa"
backup_src_dir="/var/www/html/owncloud/data/"
backup_dest_dir="~/cloudpi_backup/"
notify_text="/home/pi/scripts/backup/notify_backup.txt"
notify_py="python3 /home/pi/scripts/backup/telegram_notify.py"

# Wake-on-LAN hpserver
# This starts the hp microserver and the VM for raspberry cloud backup
wakeonlan $MAC_hpserver

# Wait for hpserver to start up
counter=0
while true
do
	if `ping -c 4 $IP_hpserver > /dev/null`; then
		echo "HP Server ping successful"
		sleep 60
		break
	else
		if [ $counter -eq 1000 ]; then
			# Send error notification per telegram
			echo "HP Server not reachable!" && printf "!!!! Raspberry Pi Cloud Backup !!!!\n`date`\n\nError: HP Server not reachable!" > $notify_text
			$notify_py
			exit
		else
			((counter++))
			continue
		fi
	fi
done

# Start cloudpi_backup_vm (virtual machine)
ssh flo@$IP_hpserver -i $SSH_hpserver VBoxVRDP -s cloudpi_backup_vm &

# Wait for vm to start up
counter=0
while true
do
	if `ping -c 4 $IP_vm > /dev/null`; then
		echo "VM Server ping successful"
		sleep 60
		break
	else
		if [ $counter -eq 1000 ]; then
			# Send error notification per telegram
			echo "VM for raspberry cloud backup not reachable!" && printf "!!!! Raspberry Pi Cloud Backup !!!!\n`date`\n\nError: VM for raspberry cloud backup not reachable!" > $notify_text
			$notify_py

			# Shutdown the hp server to save ressources
			ssh flo@$IP_hpserver -i $SSH_hpserver sudo shutdown now
			exit
		else
			((counter++))
			continue
		fi
	fi
done

# Backup cloud files with rsync and ssh
sudo rsync -avzP --delete -e 'ssh -i '$SSH_vm'' $backup_src_dir flo@$IP_vm:$backup_dest_dir

# Shutdown VM server for backup
ssh flo@$IP_hpserver -i $SSH_hpserver VBoxManage controlvm "cloudpi_backup_vm" savestate
wait

# Shutdown hp server
ssh flo@$IP_hpserver -i $SSH_hpserver sudo shutdown now

# Send "done" notification to me per telegram
echo "Backup complete." && printf "!!!! Raspberry Pi Cloud Backup !!!!\n`date`\n\nDone: Backup complete." > $notify_text
$notify_py
