#!/bin/bash
source ./functions
clear
yellow "Creating New Database" 
while [ 1 ]
do
read -p "Enter DB name : " db_name 

if [[ $db_name =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]
then
	if [[ -d $db_name ]]
	then
		clear
		red "$db_name is already exists please choice another name"
	else
		 green "$db_name is valid"
		break
	fi
else
	clear
	if ! [[ $db_name =~ ^[a-zA-z] ]]
	then
		red "DB name Can't start with a non char"
	fi
	if [[ $db_name =~ [[:space:]] ]]
	then 
		red "DB name Can't Have any Spaces"
	fi
	red "please follow the rules of naming a dababase"
fi
done
