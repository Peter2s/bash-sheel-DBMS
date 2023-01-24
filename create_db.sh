#!/bin/bash
. functions.sh
clear
yellow "Creating New Database" 
while [ 1 ]
do
	#cyan "Enter DB name  [0 -> exit]: " 
	#read db_name 
	db_name=''
	db_name=$(whiptail --title "Create Databse" --inputbox "Enter DB name  [0 -> exit]: "  8 45 3>&1 1>&2 2>&3)
	if [[ $db_name == "0" ]] || [[ -z $db_name ]]
	then
		cyan "You Choose to exit."
		db_name=''
		break
	fi
	if [[ $db_name =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]
	then
		if [[ -d "db/$db_name" ]]
		then
			#clear
			red "$db_name is already exists please choice another name"
			whiptail --title "Create Databse" --msgbox "DataBase [$db_name] is already exists." 8 45
		else
			green "$db_name is valid"
			mkdir -p ./db/$db_name
			whiptail --title "Create Databse" --msgbox "DataBase [$db_name] successfully created." 8 45
			db_name=''
			break
		fi
	else
		clear
		if ! [[ $db_name =~ ^[a-zA-z] ]]
	 	then
			red "DB name Can't start with a non char"
			whiptail --title "Create Databse" --msgbox "DataBase [$db_name] isn't valid start with a character and no spaces in between." 8 45
			
		fi
		#if [[ $db_name =~ [[:space:]] ]]
		if [[ $db_name =~ *" "* ]] 
		then 
			red "DB name Can't Have any Spaces"
			whiptail --title "Create Databse" --msgbox "DataBase [$db_name] isn't valid start with a char and no spaces between." 8 45
			
		fi
		#red "please follow the rules of naming a dababase"
	fi
done
. main.sh
