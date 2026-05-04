#!/bin/bash
##Main Control Script for CPU Monitor
##Usage ./main.sh [THRESHOLD]
##by Raymond Hughes, 4/15/2026

#Set Up Kill Command
echo 'Activating CPU monitor, kill with ctrl+c'
trap 'echo "Closing all subprograms..."; kill 0' SIGINT

#Initialize conda
source ~/anaconda3/etc/profile.d/conda.sh
conda activate 

#Set Threshold if none given
zero=0
if [ $# -gt $zero ]; then
	THRESHOLD=$1
else
	THRESHOLD=90
fi

#Run Dependent scripts and open webpage
./logger.sh &
./monitor.sh $THRESHOLD &
sleep 7
xdg-open ~/Phys129L/monitor/htmlcpu.html &

wait