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
plot [ ] [0:] datafile1 using (($2+$3+$4+$5)/4):xticlabels(1)  title "reqCount a=499, g=1" with histogram lc rgb'green',\
datafile2 using (($2+$3+$4+$5)/4):xticlabels(1)  title "reqCount a=280, g=220" with histogram lc rgb'red',\
datafile3 using (($2+$3+$4+$5)/4):xticlabels(1)  title "reqCount a=10, g=490" with histogram lc rgb'blue'
