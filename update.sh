#!/bin/bash

tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
    ## check if table exist
    if ! [[ -f $tableName ]]; 
    then
        whiptail --title "Error Message" --msgbox "Table not exist" 8 45
        . table.sh
    else
        ## check if column exist
        colName=$(whiptail --title "Column Name"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
        checkColumnIsFound=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' db/$db_name/$tableName)
        
        if [[ $checkColumnIsFound == "" ]];
        then
            whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
			. table.sh
        else
            ColumnName=$checkColumnIsFound
            echo "$ColumnName  ==%=%=  $checkColumnIsFound"
            ## read condition value
            conditionValue=$(whiptail --title "Column Record" --inputbox "Enter Your condition Value" 8 45 3>&1 1>&2 2>&3)       
            condrecordNo=$(awk -F: '{if ($'$ColumnName'=="'$conditionValue'") print $'$ColumnName'}' db/$db_name/$tableName)
			recordNo=$(awk -F: '{if ($'$ColumnName'=="'$conditionValue'") print NR}' db/$db_name/$tableName)
            echo "$condrecordNo === $db_name === $recordNo"
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
					checkfieldfound=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' db/$db_name/$tableName)
								
					if [[ $checkfieldfound == "" ]] ; 
                    then 
						whiptail --title "Error Message" --msgbox "Field Not found" 8 45
						. table.sh
					else
						newrecord=$(whiptail --title "Field Name" --inputbox "Enter new record" 8 45 3>&1 1>&2 2>&3)
						#recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$condvalue'") print NR}' $tableName)
						oldrecord=$(awk 'BEGIN{FS=":"}{if(NR=='$recordNo'){for(i=1;i<=NF;i++){if(i=='$checkfieldfound') print $i}}}' db/$db_name/$tableName)
                        sed -i ''$recordNo's/'$oldrecord'/'$newrecord'/g' db/$db_name/$tableName
                        whiptail --title "Record" --msgbox "record updated sucessfully" 8 45
									
					fi
                fi
            fi
		fi
        . table.sh
    fi