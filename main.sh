#!/bin/bash
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
            dataBaseNo=$(ls -d */ | cut -f1 -d"/" | wc -l)
	    if (("$dataBaseNo" == 0 ))
	    then
		dataBaseList='No DataBase exist'
	   else
		dataBaseList=$(ls -d */ | cut -f1 -d'/')
	    fi
	    whiptail --title "List of DataBases" --msgbox "Number Of DataBases : $dataBaseNo \n$dataBaseList" 10 45
	    showMenu
                        
        ;;
        3)
            echo "connect To DataBase"
        ;;
    esac
}
showMenu
