set terminal pngcairo size 1000,600
set output "WaitingTimePerNode.png"
set title "Temps d'attente par noeud"
set xlabel 'beta'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 0
plot [ ] [0:] 'waitingTime_100_1.csv' using 2:xticlabels(1)  title "waitingTime a=100, g=1" with histogram lc rgb'green',\
'waitingTime_50_50.csv' using 2:xticlabels(1)  title "waitingTime a=50, g=50" with histogram lc rgb'red',\
'waitingTime_10_100.csv' using 2:xticlabels(1)  title "waitingTime a=10, g=100" with histogram lc rgb'blue'
