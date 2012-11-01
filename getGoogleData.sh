# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com





if [ $ISROOT -le 2 ]; then
	DATAPATH='/data/data/com.google.*/{shared_prefs,databases}/'
	echo 'We are root...'
	getData "$DATAPATH"
else
	echo "$ISROOT"
fi

