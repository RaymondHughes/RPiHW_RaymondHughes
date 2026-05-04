#!/bin/bash
echo "Activating Webpage Updater"

FILE="cpu_log.txt"
ALARM=0
if [ $# -lt 1 ]; then 
	THRESHOLD=90 
else 
	THRESHOLD=$1 
fi

while [[ true ]]; do
	echo "Updating Webpage..."
	python "make_cpu_plot.py" "$FILE"

	LAST=$(tail -1 "$FILE")
	TIME=$(python -c "import time; print(int(time.time()))")
	LAST_TIME=$(python -c "import sys; print( (sys.argv[1]).split(',')[0])" "$LAST")
	LAST_CPU=$(python -c "import sys; print( ((sys.argv[1]).split(',')[1]).split('.')[0] )" "$LAST")

	TIME_CHECK=$((TIME-LAST_TIME))

	if [[ $TIME_CHECK -gt 60 || $LAST_CPU -gt $THRESHOLD ]]; then
		echo "Problem found! Alerting..."
		cat htmlcpu_alert.html > htmlcpu.html
		xdg-open ~/Phys129L/monitor/htmlcpu.html &

	else
		
		cat htmlcpu_calm.html > htmlcpu.html
	fi
		

	sleep 5
done
