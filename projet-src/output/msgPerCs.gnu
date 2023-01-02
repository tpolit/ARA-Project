set terminal pngcairo size 1000,600
set output "MsgPerCsAll.png"
set title 'Nombre de messages applicatifs par section critique'
set xlabel 'beta (ms)'
set ylabel 'msgPerCs'
set key outside below
set datafile separator ','
datafile1 = 'msgPerCs_400_1.csv'
datafile2 = 'msgPerCs_350_350.csv'
datafile3 = 'msgPerCs_10_400.csv'
plot [] [0:] datafile1 using 1:(($2+$3+$4+$5)/4)  title "a=400, g=1" with linespoints lc rgb'green' lw 2,\
datafile2 using 1:(($2+$3+$4+$5)/4)  title "a=350, g=350" with linespoints lc rgb'red' lw 2,\
datafile3 using 1:(($2+$3+$4+$5)/4)  title "a=10, g=400" with linespoints lc rgb'blue' lw 2