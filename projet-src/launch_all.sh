#! /usr/bin/bash

if [ $# -ne 1 ]; then
    echo "J'ai besoin du temps d'execution!!"
    exit 1
fi
# getting data
./launch_script.sh 400 1 $1
./launch_script.sh 350 350 $1
./launch_script.sh 10 400 $1

# plotting
cd output
gnuplot 'waitingTime.gnu'
gnuplot 'msgPerCs.gnu'
gnuplot 'reqCount.gnu'
gnuplot 'statePercentages.gnu'
gnuplot 'rhoRatio.gnu'
