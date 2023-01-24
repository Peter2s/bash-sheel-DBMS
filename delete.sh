#!/bin/bash
table_name=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

if ! [[ -f "db/$db_name/$table_name" ]]; then
	whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45

	. table.sh
else

	colname=$(whiptail --title "Table Records" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
	checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' "db/$db_name/$table_name")
	echo $checkcolumnfound
	if [[ $checkcolumnfound == "" ]]; then
		whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
	else

		value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
		echo $value
		recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$value'") print NR}' "db/$db_name/$table_name")
		rm
		echo $recordNo
		if [[ $recordNo == 1 ]]; then
			whiptail --title "Error Message" --msgbox "This record can't be delete" 8 45
		else
			if [[ $recordNo == "" ]]; then
				whiptail --title "Error Message" --msgbox "Record doesn't exist" 8 45
			else
				#sed -i "$recordNo d" "db/$db_name/$table_name"
				awk -F: '{if ($'$checkcolumnfound'!="'$value'") print $0}' "db/$db_name/$table_name" >"temp.txt"
				rm "db/$db_name/$table_name" 2>/dev/null
				mv "temp.txt" "db/$db_name/$table_name"
				whiptail --title "Record" --msgbox "record deleted sucessfully" 8 45
			fi
		fi
	fi
	. table.sh
fi
