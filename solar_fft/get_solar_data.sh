#!/bin/bash
echo "Activating Solar Logger"
FILE_HEAD="solar_log_"
FILE_TAIL=".txt"
FILE_NUM=1
head="Time,solar"
GET_DATA=true
read -p "Enter Sampling Period (seconds)" PERIOD
while $GET_DATA; do
	TIME_ZERO=$(python -c "import time; print(int(time.time()))")
	LASTTIME=$TIME_ZERO
	#Make File
	FILE="$FILE_HEAD$FILE_NUM$FILE_TAIL"
	echo $head > $FILE

	echo "getting 30 seconds of data..."
	while true; do
		TIME=$(python -c "import time; print(int(time.time()))")
		INTERVAL=$((TIME-LASTTIME))
		if [[ 1 -eq "$(echo "$INTERVAL<$PERIOD" | bc)" ]]; then
			continue
		fi
		#echo 'Monitoring Solar'
		#Monitor Time & Solar with python
		text=$(python solar_monitor.py)
		printf "$text\n" >> $FILE
		LASTTIME=$TIME
		if [[ $((TIME-TIME_ZERO)) -gt 30 ]]; then
			break
		fi 

	done

	read -p "Enter Sampling Period (seconds), or <q> to quit" PERIOD
	if [[ "$PERIOD" == "q" ]]; then
		echo "quitting" 
		GET_DATA=false
		break
	fi
	FILE_NUM=$((FILE_NUM+1))
done
