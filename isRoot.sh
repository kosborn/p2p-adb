#!/bin/sh


WHOAMI=$(adb shell whoami | tr -d "\r" )

if [ "$WHOAMI" = "root" ] 
then
	echo "Running as root"
	return 0
elif [ "$WHOAMI" = "shell" ]
then
	echo "Running as shell"
	return 2
else
	echo "WHAT AM I???"
	return 1
fi

