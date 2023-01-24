#!/bin/bash
dropName=$(whiptail --title "Drop DataBase" --inputbox "Enter your DataBase name to delete" 8 45 3>&1 1>&2 2>&3)
if [[ -z $dropName ]]; 
then
	whiptail --title "Drop Databse Message" --msgbox "not data selected $dropName" 8 45
else
	if [[ -d db/$dropName ]]; 
	then
	rm -R db/$dropName
	whiptail --title "Drop Databse Message" --msgbox "You deleted $dropName database secessfully" 8 45
	#green "You deleted $dropName database secessfully"
	else 
		whiptail --title "Drop Databse Message" --msgbox "Error can't delete $dropName" 8 45
	fi

fi
