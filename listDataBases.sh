#!/bin/bash
 dataBaseNo=$(ls -d */ | cut -f1 -d"/" | wc -l ) 
	    if (("$dataBaseNo" == 0 ))
	    then
		dataBaseList='No DataBase exist'
	   else
		dataBaseList=$(ls -d */ | cut -f1 -d'/')
	    fi
	    whiptail --title "List of DataBases" --msgbox "Number Of DataBases : $dataBaseNo \n$dataBaseList" 30 45
