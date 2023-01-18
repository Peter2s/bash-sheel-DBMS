#!/bin/bash
function showMenu() {
    selectedOpt=$(whiptail --title "Main Menu" --fb --menu "Choose an option" 15 60 4 \
        "1" "Craete DataBase" \
        "2" "List DataBases" \
        "3" "Connect To DataBase"\
        "4" "Drop DataBase" 3>&1 1>&2 2>&3)
    case $selectedOpt in
        1)
            echo "Craete DataBase"
        ;;
        2)
           ./listDataBases.sh
	    showMenu    
        ;;
        3)
        ./connecToDB.sh  
        ;;
        4)
        ;;
    esac
}
showMenu
