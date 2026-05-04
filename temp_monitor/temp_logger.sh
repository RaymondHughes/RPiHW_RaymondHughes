#!/bin/bash
echo "Activating Temp Logger"
FILE="temp_log.txt"

head="Time,temp"
echo $head > $FILE

T=$"C"
if [[ $1 == "-f" || $1 == "-F" ]]; then
	T=$"f"
fi 

while true; do
	echo 'Monitoring Temperature'
	#Monitor Time & Temp with python
	text=$(python tempmonitor.py "$T")

	printf "$text\n" >> $FILE

	sleep 0.1
done
