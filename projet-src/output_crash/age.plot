set terminal pngcairo size 1000,600 font "Helvetica, 18"

set xlabel 'beta (ms)'
set y2label 'msgAppCount'
set ylabel 'Oldness'
set datafile separator ','
set ytics nomirror
set y2tics nomirror
set y2range [0:]
set key outside below
set xtics rotate
#datafile1 = 'age50.csv'
datafile2 = 'age100.csv'
datafile3 = 'age200.csv'
datafile4 = 'age300.csv'
datafile5 = 'age400.csv'

#set output "age_50.png"
#set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=50"
#plot [0:] [0:] datafile1 using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Age of recover point" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 

set output "age_100.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=1/100"
plot [0:] [0:] datafile2 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Age of recover point" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "age_200.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=1/200"
plot [0:] [0:] datafile3 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Age of recover point" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "age_300.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=1/300"
plot [0:] [0:] datafile4 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Age of recover point" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "age_400.png"
set title "Difference moyenne entre le crash et le point de recouvrement a=100, g=10 freq=1/400"
plot [0:] [0:] datafile5 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Age of recover point" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2