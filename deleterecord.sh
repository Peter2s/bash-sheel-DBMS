#!/bin/bash

tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

if ! [[ -f $tableName ]]; 
then
    whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
    . table.sh
else

    columnName=$(whiptail --title "Column Name" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
    checkColumnIsFound=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$columnName'") print i}}}' db/$db_name/$tableName)

    if [[ $checkColumnIsFound == "" ]]; 
    then
        whiptail --title "Error Message" --msgbox "Column not exist" 8 45
    else
        value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
        recordNo=$(awk -F: '{if ($'$checkcolumnfound'=="'$value'") print NR}' db/$db_name/$tableName)
        if [[ $recordNo == 1 ]]; 
        then
            whiptail --title "Error Message" --msgbox "This record can't be delete" 8 45
        else
            if [[ $recordNo == "" ]]; 
            then
                whiptail --title "Error Message" --msgbox "Record not exist" 8 45
            else
                sed -i ''$recordNo'd' db/$db_name/$tableName
                whiptail --title "Record" --msgbox "record deleted sucessfully" 8 45
            fi
        fi
    fi

    . table.sh
fi
