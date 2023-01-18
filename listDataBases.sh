#!/bin/bash
dataBaseNo=$(ls -d db/* | cut -f1 -d"/" | wc -l)
	    if (("$dataBaseNo" == 0 ))
	    then
		dataBaseList='No DataBase exist'
	   else
		dataBaseList=$(ls -d db/* | cut -f2 -d'/')
	    fi
	    whiptail --title "List of DataBases" --scrolltext --msgbox "Number Of DataBases : $dataBaseNo \n$dataBaseList" 30 45
