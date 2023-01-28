set terminal pngcairo size 1000,600 font "Helvetica, 18"


set xlabel 'Chkdelay (ms)'
set ylabel 'msgRecoveryCount'
set y2label 'msgAppCount'
set ytics nomirror
set y2tics nomirror
set y2range [0:]
set datafile separator ','
set key outside below
set xtics rotate

#datafile1 = 'msgCount50.csv'
datafile2 = 'msgCount100.csv'
datafile3 = 'msgCount200.csv'
datafile4 = 'msgCount300.csv'
datafile5 = 'msgCount400.csv'

#set output "msgCount_50.png"
#set title 'Le nombre de messages de recouvrement a=100, g=10 freq=50'
#plot [0:] [0:] datafile1 using 1:(($3+$5+$7+$9+$11+$13+$15)/4):xticlabels(1) smooth unique title "Recovery Msg Count" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "msgCount_100.png"
set title 'Le nombre de messages de recouvrement a=100, g=10 freq=1/100'
plot [0:] [0:] datafile2 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Recovery Msg Count" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "msgCount_200.png"
set title 'Le nombre de messages de recouvrement a=100, g=10 freq=1/200'
plot [0:] [0:] datafile3 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Recovery Msg Count" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "msgCount_300.png"
set title 'Le nombre de messages de recouvrement a=100, g=10 freq=1/300'
plot [0:] [0:] datafile4 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Recovery Msg Count" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2

set output "msgCount_400.png"
set title 'Le nombre de messages de recouvrement a=100, g=10 freq=1/400'
plot [0:] [0:] datafile5 using 1:(($3+$5+$7+$9)/4):xticlabels(1) smooth unique title "Recovery Msg Count" with lp lw 3 ps 1  pt 7 lc rgb'blue' axis x1y1 , '' using 1:(($2+$4+$6+$8)/4):xticlabels(1) smooth unique title "Msg count" with lp lw 3 ps 1  pt 7 lc rgb'green' axis x1y2