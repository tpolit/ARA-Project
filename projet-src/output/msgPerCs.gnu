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
plot [] [0:] datafile1 using 1:(($2+$3+$4+$5)/4)  title "MsgPerCs a=499, g=1" with linespoints lc rgb'green' lw 2,\
datafile2 using 1:(($2+$3+$4+$5)/4)  title "MsgPerCs a=280, g=220" with linespoints lc rgb'red' lw 2,\
datafile3 using 1:(($2+$3+$4+$5)/4)  title "MsgPerCs a=10, g=490" with linespoints lc rgb'blue' lw 2