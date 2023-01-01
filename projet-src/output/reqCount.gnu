set terminal pngcairo size 1000,600
set output "RequestsPerNode.png"
set title 'Nombre de requetes par noeud'
set xlabel 'beta'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 0
plot [ ] [0:] 'reqCount_100_1.csv' using 2:xticlabels(1)  title "reqCount a=100, g=1" with histogram lc rgb'green',\
'reqCount_50_50.csv' using 2:xticlabels(1)  title "reqCount a=50, g=50" with histogram lc rgb'red',\
'reqCount_10_100.csv' using 2:xticlabels(1)  title "reqCount a=10, g=100" with histogram lc rgb'blue'
