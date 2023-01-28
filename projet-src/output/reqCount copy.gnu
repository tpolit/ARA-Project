set terminal pngcairo size 1000,600
set output "RequestsPerNode.png"
set title 'Nombre de requetes par noeud'
set xlabel 'beta (ms)'
set ylabel 'nombre de requetes'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 1
datafile1 = 'reqCount_99_1.csv'
datafile2 = 'reqCount_50_50.csv'
datafile3 = 'reqCount_1_99.csv'
plot [ ] [0:] datafile1 using (($2+$4+$6+$8)/4):xticlabels(1)  title "total a=99, g=1" with llc rgb'green',\ # '' using (($3+$5+$7+$9)/4):xticlabels(1)  title "inter a=99, g=1" with histogram lc rgb'yellow',\
datafile2 using (($2+$4+$6+$8)/4):xticlabels(1)  title "total a=50, g=50" with llc rgb'red',\ #'' using (($3+$5+$7+$9)/4):xticlabels(1)  title "inter a=50, g=50" with histogram lc rgb'pink',\
datafile3 using (($2+$4+$6+$8)/4):xticlabels(1)  title "total a=1, g=99" with llc rgb'blue' #, '' using (($3+$5+$7+$9)/4):xticlabels(1)  title "inter a=1, g=99" with histogram lc rgb'cyan'
