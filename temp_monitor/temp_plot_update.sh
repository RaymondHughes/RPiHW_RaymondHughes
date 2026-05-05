#!/bin/bash
echo "Activating Webpage Updater"

FILE="temp_log.txt"
ALARM=0
DEG=$1

while [[ true ]]; do
	echo "Updating Webpage..."
	python "make_temp_plot.py" "$FILE" "$DEG"
	xdg-open ~/Phys129L/RPiHW_RaymondHughes/temp_monitor/html_temp.html &
		

	sleep 5
done
