#!/bin/bash
dataBaseNo=$(ls -d db/* | cut -f1 -d"/" | wc -l)
if (("$dataBaseNo" == 0 ))
then
	dataBaseList='No DataBase exist'
else
	dataBaseList=$(ls -d db/* | cut -f2 -d'/')
fi
#echo $dataBaseNo;
if [ $dataBaseNo -le 5 ]
then
	menu_cols=12
else
	((menu_cols=$dataBaseNo+8))
fi
#echo $dataBaseNo;
whiptail --title "List of DataBases" --scrolltext --msgbox "Number Of DataBases : $dataBaseNo \n$dataBaseList" $menu_cols 45
