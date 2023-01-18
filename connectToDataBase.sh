#!/bin/bash
. functions.sh
 db_name=$(whiptail --title "Connect to DataBase" --inputbox "Enter your DataBase name " 8 45 3>&1 1>&2 2>&3)
 echo $db_name
if [[ -d db/$db_name ]]
then
 	cd db/$db_name 

	. ../../table.sh
	echo "You are now connceted to $db_name Database successfully"
else
	whiptail --title "Error Message" --msgbox "Connection failed to $db_name" 8 45
	#red "connection failed"
	 echo $PWD
        . ./main.sh	
        
fi

