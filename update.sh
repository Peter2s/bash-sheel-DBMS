#!/bin/bash

tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
    if ! [[ -f $tableName ]]; 
    then
        whiptail --title "Error Message" --msgbox "Table not exist" 8 45
        . table.sh
    else
        colname=$(whiptail --title "Column Name"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
        checkcolumnfound=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)
        
        if [[ $checkcolumnfound == "" ]];
        then
            whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
			. table.sh

        else
            condvalue=$(whiptail --title "Column Record" --inputbox "Enter Your condition Value" 8 45 3>&1 1>&2 2>&3)
            condrecordNo=$(awk -F: '{if ($'$checkcolumnfound'=="'$condvalue'") print $'$checkcolumnfound'}' $tableName)
			recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$condvalue'") print NR}' $tableName)
			if [[ $condrecordNo == "" ]];
            then
				whiptail --title "Error Message" --msgbox "This value not Exist" 8 45
			else
				if [[ $recordNo == 1 ]] ; 
                then
                    whiptail --title "Error Message" --msgbox "This record can't be delete" 8 45
					. table.sh
                else
					field=$(whiptail --title "Field Name" --inputbox "Enter field name" 8 45 3>&1 1>&2 2>&3)
					checkfieldfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
								
					if [[ $checkfieldfound == "" ]] ; 
                    then 
						whiptail --title "Error Message" --msgbox "Field Not found" 8 45
						. table.sh
					else
						newrecord=$(whiptail --title "Field Name" --inputbox "Enter new record" 8 45 3>&1 1>&2 2>&3)
						#recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$condvalue'") print NR}' $tableName)
						oldrecord=$(awk 'BEGIN{FS=":"}{if(NR=='$recordNo'){for(i=1;i<=NF;i++){if(i=='$checkfieldfound') print $i}}}' $tableName)
                        sed -i ''$recordNo's/'$oldrecord'/'$newrecord'/g' $tableName
                        whiptail --title "Record" --msgbox "record updated sucessfully" 8 45
									
					fi
                fi
            fi
		fi
        . table.sh
    fi