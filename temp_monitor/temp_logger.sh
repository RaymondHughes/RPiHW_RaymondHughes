#!/bin/bash
echo "Activating Temp Logger"
FILE1="temp_log.txt"

head1="Time,temp"
echo $head1 > $FILE1

T=$"C"
if [[ $1 == "-f" || $1 == "-F" ]]; then
	T=$"f"
fi 

while true; do
	echo 'Monitoring Temperature'
	#Monitor Time & Temp with python
	text=$(python temp_monitor/tempmonitor.py "$T")
	printf "$text\n" >> $FILE

	sleep 0.1
done
