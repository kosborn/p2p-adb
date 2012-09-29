# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com

adb shell pm list packages | grep io.kos.antiguard 2>/dev/null > /dev/null

isInstalled=$?


if [ $isInstalled -eq 0 ]; then
	adb uninstall io.kos.antiguard
else 
	adb install ./AntiGuard/AntiGuard.apk
	adb shell am start io.kos.antiguard/.unlock
fi
