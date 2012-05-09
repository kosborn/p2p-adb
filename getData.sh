#!/bin/sh

sh ./isRoot.sh > /dev/null
ISROOT=$?

if [ $ISROOT -eq 2  ]; then 
	echo 'We are user shell!'
	echo 'Whoever, we can grab contents for /sdcard/Android/data'
	DATAPATH="/sdcard/Android/data/*"
	echo "Calculating size of: $DATAPATH/{shared_prefs|databases}/"
	SIZE=$(sh ./inc/data_size.sh "$DATAPATH")
	echo "The size of $DATAPATH is: $SIZE"
	echo -n 'Continue? [Y/n] '
	read REPLY
	[[ $REPLY = [yY] ]] && sh ./inc/grab_data "$DATAPATH" || echo "Cancelling..."
elif [ $ISROOT -eq 0 ]; then
	DATAPATH="/data/data/*"
	echo 'We are root...'
	echo "Calculating size of: $DATAPATH/{shared_prefs|databases}/"
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

