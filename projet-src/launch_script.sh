#! /usr/bin/bash
# Generate config.txt
### gamma and alpha are script arguments
source ./myLibrary.sh

if [ $# -lt 3 ]; then
	echo "Erreur dans le nombre d'arguments passés."
	echo "Le script doit être appelé avec trois arguments numérique alpha puis gamma et enfin le temps d'execution total"
	exit 1
fi

randomSeeds=(20 784 365 874)
executionTime=$3
gamma=$2
alpha=$1
#betaValues=(0 20 40 60 80 100 120 140 160 180 200 220 240 260)
#betaValues=(50 250 450 550 600 650 700 750 850 1050 1250 1450 1650 1850 2050 2250 2450 2650 2850 3050) # apres 700, le programme boucle trop (la cause: poisson!)
betaValues=(50)
i=1
while [ $i -lt 30 ]; do	
	betaValues[i]=$(($betaValues+$i*100))
	((i++))
done

## d'autres tests de sécurité sur les valeurs de gamma et alpha.
if [ $((${gamma}+${alpha})) -gt ${executionTime} ]
then
	echo "Erreur sur la valeur des arguments."
	echo "Un alpha et gamma supérieur au temps d'execution ne veut rien dire. Il est conseillé d'utiliser un temps d'execution aux moins 10x supérieurs que le plus grand des deux."
	exit 1
fi
#Clean all previous data with the same alpha and gamma 
if [ -f "./output/msgPerCs_${alpha}_${gamma}.csv" ]
then
	gio trash ./output/*_${alpha}_${gamma}.csv
fi

gio trash ./output.log

## les differents fichiers
configFile="$(dirname "${BASH_SOURCE[0]}")/Config.txt"
# echo $configFile

sed -i "s/simulation.endtime\s[0-9]\+/simulation.endtime ${executionTime}/" $configFile

sed -i "s/protocol.transport.mindelay\s[0-9]\+/protocol.transport.mindelay $((${gamma}))/" $configFile
sed -i "s/protocol.transport.maxdelay\s[0-9]\+/protocol.transport.maxdelay $((${gamma}+${gamma}/10))/" $configFile

sed -i "s/protocol.naimitrehel.timeCS\s[0-9]\+/protocol.naimitrehel.timeCS ${alpha}/" $configFile

echo "Le simulateurs va s'exécuté avec alpha=${alpha} et gamma=${gamma}"
echo "Les differentes exécutions vont prendre à chaque fois un beta de cette liste ${betaValues[@]}"

progress=0
# printf "beta, msgPerCs\n">> ./output/msgPerCs_${alpha}_${gamma}.csv
for seed in ${randomSeeds[@]}
do
	sed -i "s/random.seed\s[0-9]\+/random.seed ${seed}/" $configFile

	for beta in ${betaValues[@]}
	do
		echo_progressBar $progress $((${#betaValues[@]}*${#randomSeeds[@]}))
		sed -i "s/protocol.naimitrehel.timeBetweenCS\s[0-9]\+/protocol.naimitrehel.timeBetweenCS $beta/" $configFile
		## launch sim
		/usr/lib/jvm/java-11-openjdk-amd64/bin/java -Dfile.encoding=UTF-8 -classpath /home/mazigh/Software/PSAR/peersim-1.0.5/peersim-doclet.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/peersim-1.0.5.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/jep-2.3.0.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/djep-1.0.0.jar:/home/mazigh/Studies/M2_S1/ARA/Eclipse_Workspace/ARA-Project/projet-src/bin peersim.Simulator $configFile &>> ./output.log
	((progress=progress+1))
	done
done
echo -e "\nDONE"
