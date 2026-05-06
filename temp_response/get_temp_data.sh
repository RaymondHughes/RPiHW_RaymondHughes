#!/bin/bash
echo "Activating Temp Logger"
FILE_HEAD="temp_log_"
FILE_TAIL=".txt"
FILE_NUM=1
head="Time,temp"


T=$"C"
if [[ $1 == "-f" || $1 == "-F" ]]; then
	T=$"f"
fi 

GET_DATA=true
TIME_INTERVAL=100000000 #This is 0.1s 

read -p "<enter> to take data"
while $GET_DATA; do
	#Make Data File
	FILE="$FILE_HEAD$FILE_NUM$FILE_TAIL"
	echo $head > $FILE

	echo Taking 1 minute of data

	TIME_ZERO=$(python -c "import time; print(int(time.time_ns()))")
	LASTTIME=$TIME_ZERO

	while true; do
		TIME=$(python -c "import time; print(int(time.time_ns()))")
		if [[ $((TIME-LASTTIME)) -lt $TIME_INTERVAL ]]; then
			continue
		fi
		#echo 'Monitoring Temperature'
		#Monitor Time & Temp with python
		text=$(python tempmonitor.py "$T")
		printf "$text\n" >> $FILE
		LASTTIME=$TIME
		if [[ $((TIME-TIME_ZERO)) -gt $((TIME_INTERVAL*60*10)) ]]; then
			break
		fi 
	done
	echo "collected $FILE_NUM temperature curves"
	read -p "<enter> to continue taking data or <q> + <enter> to quit" cont
	if [[ "$cont" == "q" ]]; then
		echo "quitting" 
		GET_DATA=false
	fi
	FILE_NUM=$((FILE_NUM+1))
done