# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# Registering command
registerCommand "6:installAnti:Install/Uninstall AntiGuard"


installAnti(){
	adb shell pm list packages | grep io.kos.antiguard 2>/dev/null > /dev/null

	isInstalled=$?


	if [ $isInstalled -eq 0 ]; then
		adb uninstall io.kos.antiguard
	else 
		adb install ./AntiGuard/AntiGuard.apk
		adb shell am start -S io.kos.antiguard/.unlock
	fi
}
