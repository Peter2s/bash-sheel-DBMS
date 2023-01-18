#!/bin/bash
. functions.sh
 dbToConnect=$(whiptail --title "Connect to DataBase" --inputbox "Enter your DataBase name " 8 45 3>&1 1>&2 2>&3)
if [[ -d $dbConnect ]]; then
	cd $dbConnect 
	#. ../tablemenu.sh
	echo "You are now connceted to $dbConnect Database successfully"
else
	whiptail --title "Error Message" --msgbox "Connection failed" 8 45
        . ./main.sh	
        #red "connection failed"
fi

