#!/bin/bash
echo "welcome to Data Base"
PS3='Please enter your choice: '
options=("Create DB" "List DB" "Connect to DB" "Drop DB" "Exit")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
            echo "1"
            ;;
        2)
	    ./listDataBases.sh
            ;;
        3)
            ./connectToDataBase.sh 
            ;;
        4)
            echo "4"
            ;;
	5) break
	     ;;
        *) echo "invalid option $REPLY";;
    esac
done
