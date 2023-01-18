set terminal pngcairo size 1000,600
set output "WaitingTimePerNode.png"
set title "Temps d'attente par noeud"
set xlabel 'beta'
set ylabel "Temps d'attente (ms)"
set datafile separator ','
set key outside below
#set style fill transparent solid 0.6 border -1
set xtics rotate
#set style histogram clustered gap 1
datafile1 = 'waitingTime_100_10.csv'
datafile2 = 'waitingTime_55_55.csv'
datafile3 = 'waitingTime_10_100.csv'
plot [ ] [0:] datafile1 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "a=100, g=10" with lp lc rgb'green',\
datafile2 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "a=55, g=55" with lp lc rgb'red',\
datafile3 using 1:(($2+$6+$6+$8)/4):xticlabels(1)  title "a=1, g=100" with lp lc rgb'blue'
