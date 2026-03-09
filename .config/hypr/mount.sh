#!/bin/bash
if [ $1 == "-u" ]
then
usb_list=$(lsblk -rno NAME,MOUNTPOINT,TYPE,SIZE | grep -v disk| grep -v "/" )
partition_selected="$(echo -e "$usb_list" | tofi --prompt-text 'Escolha a particao que deseja montar: ')"
usb_list=$(lsblk -rno NAME,MOUNTPOINT,TYPE,SIZE | grep -v disk| grep -v "/" | awk '{print $1}')
partition_selected_treated=$(echo -e "$partition_selected" | awk '{print "/dev/"$1}')

mkdir -p $HOME/usb
pkexec mount $partition_selected_treated $HOME/usb -o umask=000
notify-send "$partition_selected montado"
else
	pkexec umount $HOME/usb
	notify-send "$partition_selected desmontado"
fi
