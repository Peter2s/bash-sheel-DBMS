#!/bin/bash

tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
## check if table exist
if ! [[ -f db/$db_name/$tableName ]]; then
    whiptail --title "Error Message" --msgbox "Table not exist" 8 45
    . table.sh
else
    ## check if column exist
    colName=$(whiptail --title "Column Name" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
    checkColumnIsFound=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' db/$db_name/$tableName)
    # if column not exist
    if [[ $checkColumnIsFound == "" ]]; then
        whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
        . table.sh
    else
        ColumnName=$checkColumnIsFound
        ## get condition from user
        conditionValue=$(whiptail --title "Condition" --inputbox "Enter Your condition Value" 8 45 3>&1 1>&2 2>&3)
        ## check if selected cloumn has condition value
        condrecordNo=$(awk -F: '{if ($'$ColumnName'=="'$conditionValue'") print $'$ColumnName'}' db/$db_name/$tableName)
        recordNo=$(awk -F: '{if ($'$ColumnName'=="'$conditionValue'") {print NR}}' db/$db_name/$tableName)
        if [[ $condrecordNo == "" ]]; then
            whiptail --title "Error Message" --msgbox "This value not Exist" 8 45
        else
            ## check if the row not the first row
            if [[ $recordNo == 1 ]]; then
                whiptail --title "Error Message" --msgbox "This record can't be delete" 8 45
                . table.sh
            else
                ## get the feild name needing to update from user
                field=$(whiptail --title "Field To Update" --inputbox "enter column needing to updating" 8 45 3>&1 1>&2 2>&3)
                ## get filed number
                fieldNumber=$(awk -F: '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' db/$db_name/$tableName)
                ## check if the feild needing to update is exist
                if [[ $fieldNumber == "" ]]; then
                    whiptail --title "Error Message" --msgbox "Field Not found" 8 45
                    . table.sh
                else
                checkcolname=`awk 'BEGIN {FS=":"}{if ( NR=='$fieldNumber' ) print $1 }' "db/$db_name/.meta_$tableName"` # id , name, ... => col Name
	            checkdatatype=`awk 'BEGIN {FS=":"}{if ( NR=='$fieldNumber' ) print $2 }' "db/$db_name/.meta_$tableName"`  # int or str or boolen
	            checkisprimary=`awk 'BEGIN {FS=":"}{if ( NR=='$fieldNumber' ) print $3 }' "db/$db_name/.meta_$tableName"` #PK OR ""
                    ### call function ##
                    record=$(whiptail --title "Field Name" --inputbox "Enter new record" 8 45 3>&1 1>&2 2>&3)
                    validte  $checkdatatype
                    validtePrimaryKey
                    



                    #awk if (column=="condition") { gsub(old val,new val,feild number)
                    awk -F: '{
                                if ($"'$checkColumnIsFound'"=='$conditionValue') { 
                                    gsub("^[a-zA-z0-9]*","'$record'",$"'$fieldNumber'");
                                     print  $0 
                                }else
                                 print $0
                            }' OFS=":" db/$db_name/$tableName >db/$db_name/temp
                    #sed -i ''$recordNo's/'$oldrecord'/'$newrecord'/g' db/$db_name/$tableName
                    mv db/$db_name/temp db/$db_name/$tableName
                    whiptail --title "Record" --msgbox "record updated sucessfully" 8 45

                fi
            fi
        fi
    fi
    . table.sh
fi

function validtePrimaryKey(){
    if [[ $checkisprimary == "PK" ]]
	then
	echo $checkisprimary

		while [[ true ]]; do 
			if  [[ ! -z `awk -F: '{if(NR != 1 && $'$fieldNumber'=="'$record'")print $"$'record'"}' db/$db_name/$tableName` ]]; then
				
				whiptail --title "Error Message" --msgbox "Primary key can't be duplicated" 8 45

			   echo $record     

			else
				break;
			fi
            record=$(whiptail --title "Field Name" --inputbox "Enter new record" 8 45 3>&1 1>&2 2>&3)
		done
	fi
}
