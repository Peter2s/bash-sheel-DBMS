#!/bin.bash
     tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
    if ! [[ -f $tableName ]]; 
    then
        whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
        . select.sh
    else
        colName=$(whiptail --title "Table Column"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
					checkColumnIsFound=$(awk -F: '
                    {
                        if(NR==1)
                        {
                            for(i=1;i<=NF;i++)
                            {
                            if($i=="'$colName'")
                                print i
                            }
                        }
                    }' db/$db_name/$tableName)

        if [[ checkColumnIsFound == "" ]]; 
        then
            whiptail --title "Error Message" --msgbox "Column not exist" 8 45
        else
        colName=$checkColumnIsFound
        ## table is exist and colName is exist
            value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
        ## check if value == record => print it
            record=$(awk -F: '
                            {
                            if ($'$colName'=="'$value'")  
                                print $0 
                                }' db/$db_name/$tableName) 
            
            if [[ $record == "" ]] ; 
            then
                whiptail --title "Error Message" --msgbox "Record not found" 8 45
            else
                whiptail --title "Record" --scrolltext --msgbox "$record" 15 45
            fi
        fi
	. select.sh
    fi