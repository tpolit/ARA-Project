#! /usr/bin/bash

################################################################################################################
#Help
################################################################################################################
Help() {
    echo "Launch all the simulations needed in peersim"
    echo
    echo "Syntax: scriptTemplate [-h|c] [-t Execution Time]"
    echo "options:"
    echo "h Print this help"
    echo "t To give execution time"
    echo "c Enable crashes"
    echo
}

################################################################################################################
#Main
################################################################################################################

crashEnabled=0
executionTime=0

while getopts "hct:" option; do
    case $option in
    h)
        Help
        exit 0
        ;;
    c)
        crashEnabled=1
        ;;
    t)
        executionTime=${OPTARG}
        ;;
    esac
done

echo "$@"

echo "crash=$crashEnabled exec=$executionTime"

if [ $executionTime -lt 50000 ]; then
    echo "J'aimerais un temps d'execution superieur ou égal à 50000"
    exit 1
fi


if [ $crashEnabled -eq 0 ]; then

    # getting data
    ./launch_script.sh 100 10 $executionTime
    ./launch_script.sh 55 55 $executionTime
    ./launch_script.sh 10 100 $executionTime

    # plotting
    cd output
    gnuplot 'waitingTime.gnu'
    gnuplot 'msgPerCs.gnu'
    gnuplot 'reqCount.gnu'
    gnuplot 'statePercentages.gnu'

elif [ $crashEnabled -eq 1 ]; then

    echo "###################################################################"
    echo "                       ~~Crash Edition~~"
    echo "###################################################################"

    ./launch_script_crash.sh 30000 1000 $executionTime

    cd output_crash/
    gnuplot "msgCount.plot" 
    gnuplot "recoveryTime.plot" 
    gnuplot "checkpointSize.plot" 
    gnuplot "age.plot"

else

    echo "Something wrong happened! crashEnabled is different from 0 and 1!!!"

fi