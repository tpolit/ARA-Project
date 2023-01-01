set terminal pngcairo size 1000,2000
set output 'statePercentagesBig.png'
set xlabel 'beta'
set ylabel 'Etats%'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 0
set multiplot layout 3,1 rowsfirst downwards title 'Pourcentages par état'
set title "a=100, g=1"
plot [ ] [0:] 'statePercentages_100_1.csv' using 2:xticlabels(1)  title "U" with histogram lc rgb'green', '' using 3:xticlabels(1) title "T a=100, g=1" with histogram lc rgb"red", '' using 4:xticlabels(1) title "N a=100, g=1" with histogram lc rgb"blue"
set title "a=50, g=50"
plot [ ] [0:] 'statePercentages_50_50.csv' using 2:xticlabels(1)  title "U a=50, g=50" with histogram lc rgb'yellow', '' using 3:xticlabels(1) title "T a=50, g=50" with histogram lc rgb"magenta", '' using 4:xticlabels(1) title "N a=50, g=50" with histogram lc rgb"cyan"
set title "a=10, g=100"
plot [ ] [0:] 'statePercentages_10_100.csv' using 2:xticlabels(1)  title "U a=10, g=100" with histogram lc rgb'brown', '' using 3:xticlabels(1) title "T a=10, g=100" with histogram lc rgb"black", '' using 4:xticlabels(1) title "N a=10, g=100" with histogram lc rgb"grey"
unset multiplot
unset output