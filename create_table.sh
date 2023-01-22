#!/bin/bash
yellow "Creating New Table" 
#db_name="nader" #FOR TESTING
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
					# TO Save Data
				    echo  $colName >> "db/$db_name/$table_name";
				    # TO Save MetaData
				    echo  $colName$sep$datatype$sep$isPrimary >> $table_name;

				else
				      # TO Save Data
      				      echo -n $colName$sep >> "db/$db_name/$table_name"; 
				      # TO Save MetaData
				      echo  $colName$sep$datatype$sep$isPrimary$sep >> $table_name; 
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