set terminal pngcairo size 1000,600
set output "RhoRatioAll.png"
set title 'Ratio rho'
set xlabel 'beta (ms)'
set ylabel 'rho'
set key outside below
set datafile separator ','
datafile1 = 'rhoRatio_99_1.csv'
datafile2 = 'rhoRatio_50_50.csv'
datafile3 = 'rhoRatio_1_99.csv'
plot [] [0:] datafile1 using 1:(($2+$3+$4+$5)/4)  title "a=99, g=1" with linespoints lc rgb'green' lw 2,\
datafile2 using 1:(($2+$3+$4+$5)/4)  title "a=50, g=50" with linespoints lc rgb'red' lw 2,\
datafile3 using 1:(($2+$3+$4+$5)/4)  title "a=1, g=99" with linespoints lc rgb'blue' lw 2
