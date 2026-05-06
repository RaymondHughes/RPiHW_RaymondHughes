#!/bin/bash
echo "Activating Webpage Updater"

FILE="solar_log.txt"

while [[ true ]]; do
	echo "Updating Webpage..."
	python "make_solar_plot.py" "$FILE"
	firefox ./html_temp.html &

		

	sleep 5
done
