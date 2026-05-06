#!/bin/bash
echo "Activating Solar Logger"
FILE2="solar_log.txt"

head2="Time,solar"
echo $head2 > $FILE2

while true; do
	#echo 'Monitoring Solar'
	#Monitor Time & Solar with python
	text=$(python solar_monitor.py)
	printf "$text\n" >> $FILE2

	sleep .1
done
