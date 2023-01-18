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
            echo "List DataBases"
            echo "List & Number of  DataBases"
	    databaselist=$(ls -d */)
            databaseNo=$(ls -d */ | cut -f1 -d"/" | wc -l)
	    whiptail --title "Number of DataBases" --msgbox "Number of DataBases is : ${ls -d */}" 8 45
            whiptail --title "List of DataBases" --msgbox "$databaselist" 10 45
	    showMenu
                        
        ;;
        3)
            echo "connect To DataBase"
        ;;
    esac
}
showMenu
