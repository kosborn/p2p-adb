# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# If adb is not in your $PATH, configure it with the line below
#alias adb=/home/usr/bin/adb

. ./functions.sh

echo "${bold}Welcome to p2p-adb!${none}"
echo "Let's break some stuff."



prompt(){
	if [ "$(isConnected)" = 'NO' ]; then
		echo "Waiting for phone to connect..."
		# probably a better way to do this... but I don't care!!
		#while [ "$(isConnected)" = 'NO' ]; do
		#	sleep .1
		#done

		# Found it! Hopefully this won't cause issues 
		adb wait-for-device

	fi

	echo "What do you want to do today?
	0) Check if root
	1) Steal App data
	2) Steal Google data
	3) Steal Camera Photos
	4) Steal JPGs > 200k
	x) Exit
	"
	echo -n "Choose wisely: " 
	read REPLY

	case "$REPLY" in
	 0) isRoot ;;
	 1) echo "STEAL ALL THE DATAZ" && . ./getData.sh ;;
	 2) echo "Steal only Google dataz!" && . ./getGoogleData.sh ;; 
	 3) echo "GRAB DEM PHOTOS" && . ./getPhotos.sh ;;
	 4) echo "I GAVE THAT BITCH A JPG" && . ./getJpgs.sh ;;
	 'x'|'X') echo "Buh-bye!" && exit ;;
	 *) echo "${bold}That's not an answer!${none}\n" &&  prompt ;;
	esac
	echo ""
	prompt
}

prompt
