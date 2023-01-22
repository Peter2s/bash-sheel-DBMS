#!/bin/bash
#db_name="nader" #FOR TESTING
checktablename=$(whiptail --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

if ! [[ -f $checktablename ]]; then
	whiptail --title "Error Message" --msgbox "Table $checktablename you entered doesn't exist, choose another one " 8 45
       checktablename=$(whiptail --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
fi


checkcolsno=`awk 'END {print NR}' $checktablename` # check in metadata file
sep=":"
echo $checkcolsno




for (( i=1 ; i <= $checkcolsno ; i++ )); do
	#LOAD FROM METADATA
	checkcolname=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' $checktablename` # id , name, ... => col Name
	checkdatatype=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' $checktablename`  # int or str or boolen
	checkisprimary=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' $checktablename` #PK OR ""
	
	record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
	
	validte $checkdatatype # validte on data type 
	
	echo "checkcolname=$checkcolname"

	if [[ $checkisprimary == "PK" ]]
	then

	echo $checkisprimary

		while [[ true ]]; do 
			if  [[ ! -z `awk -F"$sep" '{if(NR != 1 && $'$i'=="'$record'")print $'$i'}' db/$db_name/$checktablename` ]]; then
				
				whiptail --title "Error Message" --msgbox "Primary key can't be duplicated" 8 45

			   echo $record     

			else
				break;
			fi
		record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)
		done
	fi

	if ! [[ $i == $checkcolsno ]]; then

		echo -n $record$sep >> db/$db_name/$checktablename

		
	else
		echo $record >> db/$db_name/$checktablename
		
		whiptail --title "Success Message" --msgbox "Your record inserted successfully" 8 45
	fi

done
