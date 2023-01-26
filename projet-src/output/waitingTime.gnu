set terminal pngcairo size 1000,600

set xlabel 'beta'
set ylabel "Temps d'attente (ms)"
set datafile separator ','
set key outside below
unset key
#set style fill transparent solid 0.6 border -1
set xtics rotate
set ytics 100
#set style histogram clustered gap 1
datafile1 = 'waitingTime_100_10.csv'
datafile2 = 'waitingTime_55_55.csv'
datafile3 = 'waitingTime_10_100.csv'

set output "WaitingTimePerNode_100_10.png"
set title "Temps d'attente par noeud a=100, g=10"
plot [0:] [0:] datafile1 using 1:(($2+$4+$6+$8)/4):(($3+$5+$7+$9)/4):xticlabels(1)  title "a=100, g=10" with errorlines lc rgb'green'#,\

set output "WaitingTimePerNode_55_55.png"
set title "Temps d'attente par noeud a=55, g=55"
plot [0:] [0:] datafile2 using 1:(($2+$4+$6+$8)/4):(($3+$5+$7+$9)/4):xticlabels(1)  title "a=55, g=55" with errorlines lc rgb'red'#,\

set output "WaitingTimePerNode_10_100.png"
set title "Temps d'attente par noeud a=10, g=100"
plot [0:] [0:] datafile3 using 1:(($2+$6+$6+$8)/4):(($3+$5+$7+$9)/4):xticlabels(1)  title "a=10, g=100" with errorlines lc rgb'blue'
