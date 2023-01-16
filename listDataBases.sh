#!/bin/bash
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
		$loc/main.sh
	fi
else
	echo $Msg
	$loc/main.sh
fi
	

