#!/bin/bash
./funcations.sh
loc=$PWD
dataBasePath=$HOME/db
Msg=" no Data Bases Exist"
if [ -d $dataBasePath ]
then
	cd $dataBasePath
	dataBasesCount=$(ls -d */ | wc -l)
	if [ $dataBasesCount -eq 1 ]
	then
		echo $Msg
		$loc/main.sh
	else
		echo "number of DataBases is : ${dataBasesCount}"
		ls -d */ | cut -f1 -d'/'
	fi
else
	echo $Msg
	$loc/main.sh
fi
value=(Choice1 "" Choice2 "" Choice3 "" Choice4 "")
#whiptail --title "xx" --menu "choose" 16 78 10 "${value[@]}"
function showMenu() {
    selectedOpt=$(whiptail --title "Main Menu" --fb --menu "Choose an option" 15 60 4 "${value[@]}
    case $selectedOpt in
        1)
            echo "Craete DataBase"
        ;;
        2)
            echo "List DataBases"
            ./listDataBases.sh
        ;;
        3)
            echo "connect To DataBase"
        ;;
    esac
}
showMenu
~                                                                                                                                           
~                                                                                                                                           
~                                                                                                                                           
~                                                                                                                                           
~                 
