#!/bin/bash
echo "welcome to Data Base"
PS3='Please enter your choice: '
options=("Create DB" "List DB" "Connect to DB" "Drop DB" "Exit")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
            echo "you chose choice 1"
            ;;
        2)
            echo "you chose choice 2"
            ;;
        3)
            echo "you chose choice $REPLY which is $opt"
            ;;
        4)
            echo "4"
            ;;
	5) break
	     ;;
        *) echo "invalid option $REPLY";;
    esac
done
