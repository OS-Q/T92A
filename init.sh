#!/bin/bash

export WorkPath=`pwd`

## Root Password
for ((i = 0; i < 5; i++)); do
	PASSWD=$(whiptail --title "Linux Netassistant" \
		--passwordbox "Enter root password. Don't use root or sudo run it" \
		10 60 3>&1 1>&2 2>&3)
	if [ $i = "4" ]; then
		whiptail --title "Note Qitas" --msgbox "Invalid password" 10 40 0	
		exit 0
	fi

	sudo -k
	if sudo -lS &> /dev/null << EOF
$PASSWD
EOF
	then
		i=10
	else
		whiptail --title "Linux Netassistant" --msgbox "Invalid password, Pls input corrent password" \
		10 40 0	--cancel-button Exit --ok-button Retry
	fi
done

echo $PASSWD | sudo ls &> /dev/null 2>&1



OPTION=$(whiptail --title "ubuntu System" \
	--menu "$MENUSTR" 20 60 12 --cancel-button Finish --ok-button Select \
	"0"   "prepare" \
	"1"   "qmake" \
	"2"   "make" \
	"3"   "install" \
	3>&1 1>&2 2>&3)
	

if [ $OPTION = '0' ]; then
	clear
	echo -e "prepare\n${Line}"
	sudo apt install -y qtcreator libqt5serialport5-dev libudev-dev qt5-default
	exit 0
elif [ $OPTION = '1' ]; then
	clear
	echo -e "qmake\n${Line}"
	cd $WorkPath
	qmake
	exit 0	
elif [ $OPTION = '2' ]; then
	clear
	echo -e "make\n${Line}"
	cd $WorkPath
	make
	exit 0
elif [ $OPTION = "3" ]; then
	clear
	echo -e "install or run\n${Line}"
	exit 0
else
	whiptail --title "Linux Netassistant" \
		--msgbox "Please select correct option" 10 50 0
	exit 0
fi



exit 0
