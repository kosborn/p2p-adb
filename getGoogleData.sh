#!/bin/sh

sh ./isRoot.sh > /dev/null
ISROOT=$?

if [ $ISROOT -eq 0 ]; then
	DATAPATH='/data/data/com.google.*'
	echo 'We are root...'
	echo "Calculating size of: $DATAPAT/{shared_prefs|databases}/"
	SIZE=$(sh ./inc/data_size.sh "$DATAPATH")
	echo "The size of $DATAPATH is: $SIZE"
	echo -n 'Continue? [Y/n] '
	read REPLY
	if [ $REPLY = [yY] ]; then
		sh ./inc/grab_data "$DATAPATH"
	fi
else
	echo $ISROOT
fi

