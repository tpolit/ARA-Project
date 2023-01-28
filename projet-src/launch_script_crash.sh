#! /usr/bin/bash

#import useful functions
source ./myLibrary.sh

# Generate config.txt

if [ $# -lt 3 ]; then
	echo "Erreur dans le nombre d'arguments passés."
	echo "Le script doit être appelé avec trois arguments numérique: date_premier_crash interval_crash temps_d'exécution"
	exit 1
fi

# crash variables
#crashNodes=(4 1 9 10 3 6 2 8 7 5)
#crashNode=$1
crashStartingDate=$1
crashStep=$2
checkpointFreq=(100 200 300 400)

# legacy variables
randomSeeds=(20 784 202 874)
executionTime=$3

betaValues=(50)
i=1
while [ $i -lt 25 ]; do
	betaValues[i]=$(($betaValues + $i * 100))
	((i++))
done

## d'autres tests de sécurité sur les valeurs de gamma et alpha.
if [ $((crashStartingDate + crash)) -gt ${executionTime} ]; then
	echo "Erreur sur la valeur des arguments."
	echo "Veuillez utiliser une date de début de crash et un interval qui puissent causer plusieurs crash dans le temps d'exécution donné."
	exit 1
fi

for freq in ${checkpointFreq[@]}; do
	#Clean all previous data
	if [ -f "./output_crash/recoveryTime${freq}.csv" ]; then
		echo "deleting files..."
		gio trash ./output_crash/*${freq}.csv
	fi
done

gio trash ./*.log

## les differents fichiers
configFile="$(dirname "${BASH_SOURCE[0]}")/Config_Crash.txt"

# legacy variables
sed -i "s/simulation.endtime\s[0-9]\+/simulation.endtime ${executionTime}/" $configFile

echo "Les differentes exécutions vont prendre à chaque fois un beta de cette liste ${betaValues[@]}"

# crash variables
sed -i "s/control.crash.from\s[0-9]\+/control.crash.from ${crashStartingDate}/" $configFile
sed -i "s/control.crash.step\s[0-9]\+/control.crash.step ${crashStep}/" $configFile
# sed -i "s/control.crash.faulty_nodes\s[0-9]\+/control.crash.faulty_nodes ${crashNodes[0]}/" $configFile

echo "Le simulateurs va s'exécuté avec des crash possible chez tous les noeuds, from=${crashStartingDate}, step=${crashStep}"
echo "Les differentes exécutions vont prendre à chaque fois un delai entre les checkpoints de cette liste ${checkpointFreq[@]}"
for seed in ${randomSeeds[@]}; do
	sed -i "s/random.seed\s[0-9]\+/random.seed ${seed}/" $configFile
	progress=0
	for freq in ${checkpointFreq[@]}; do

		sed -i "s/protocol.juang.timecheckpointing\s[0-9]\+/protocol.juang.timecheckpointing ${freq}/" $configFile
		for beta in ${betaValues[@]}; do
			sed -i "s/protocol.naimitrehel.timeBetweenCS\s[0-9]\+/protocol.naimitrehel.timeBetweenCS $beta/" $configFile

			# progress bar
			echo_progressBar $progress $((${#betaValues[@]}*${#checkpointFreq[@]}))
			## launch sim: all outputs (even errors) are redirected to /dev/null
			/usr/lib/jvm/java-11-openjdk-amd64/bin/java -Dfile.encoding=UTF-8 -classpath /home/mazigh/Software/PSAR/peersim-1.0.5/peersim-doclet.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/peersim-1.0.5.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/jep-2.3.0.jar:/home/mazigh/Software/PSAR/peersim-1.0.5/djep-1.0.0.jar:/home/mazigh/Studies/M2_S1/ARA/Eclipse_Workspace/ARA-Project/projet-src/bin peersim.Simulator $configFile &>> ./output.log
			progress=$((${progress} + 1)) # ((progress=progress+10))
		done
	done
done
echo -e "\nDONE"
