set terminal pngcairo size 1000,600
set xlabel 'beta (ms)'
set ylabel 'Etats (%)'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram rowstacked
set boxwidth 0.6
datafile1 = 'statePercentages_400_1.csv'
datafile2 = 'statePercentages_350_350.csv'
datafile3 = 'statePercentages_10_400.csv'

# set multiplot layout 3,1 rowsfirst downwards title 'Pourcentages par état'
set output 'statePercentages_400_1.png'
set title "statePercentages a=400, g=1"
plot [ ] [0:100] datafile1 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'green', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"red", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"blue"
set output 'statePercentages_350_350.png'
set title "statePercentages a=350, g=350"
plot [ ] [0:100] datafile2 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'yellow', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"magenta", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"cyan"
set output 'statePercentages_10_400.png'
set title "statePercentages a=10, g=400"
plot [ ] [0:100] datafile3 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'brown', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"black", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"grey"