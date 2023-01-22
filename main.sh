#!/bin/bash
. function.sh
function showMenu() {
    selectedOpt=$(whiptail --title "Main Menu" --fb --menu "Choose an option" 15 60 4 \
        "1" "Create DataBase" \
        "2" "List DataBases" \
        "3" "Connect To DataBase"\
        "4" "Drop DataBase" 3>&1 1>&2 2>&3)
    case $selectedOpt in
        1)
            . create_db.sh
        ;;
        2)
        	. listDataBases.sh
         	showMenu               
        ;;
        3)
        	. connectToDataBase.sh
        ;;
        4)
        	. dropDataBase.sh
        	showMenu
        ;;
    esac
}
showMenu
