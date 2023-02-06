#!/bin/bash
. functions.sh

function selectMenu () {
selectMenu=$(whiptail --title "Select Menu" --fb --menu "select options:" 17 60 0\
            "1" "Select All Columns" \
            "2" "Select Specific Column" \
            "3" "Select  Where Condition" \
            "4" "Back to Table Menu" \
            "5" "Back to Main Menu" 3>&1 1>&2 2>&3)

            case $selectMenu in
            1)
                #green "Select All"
                tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
				if ! [[ -f db/$db_name/$tableName ]]; 
                then 
				    whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
				    selectMenu
				else
					tablerecord=$(cat db/$db_name/$tableName)
					whiptail --title "Table Records" --scrolltext --msgbox "$tablerecord" 30 50
					selectMenu
				fi	
            ;;
            2)
                #green "Select Specific Column"	 
				tableName=$(whiptail --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
                                        
				if ! [[ -f db/$db_name/$tableName ]]; 
                then                        
					whiptail --title "Error Message" --msgbox "Table not exist" 8 45                            
					selectMenu
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

                #echo " after cehck $checkColumnIsFound"
				if [[ $checkColumnIsFound == "" ]];
                then
					whiptail --title "Error Message" --msgbox "Column not exist" 8 45
				else
					columnRecord=$(awk -F: '{print $"'$checkColumnIsFound'"}' db/$db_name/$tableName)
					#echo $columnRecord
					whiptail --title "Column $colName" --scrolltext  --msgbox "$columnRecord" 30 50
				fi
                selectMenu
                fi
            ;;
            3)
            #green "Select with Where Condition"
            . selectWhere.sh 
            ;;
            4)
            #green "Back to Table Menu"
            . table.sh
			;;
            5)
            #green "Back to Main Menu"
  
            . main.sh
            ;;
            esac
}

selectMenu
