#!/bin/sh



# $LINECOUNT =
# 2 if none
# >2 if yes
LINECOUNT=$(adb devices|wc -l)


if [ $LINECOUNT -gt 2 ] 
then
	echo "YES!"
else
	echo "NO!"
fi 
