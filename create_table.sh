#!/bin/bash
. functions.sh
function getDataType(){
	datatypeMenu=$(whiptail --title "Data Type Menu " --fb --menu "select Data Type" 15 60 4 \
		"1" "int"\
		"2" "str"\
		"3" "bool" 3>&1 1>&2 2>&3)
		
	case $datatypeMenu in 
		1)datatype="int";;

		2)datatype="str";;
		
		3)datatype="bool";;
		
		*)datatype="";;
	esac
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


# -----------------------------------------------------------------------------
yellow "Creating New Table" 
db_name="nader" #FOR TESTING
if [[ -z $db_name ]] #Empty 
then
	whiptail --title "Create Table" --msgbox "Connect TO DB first" 8 45
	echo "Connect to DB first"
	. connectToDataBase.sh
elif [[ ! -d "db/$db_name" ]] # Not Exist or Not dir
then
	whiptail --title "Create Table" --msgbox "DB is not Exist" 8 45
	echo "DB is not Exist"
	. connectToDataBase.sh
else # DB Found
	getTableName
	echo "db/$db_name/$table_name"
	if [[ ! -z $table_name ]] # Table Created Successfully
	then
		green $table_name
		
		colsNum=$(whiptail --title "Table Is Valid" --inputbox "Enter columns number" 8 45 3>&1 1>&2 2>&3)
		echo $colsNum
		if [ $colsNum -gt 0 ]
		then	
			touch ./db/$db_name/$table_name
			whiptail --title "Create Table" --msgbox "Table [$table_name] successfully created." 8 45
			
			#----------------------------------------------------
			i=1
			datatype=""
			sep=":"
			isPrimary=""
			primarykeyMenu="2" # No PK in Menu
			tableInfo="$colName$sep$datatype$sep$isPrimary"

			while [ $i -le $colsNum ]
			do
				isPrimary=""
				colName=$(whiptail --title "column Name" --inputbox "Enter Column $i Name "  8 45 3>&1 1>&2 2>&3)

			     	getDataType

			  	if [[ $primarykeyMenu == "2" ]] # make sure there is one PK
			  	then
					  primarykeyMenu=$(whiptail --title "Primary Key Menu " --fb --menu "Is column primary key?" 15 60 4 \
						"1" "yes" \
						"2" "no" 3>&1 1>&2 2>&3)
					  case $primarykeyMenu in
						1)
							 isPrimary="PK"
							 ;;
						2)
							 isPrimary=""
							 ;;
					  esac
			  	fi
				if [[ $i -eq $colsNum ]]; then
				    echo  $colName >> $table_name;
				    echo  $colName$sep$datatype$sep$isPrimary >> "db/$db_name/$table_name";

				else
				      echo -n $colName$sep >> $table_name;
				      echo  $colName$sep$datatype$sep$isPrimary$sep >> "db/$db_name/$table_name";
				fi
					((i++)) # increase counter
						
			done	
			whiptail --title "Create table Message" --msgbox "You created $table_name sucessfully" 8 45
		#fi

			#-----------------------------------------------------
		else
			whiptail --title "Columns Error" --msgbox "can't create [$colsNum] colums it has to be more than 0." 8 45
		fi
		
	else # user cancel creation
		echo "creating Table Canceled by User."
		. connectToDataBase.sh
	fi
fi
