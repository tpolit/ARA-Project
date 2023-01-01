set terminal pngcairo size 1000,600
set output "MsgPerCsAll.png"
set title 'Nombre de messages applicatifs par section critique'
set xlabel 'beta (ms)'
set ylabel 'msgPerCs'
set key outside below
set datafile separator ','
datafile1 = 'msgPerCs_499_1.csv'
datafile2 = 'msgPerCs_280_220.csv'
datafile3 = 'msgPerCs_10_490.csv'
plot [] [0:] datafile1 index(0) using 1:2  title "MsgPerCs a=499, g=1" with linespoints ps 3 lc rgb'green' lw 2,\
datafile2 index(1) using 1:2  title "MsgPerCs a=280, g=220" with linespoints ps 3 lc rgb'red' lw 2,\
datafile3 index(2) using 1:2  title "MsgPerCs a=10, g=490" with linespoints ps 3 lc rgb'blue' lw 2
