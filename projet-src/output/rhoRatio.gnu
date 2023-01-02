set terminal pngcairo size 1000,600
set output "RhoRatioAll.png"
set title 'Ratio rho'
set xlabel 'beta (ms)'
set ylabel 'rho'
set key outside below
set datafile separator ','
datafile1 = 'rhoRatio_400_1.csv'
datafile2 = 'rhoRatio_350_350.csv'
datafile3 = 'rhoRatio_10_400.csv'
plot [] [0:] datafile1 using 1:(($2+$3+$4+$5)/4)  title "a=400, g=1" with linespoints lc rgb'green' lw 2,\
datafile2 using 1:(($2+$3+$4+$5)/4)  title "a=350, g=350" with linespoints lc rgb'red' lw 2,\
datafile3 using 1:(($2+$3+$4+$5)/4)  title "a=10, g=400" with linespoints lc rgb'blue' lw 2
