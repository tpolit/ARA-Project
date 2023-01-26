set terminal pngcairo size 1000,600

set xlabel 'beta (ms)'
set ylabel 'msgRecoveryCount'
set y2label 'msgAppCount'
set datafile separator ','
set key outside below
set xtics rotate
datafile1 = 'age50.csv'
datafile2 = 'age150.csv'
datafile3 = 'age250.csv'
datafile4 = 'age350.csv'

set output "age_50.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=50"
plot [0:] [0:] datafile1 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Age of recover point" with lp lw 2 lc rgb'blue' axis x1y1 

set output "age_150.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=150"
plot [0:] [0:] datafile2 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Age of recover point" with lp lw 2 lc rgb'blue' axis x1y1 

set output "age_250.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=250"
plot [0:] [0:] datafile3 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Age of recover point" with lp lw 2 lc rgb'blue' axis x1y1 

set output "age_350.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=350"
plot [0:] [0:] datafile4 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Age of recover point" with lp lw 2 lc rgb'blue' axis x1y1 
