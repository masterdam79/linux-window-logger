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
	currentDateShort=`date "+%Y%m%d"`
	currentDateLong=`date "+%Y-%m-%d"`

	# 2013-01-17 15:17:57
	currentTimestamp=`date -d "${currentDateLong} ${currentTime}" "+%s"`


	if [ "${currentWindowTitle}" != "${oldWindowTitle}" ]
	then
		if [ -f ~/LOG/`date +%y%m%d`.log ]
		then
			lastTime=$(tail -1 ~/LOG/${currentDateShort}.log | awk '{print $1}')
			lastTimestamp=`date -d "${currentDateLong} ${lastTime}" "+%s"`
			timeDifferenceSeconds=$((currentTimestamp-lastTimestamp))
		fi
		echo "${currentTime} ${timeDifferenceSeconds} ${currentWindowTitle}" >> ~/LOG/${currentDateShort}.log
	fi
	oldWindowTitle=${currentWindowTitle}
	sleep 1
done
