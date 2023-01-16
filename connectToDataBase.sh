#!/bin/bash
echo "please enter your database name"
read -p dataBaseName
if [ -f $HOME/db/$dataBaseName ]
then
	cd $HOME/db/$dataBaseName
else
	echo "no data base exist"
	./main.sh
fi
