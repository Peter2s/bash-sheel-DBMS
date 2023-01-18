#!/bin/bash
#db_name="nader" #FOR TESTING
checktablename=$(whiptail --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

if ! [[ -f $checktablename ]]; then
	whiptail --title "Error Message" --msgbox "Table $checktablename you entered doesn't exist, choose another one " 8 45
       checktablename=$(whiptail --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
fi


checkcolsno=`awk 'END {print NR}' $checktablename`
sep=":"
echo $checkcolsno




for (( i=1 ; i <= $checkcolsno ; i++ )); do
	#LOAD FROM METADATA
	checkcolname=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' $checktablename`
	checkdatatype=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' $checktablename`
	checkisprimary=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' $checktablename`
	
	record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)

	if [[ $checkdatatype == "int" ]]; then

		while ! [[ $record =~ ^[0-9]+$ ]]; do

			whiptail --title "Error Message" --msgbox "Not integer, Enter Record Again" 8 45

			record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)

		done

	#$booleancheck="[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]"

	elif [[ $checkdatatype == "boolean" ]]; then

	       while ! [[ $record = "true" || $record = "false" || $record = "TRUE" || $record = "FALSE" || $record = "True" || $record = "False" || $record = "yes" || $record = "no" ]]; do

	       		whiptail --title "Error Message" --msgbox "Not a boolean; Enter true , false , TRUE , FALSE , True , False , yes or no only" 8 45

	 		record=$(whiptail --title "Your Data" --inputbox "Enter data for $checkcolname with in data type ($checkdatatype)" 8 45 3>&1 1>&2 2>&3)

		done

		echo $record


	fi

	echo "checkcolname=$checkcolname"

	if [[ $checkisprimary == "PK" ]]
	then

	echo $checkisprimary

		while [[ true ]]; do 
			
			#if [[ $record =~ ^[`awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $checktablename`]$ ]]; then
			#awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1)print $1}' db/nader/asd
			#if [[ $record =~ ^[`awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' db/$db_name/$checktablename`]$ ]]; then
			#echo $i
			#echo $record
			#echo `awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1)print $'$i'}' db/$db_name/$checktablename`
			#echo `awk -F"$sep" '{if(NR != 1) print $'$i'}' db/$db_name/$checktablename`
			#echo `awk -F"$sep" '{if(NR != 1 && $'$i'=='$record')print $'$i'}' db/$db_name/$checktablename`
			#if [[ $record =~ ^[`awk -F"$sep" '{if(NR != 1)print $'$i'}' db/$db_name/$checktablename`]$ ]]; then
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
