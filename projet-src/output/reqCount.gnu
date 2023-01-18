set terminal pngcairo size 1000,600
set output "RequestsPerNode.png"
set title 'Nombre de requetes par noeud'
set xlabel 'beta (ms)'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set xtics rotate
#set style fill transparent solid 0.6 border -1
#set style histogram clustered gap 1
datafile1 = 'reqCount_100_10.csv'
datafile2 = 'reqCount_55_55.csv'
datafile3 = 'reqCount_10_100.csv'
plot [ ] [0:] datafile1 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "total a=100, g=10" with lp lw 2 lc rgb'green',\
datafile2 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "total a=55, g=55" with lp lw 2 lc rgb'red',\
datafile3 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "total a=10, g=100" with lp lw 2 lc rgb'blue'
