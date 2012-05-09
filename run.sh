# p2p-adb
# 

. inc/*


echo "${bold}Welcome to p2p-adb!${offbold}"
echo "Let's break some stuff."



prompt(){
	echo "What do you want to do today?
	1) Steal app data
	2) Steal Google data
	3) Steal Photos
	x) Exit
	"
	read -p "Chose wisely: " REPLY

	case "$REPLY" in
	 1) echo "STEAL ALL THE DATAZ" && . ./getGoogleData.sh ;;
	 2) echo "Steal only Google dataz!" ;; 
	 3) echo "GRAB DEM PHOTOS" ;;
	 'x'|'X') echo "Buh-bye!" && exit ;;
	 *) echo "${bold}That's not an answer!${offbold}\n" &&  prompt ;;

	esac
}

prompt
