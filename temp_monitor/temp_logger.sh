#!/bin/bash
echo "Activating Temp Logger"
FILE1="temp_log.txt"
FILE2="solar_log.txt"

head1="Time,temp"
head2="Time,solar"
echo $head1 > $FILE1
echo $head2 > $FILE2

T=$"C"
if [[ $1 == "-f" || $1 == "-F" ]]; then
	T=$"f"
fi 

while true; do
	#echo 'Monitoring Temperature'
	#Monitor Time & Temp with python
	text=$(python tempmonitor.py "$T")
	printf "$text\n" >> $FILE1

	sleep .1
done
