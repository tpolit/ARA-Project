set terminal pngcairo size 1000,2000
set output 'statePercentagesBig.png'
set xlabel 'beta (ms)'
set ylabel 'Etats (%)'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 1
set multiplot layout 3,1 rowsfirst downwards title 'Pourcentages par état'
set title "a=499, g=1"
datafile1 = 'statePercentages_499_1.csv'
datafile2 = 'statePercentages_280_220.csv'
datafile3 = 'statePercentages_10_490.csv'
plot [ ] [0:] datafile1 index(0) using 2:xticlabels(1)  title "U" with histogram lc rgb'green', '' index(0) using 3:xticlabels(1) title "T" with histogram lc rgb"red", '' index(0) using 4:xticlabels(1) title "N" with histogram lc rgb"blue"
set title "a=280, g=220"
plot [ ] [0:] datafile2 index(1) using 2:xticlabels(1)  title "U" with histogram lc rgb'yellow', '' index(1) using 3:xticlabels(1) title "T" with histogram lc rgb"magenta", '' index(1) using 4:xticlabels(1) title "N" with histogram lc rgb"cyan"
set title "a=10, g=490"
plot [ ] [0:] datafile3 index(2) using 2:xticlabels(1)  title "U" with histogram lc rgb'brown', '' index(2) using 3:xticlabels(1) title "T" with histogram lc rgb"black", '' index(2) using 4:xticlabels(1) title "N" with histogram lc rgb"grey"
unset multiplot
unset output