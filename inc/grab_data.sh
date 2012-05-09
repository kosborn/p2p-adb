#!/bin/sh

adb shell "tar -cf - $* 2>/dev/null" 
