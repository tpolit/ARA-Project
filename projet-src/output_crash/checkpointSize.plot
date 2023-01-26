set terminal pngcairo size 1000,600

set xlabel 'beta (ms)'
set ylabel 'msgRecoveryCount'
set y2label 'msgAppCount'
set datafile separator ','
set key outside below
set xtics rotate
datafile1 = 'checkpointSize50.csv'
datafile2 = 'checkpointSize150.csv'
datafile3 = 'checkpointSize250.csv'
datafile4 = 'checkpointSize350.csv'

set output "checkpointSize_50.png"
set title "Taille moyenne d'un checkpoint a=100, g=10 freq=50"
plot [0:] [0:] datafile1 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Checkpoint Size" with lp lw 2 lc rgb'blue' axis x1y1 

set output "checkpointSize_150.png"
set title "Taille moyenne d'un checkpoint a=100, g=10 freq=150"
plot [0:] [0:] datafile2 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Checkpoint Size" with lp lw 2 lc rgb'blue' axis x1y1 

set output "checkpointSize_250.png"
set title "Taille moyenne d'un checkpoint a=100, g=10 freq=250"
plot [0:] [0:] datafile3 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Checkpoint Size" with lp lw 2 lc rgb'blue' axis x1y1 

set output "checkpointSize_350.png"
set title "Taille moyenne d'un checkpoint a=100, g=10 freq=350"
plot [0:] [0:] datafile4 using 1:(($2+$4+$6+$8)/4):xticlabels(1)  title "Msg count" with lp lw 2 lc rgb'green' axis x1y2, '' using 1:(($3+$5+$7+$9)/4):xticlabels(1)  title "Checkpoint Size" with lp lw 2 lc rgb'blue' axis x1y1 
