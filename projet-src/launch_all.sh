#! /usr/bin/bash

if [ $# -ne 1 ]; then
    echo "J'ai besoin du temps d'execution!! Minimum 50000"
    exit 1
fi

if [ $1 -lt 50000 ]; then
    echo "J'aimerais un temps d'execution superieur ou égal à 50000"
    exit 1
fi

# getting data
./launch_script.sh 100 10 $1
./launch_script.sh 55 55 $1
./launch_script.sh 10 100 $1

# plotting
cd output
gnuplot 'waitingTime.gnu'
gnuplot 'msgPerCs.gnu'
gnuplot 'reqCount.gnu'
gnuplot 'statePercentages.gnu'
