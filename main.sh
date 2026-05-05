#!/bin/bash
##Main Control Script for CPU Monitor
##Usage ./main.sh [THRESHOLD]
##by Raymond Hughes, 4/15/2026

#Set Up Kill Command
echo 'Activating RPi monitor, kill with ctrl+c'
trap 'echo "Closing all subprograms..."; kill 0' SIGINT

#Initialize conda
source ~/anaconda3/etc/profile.d/conda.sh
conda activate RPiHW

#Set Threshold if none given
zero=0

TEMP='-C'

if [[ $1 == '-F' || $2 == '-F' ]]; then
	TEMP='-F'
fi

#Run Dependent scripts and open webpage
./temp_monitor/temp_logger.sh $TEMP &
./temp_monitor/temp_plot_update.sh $TEMP &

wait