#! /usr/bin/bash

if [ $# -ne 1 ]; then
    echo "J'ai besoin du temps d'execution!!"
fi
# getting data
./launch_script.sh 499 1 $1
./launch_script.sh 280 220 $1
./launch_script.sh 10 490 $1

# plotting
cd output
gnuplot 'waitingTime.gnu'
gnuplot 'msgPerCs.gnu'
gnuplot 'reqCount.gnu'
gnuplot 'statePercentages.gnu'