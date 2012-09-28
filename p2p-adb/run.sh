# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# If adb is not in your $PATH, configure it with the line below
#alias adb=/home/usr/bin/adb

# If you don't need busybox (i.e. laptop), set this to 1
IGNOREBUSYBOX=0

. ./functions.sh


echo "${bold}Welcome to p2p-adb framework!${none}"
echo "Let's break some stuff."

RUNONCE=0
prompt(){
	deviceConnected=isConnected
	if [ "$(isConnected)" = 'NO' ]; then
		echo "Waiting for phone to connect..."
		# probably a better way to do this... but I don't care!!
		#while [ "$(isConnected)" = 'NO' ]; do
		#	sleep .1
		#done

		# Found it! Hopefully this won't cause issues 
		adb wait-for-device


	fi

	# check if we're root!
	# Note: This is here because sh's variable scopig doesn't go UP apparently...


	if [ $RUNONCE = 0 ]
	then
		ISROOT=$(isRoot noinfo)
		if [ "$ISROOT" = "1" ]
		then
			echo 'WE ARE THE ROOT!'
			RUNONCE=1
		fi
	fi

	echo "What do you want to do today?
	0) Check if root
	1) Steal App data
	2) Steal Google data
	3) Steal Camera Photos
	4) Steal JPGs > 200k
	5) Steal Accounts
	6) Install/Uninstall AntiGuard
	7) Root 4.x using adb race condition
	x) Exit
	"
	echo -n "Choose wisely: " 
	read REPLY

	case "$REPLY" in
	 0) isRoot info;;
	 1) echo "STEAL ALL THE DATAZ" && . ./getData.sh ;;
	 2) echo "Steal only Google dataz!" && . ./getGoogleData.sh ;; 
	 3) echo "GRAB DEM PHOTOS" && . ./getPhotos.sh ;;
	 4) echo "I GAVE THAT BITCH A JPG" && . ./getJpgs.sh ;;
	 5) echo "The good stuff.." && . ./getSensitive.sh ;;
	 6) echo "Unlocking Screen" && . ./installAnti.sh ;;
	 7) echo "Trying to root..." && . ./root4.x.sh ;;
	 'x'|'X') echo "Goodbye." && exit ;;
	 *) echo "${bold}That's not an answer!${none}\n" &&  prompt ;;
	esac
	echo ""
	prompt
}

prompt
