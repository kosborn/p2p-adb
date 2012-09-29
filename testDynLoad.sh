# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com

# THIS IS JUST A TEST SCRIPT TO MAKE SURE DYNAMIC MODULE LOAD IS OKAY.


# If adb is not in your $PATH, configure it with the line below
#alias adb=/home/usr/bin/adb

# If you don't need busybox (i.e. laptop), set this to 1
IGNOREBUSYBOX=0

commandList=""

. ./functions.sh

for modules in ./modules/*.sh; do
	. $modules
done



generateCommands

echo "Here is a list of commands: "


for i in $(echo $commandList|tr "@" "\n"|sort -n  ); do
	echo $i|awk -F: {'print $1") "$3'}|tr "_" " "
done

echo "Select a command:"
read userCommand
	deviceConnected=isConnected
	if [ "$(isConnected)" = 'NO' ]; then                                         eval $(echo '$COMMAND'$userCommand)
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
