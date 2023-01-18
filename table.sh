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
                 #green "Create Table"
                 selectedOpt=$(whiptail --title "List DataBases" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
                 #green $tableName
             
            ;;
            2)
                #green "List Tables"
                echo $PWD
                tableNo=$(ls | cut -f1 -d" " | wc -l)
	   	 if (("$tableNo" == 0 ))
	   	 then
			tableNo='No tables exist in this DataBase'
	   	else
			tableList=$(ls)
	    	fi
		whiptail --title "List of Table" --scrolltext --msgbox "$tableListNo\n$tabeList" 30 45 
		showTableMenu
            ;;
            3)
                #green "Drop Table"
		dropTable=$(whiptail --title "Delete Table" --inputbox "Enter table name" 8 45 3>&1 1>&2 2>&3)
		. ../../droptable.sh
		showTableMenu
            ;;
            4)
                #green "Insert Into Table"
                . ../insertdata.sh
	        showTableMenu
            ;;
            5)
            	#green "Select From Table"
            	. ../selectmenu.sh
            ;;
            6)
                #green "Delete From Table"
                . ../deleterecord.sh
            ;;
            7)
                #green "Update Table"
                . ../updatetable.sh
            ;;
            8)
                #green "Back to Main Menu"
                cd ..
                . ../main.sh
            ;;
esac
}
		
showTableMenu
