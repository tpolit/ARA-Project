set terminal pngcairo size 1000,600
set output "RequestsPerNode.png"
set title 'Nombre de requetes par noeud'
set xlabel 'beta (ms)'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 1
datafile1 = 'reqCount_499_1.csv'
datafile2 = 'reqCount_280_220.csv'
datafile3 = 'reqCount_10_490.csv'
plot [ ] [0:] datafile1 index(0) using 2:xticlabels(1)  title "reqCount a=999, g=1" with histogram lc rgb'green',\
datafile2 index(1) using 2:xticlabels(1)  title "reqCount a=550, g=450" with histogram lc rgb'red',\
datafile3 index(2) using 2:xticlabels(1)  title "reqCount a=10, g=990" with histogram lc rgb'blue'
