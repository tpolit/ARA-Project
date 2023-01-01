set terminal pngcairo size 1000,600
set output "WaitingTimePerNode.png"
set title "Temps d'attente par noeud"
set xlabel 'beta'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 1
datafile1 = 'waitingTime_499_1.csv'
datafile2 = 'waitingTime_280_220.csv'
datafile3 = 'waitingTime_10_490.csv'
plot [ ] [0:] datafile1 using (($2+$3+$4+$5)/4):xticlabels(1)  title "waitingTime a=999, g=1" with histogram lc rgb'green',\
datafile2 using (($2+$3+$4+$5)/4):xticlabels(1)  title "waitingTime a=550, g=450" with histogram lc rgb'red',\
datafile3 using (($2+$3+$4+$5)/4):xticlabels(1)  title "waitingTime a=10, g=990" with histogram lc rgb'blue'
