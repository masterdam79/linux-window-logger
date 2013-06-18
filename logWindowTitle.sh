#!/bin/bash

if [ ! -d ~/LOG ]
then
	mkdir ~/LOG
fi


while true
do
	# Get current window title
	currentWindowTitle=`xwininfo -id $(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}') | grep xwininfo | sed 's/xwininfo: Window id: //g' | sed -e 's/0x....... //g' | sed 's/"//g'`

	# Format datestamp
	currentTime=`date "+%H:%M:%S"`
	currentDate=`date "+%Y%m%d"`

	# 2013-01-17 15:17:57
	currentTimestamp=`date "+%Y-%m-%d %H:%M:%S"`

	if [ "${currentWindowTitle}" != "${oldWindowTitle}" ]
	then
		echo "${currentTime} ${currentWindowTitle}" >> ~/LOG/`date +%y%m%d`.log
	fi
	oldWindowTitle=${currentWindowTitle}
	sleep 1
done
