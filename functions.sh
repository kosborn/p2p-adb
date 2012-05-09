# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# random config stuff here


none="\033[0m"
bold="\033[1m"
red="\033[0;31m"




# Let's just make sure ADB is available...

if adb version >/dev/null; then
	# good to go
	true
else 
	echo "${red}adb is not in your \$PATH"
	echo "Add it, or modify run.sh${none}"
	exit
fi


# Check to see if a device is connected
isConnected(){

	# $LINECOUNT =
	# 2 if none
	# >2 if yes
	LINECOUNT=$(adb devices|wc -l)


	if [ $LINECOUNT -gt 2 ] 
	then
		echo "YES"
		return 0
	else
		echo "NO"
		return 1
	fi 
}


# Check to see if we're root on the device
isRoot(){
	WHOAMI=$(adb shell whoami | tr -d "\r" )

	if [ "$WHOAMI" = "root" ] 
	then
		echo "Running as root"
		return 0
	elif [ "$WHOAMI" = "shell" ]
	then
		echo "Running as shell"
		return 2
	else
		# Let's try something else
		if [ "$(adb shell id | tr -d '\r' )" = 'uid=0(root) gid=0(root)' ]; then
			echo "Running as root"
			return 0
		#elif [ "$(adb ls /data/data/" | tr -d '\r\)" = ????? ];   // This is probably something we can do too, I just don't have a non-rooted phone
		else
			echo $WHOAMI
			echo "WHAT AM I???"
			return 1
		fi
	fi
}


# Check the size of a directory or more
dataSize(){
	adb shell "du -hc $*" | tail -n1
}


# Prepare to get the directory passed in the argument
getData(){
	DATAPATH="$*"
	echo "Calculating size of: $DATAPATH"
	SIZE=$(dataSize "$DATAPATH")
	echo "The size of $DATAPATH is: $SIZE"
	read -p 'Continue? [Y/n] ' REPLY
	case "$REPLY" in
	 y|Y|'') getDataProto "$DATAPATH"  ;;
	 n|N) echo "Cancelling..." ;; 
	 *) echo "Cancelling..." ;;
	esac
}

# Actually get the file
getDataProto(){
	FILENAME=jacked_$(date +%s).tar
	adb shell "tar -cf - $* 2>/dev/null" > $FILENAME
	echo "The file has been saved as $FILENAME"
}


