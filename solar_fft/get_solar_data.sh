#!/bin/bash
echo "Activating Solar Logger"
FILE_HEAD="solar_log_"
FILE_TAIL=".txt"

head="Time,solar"
GET_DATA=true
read -p "Enter Sampling Period (seconds)" PERIOD
while $GET_DATA; do
	TIME_ZERO=$(python -c "import time; print(int(time.time()))")
	LASTTIME=$TIME_ZERO
	#Make File
	FILE="$FILE_HEAD$PERIOD$FILE_TAIL"
	echo $head > $FILE

	while true; do
			TIME=$(python -c "import time; print(int(time.time()))")
		if [[ $((TIME-LASTTIME)) -lt $PERIOD ]]; then
			continue
		fi
		#echo 'Monitoring Solar'
		#Monitor Time & Solar with python
		text=$(python solar_monitor.py)
		printf "$text\n" >> $FILE2
		LASTTIME=$TIME
		if [[ $((TIME-TIME_ZERO)) -gt 30 ]]; then
			break
		fi 

	done

	read -p "Enter Sampling Period (seconds), or <q> to quit" PERIOD
	if [[ "$PERIOD" == "q" ]]; then
		echo "quitting" 
		GET_DATA=false
	fi

done
