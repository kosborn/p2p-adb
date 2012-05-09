#!/bin/sh

echo $1
adb shell du -hc $1/shared_prefs $1/databases/ | tail -n1
