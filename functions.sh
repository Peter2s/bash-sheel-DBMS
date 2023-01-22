#!/bin/bash
green () { echo -e "\033[0;32m$1\033[0m" ; }
red () { echo -e "\033[0;31m$1\033[0m" ; }
yellow () { echo -e "\033[0;33m$1\033[0m" ; }
cyan () { echo -e "\033[0;36m$1\033[0m" ; }
purple () { echo -e "\033[0;35m$1\033[0m" ; }
function getDataType(){
	datatypeMenu=$(whiptail --title "Data Type Menu " --fb --menu "select Data Type" 15 60 4 \
		"1" "int"\
		"2" "str"\
		"3" "bool" 3>&1 1>&2 2>&3)
		
	case $datatypeMenu in 
		1)datatype="int";;

		2)datatype="str";;
		
		3)datatype="boolean";;
		
		*)datatype="";;
	esac
}
function validte(){
	checkdatatype=$1
    if [[ $checkdatatype == "int" ]]; then

		while ! [[ $record =~ ^[0-9]+$ ]]; do
			whiptail --title "Error Message" --msgbox "Not integer, Enter Record Again" 8 45
			record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done
	elif [[ $checkdatatype == "boolean" ]]; then

	       while ! [[ $record = "true" || $record = "false" || $record = "TRUE" || $record = "FALSE" || $record = "True" || $record = "False" || $record = "yes" || $record = "no" ]]; do

	       		whiptail --title "Error Message" --msgbox "Not a boolean; Enter true , false , TRUE , FALSE , True , False , yes or no only" 8 45

	 		record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done
		echo $record
	fi
}
function getTableName(){
	# reset table name
	while [ 1 ]
	do
		table_name=$(whiptail --title "Create Table" --inputbox "Enter Table name  [0 -> exit]: "  8 45 3>&1 1>&2 2>&3)
		if [[ $table_name == "0" ]] # Exit
		then
			table_name="" # Reset Table Name
			break
		fi
		if [[ $table_name =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]] # Two Letter with char start no spaces
		then
			if [[ -f "db/$db_name/$table_name" ]] # if file exists
			then
				#clear
				red "$table_name is already exists please choice another name"
				whiptail --title "Create Table Message" --msgbox "Table [$table_name] is already exists." 8 45
			else # No File Exists
				green "$table_name is valid"
				#touch ./db/$db_name/$table_name
				#whiptail --title "Create Table" --msgbox "Table [$table_name] successfully created." 8 45
				break
			fi
		else # if Table Name is not formated well 
			#clear
			if ! [[ $table_name =~ ^[a-zA-z] ]] # Have a non char for start
		 	then
				red "DB name Can't start with a non char"
				whiptail --title "Create Table" --msgbox "DataBase [$table_name] isn't valid start with a character and no spaces in between." 8 45
				
			fi
			#if [[ $table_name == [[:space:]] ]]
			if [[ $table_name =~ *" "* ]] # Have any space
			then 
				red "DB name Can't Have any Spaces"
				whiptail --title "Create Table" --msgbox "Table [$table_name] isn't valid start with a char and no spaces between." 8 45
				
			fi
		fi
	done
}



