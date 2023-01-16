#!/bin/bash
dataBasePath=$HOME/db
Msg=" no Data Bases Exist"
if [ -d $dataBasePath ]
then
	dataBasesCount=$(ls -d $dataBasePath | wc -l)
	if [ $dataBasesCount -eq 1 ]
	then
		echo $Msg
		./main.sh
	else
		ls -d $dataBasePath/*
	fi
else
	echo $Msg
	./main.sh
fi
	

