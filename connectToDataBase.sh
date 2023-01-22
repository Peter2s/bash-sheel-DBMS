#!/bin/bash
. functions.sh
db_name=$(whiptail --title "Connect to DataBase" --inputbox "Enter your DataBase name " 8 45 3>&1 1>&2 2>&3)
if [[ -d db/$db_name ]]
then
	. table.sh
else
	whiptail --title "Error Message" --msgbox "Connection failed to $db_name" 8 45
	#red "connection failed"
    . main.sh	
        
fi

