set terminal pngcairo size 1000,600 font "Helvetica, 18"
set output "RequestsPerNode.png"
set title 'Nombre de requetes intermediaires par noeud'
set xlabel 'beta (ms)'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set xtics rotate
#set style histogram clustered gap 1
set style fill transparent solid 0.8
datafile1 = 'reqCount_100_10.csv'
datafile2 = 'reqCount_55_55.csv'
datafile3 = 'reqCount_10_100.csv'
plot [0:] [0:] datafile1 using 1:(($2+$3+$4+$5)/4):xticlabels(1) title "total a=100, g=10" with lp lw 3 ps 1  pt 7 lc rgb'green',\
datafile2 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "total a=55, g=55" with lp lw 3 ps 1  pt 7 lc rgb'red',\
datafile3 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "total a=10, g=100" with lp lw 3 ps 1  pt 7 lc rgb'blue'
