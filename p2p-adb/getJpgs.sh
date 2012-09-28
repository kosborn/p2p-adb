# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com



DIREXISTS=$(adb shell '[[ -d /sdcard/DCIM/Camera/  ]] && echo 1' | tr -d "\r")

if [ "$DIREXISTS" = "1" ]; then
	DATAPATH='/sdcard/DCIM/Camera'
	getSearch "$DATAPATH" "*.jpg" "+200k"
else
	echo "Camera directory doesn't exist?"
fi

