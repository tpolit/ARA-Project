set terminal pngcairo size 1000,600
set output "MsgPerCsAll.png"
set title 'Nombre de messages applicatifs par section critique'
set xlabel 'beta (ms)'
set ylabel 'msgPerCs'
set datafile separator ','
set key outside below
set xtics rotate
datafile1 = 'msgPerCs_100_10.csv'
datafile2 = 'msgPerCs_55_55.csv'
datafile3 = 'msgPerCs_10_100.csv'
plot [0:] [0:] datafile1 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "a=100, g=10" with lp lw 3 ps 1  pt 7 lc rgb'green',\
datafile2 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "a=55, g=55" with lp lw 3 ps 1  pt 7 lc rgb'red',\
datafile3 using 1:(($2+$3+$4+$5)/4):xticlabels(1)  title "a=10, g=100" with lp lw 3 ps 1  pt 7 lc rgb'blue'
