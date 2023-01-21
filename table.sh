#!/bin/bash
. functions.sh

function showTableMenu (){
selectedOpt=$(whiptail --title "Table Menu" --fb --menu "select options:" 17 60 0\
            "1" "Create Table" \
            "2" "List Tables" \
            "3" "Drop Table" \
            "4" "Insert Into Table" \
            "5" "Select from Table" \
            "6" "Delete from Table" \
            "7" "Update Table" \
            "8" "Back to Main Menu" 3>&1 1>&2 2>&3)

            case $selectedOpt in
            1)
                 . create_table.sh 
                 . table.sh            
            ;;
            2)
                #green "List Tables"
                tableNo=$(ls db/$db_name | cut -f1 -d" " | wc -l)
                clear
	   	         if (( "$tableNo" == 0 ))
	   	         then
			        tableNo='No tables exist in this DataBase'
	         	else
		        	tableList=$(ls db/$db_name)
	        	fi
		        whiptail --title "List of Table" --scrolltext --msgbox "$tableNo\n$tableList" 30 35 
		        showTableMenu
            ;;
            3)
                #green "Drop Table"
		        dropTable=$(whiptail --title "Delete Table" --inputbox "Enter table name" 8 45 3>&1 1>&2 2>&3)
		        . droptable.sh
		        showTableMenu
            ;;
            4)
                #green "Insert Into Table"
                . insert.sh
                . table.sh
            ;;
            5)
            	#green "Select From Table"
            	. select.sh
            ;;
            6)
                #green "Delete From Table"
                . deleterecord.sh
            ;;
            7)
                #green "Update Table"
                . updatetable.sh
            ;;
            8)
                #green "Back to Main Menu"
                . main.sh
            ;;
esac
}
		
showTableMenu
