#!/bin/bash

if [[ -f $dropTable ]]; then

	rm $dropTable
	rm .$dropTable
	whiptail --title "Delete table Message" --msgbox "You deleted $dropTable sucessfully" 8 45
	#echo "You deleted $droptable sucessfully"
else
	whiptail --title "Delete table Message" --msgbox "Faild to delete table $dropTable " 8 45
	#echo "Faild to delete table"
fi
