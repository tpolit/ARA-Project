#! /usr/bin/bash


# Generate config.txt
### gamma and alpha are script arguments

if [ $# -ne 2 ]; then
	echo "Erreur dans le nombre d'arguments passés."
	echo "Le script doit être appelé avec deux arguments numérique alpha puis gamma"
	exit 1
fi
gamma=$2
alpha=$1
betaValues=(0 20 40 60 80 100 120 150 200 250)

#Clean all previous data with the same alpha and gamma 
if [ -f "./output/msgPerCs_${alpha}_${gamma}.csv" ]
then
	rm ./output/*_${alpha}_${gamma}.csv
fi
## d'autres tests de sécurité sur les valeurs de gamma et alpha.

## les differents fichiers
msgPerCsFile="./projet-src/output/msgPerCs.csv"
reqCountFile="./projet-src/output/reqCount.csv"
waitingTimeFile="./projet-src/output/waitingTime.csv"
statePercentagesFile="./projet-src/output/statePercentages.csv"
configFile="$(dirname "${BASH_SOURCE[0]}")/Config.txt"
# echo $configFile
sed -i "s/protocol.transport.mindelay\s[0-9]\+/protocol.transport.mindelay ${gamma}/" $configFile
sed -i "s/protocol.transport.maxdelay\s[0-9]\+/protocol.transport.maxdelay ${gamma}/" $configFile

sed -i "s/protocol.naimitrehel.timeCS\s[0-9]\+/protocol.naimitrehel.timeCS ${alpha}/" $configFile

echo "Le simulateurs va s'exécuté avec alpha=${alpha} et gamma=${gamma}"
echo "Les differentes exécutions vont prendre à chaque fois un beta de cette liste ${betaValues[@]}"

for beta in ${betaValues[@]}
do
	sed -i "s/protocol.naimitrehel.timeBetweenCS\s[0-9]\+/protocol.naimitrehel.timeBetweenCS $beta/" $configFile
	## launch prog
	/usr/lib/jvm/java-11-openjdk-amd64/bin/java -Dfile.encoding=UTF-8 -classpath /home/mazigh/Software/PSAR/peersim-1.0.5/peersim-doclet.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/peersim-1.0.5.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/jep-2.3.0.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/djep-1.0.0.jar:/home/mazigh/Studies/M2_S1/ARA/Eclipse_Workspace/ARA-Project/projet-src/bin peersim.Simulator $configFile
done

# plotting
cd output
gnuplot 'waitingTime.gnu'
gnuplot 'msgPerCs.gnu'
gnuplot 'reqCount.gnu'
gnuplot 'statePercentages.gnu'