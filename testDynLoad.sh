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

eval $(echo '$COMMAND'$userCommand)
