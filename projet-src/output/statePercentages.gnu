set terminal pngcairo size 1000,600
set xlabel 'beta (ms)'
set ylabel 'Etats (%)'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram rowstacked
set boxwidth 0.6
datafile1 = 'statePercentages_100_10.csv'
datafile2 = 'statePercentages_55_55.csv'
datafile3 = 'statePercentages_10_100.csv'

set xtics rotate

# set multiplot layout 3,1 rowsfirst downwards title 'Pourcentages par état'

set output 'statePercentages_100_10.png'
set title "statePercentages a=100, g=10"
plot [ ] [0:100] datafile1 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'green', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"red", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"blue"
set output 'statePercentages_55_55.png'
set title "statePercentages a=55, g=55"
plot [ ] [0:100] datafile2 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'green', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"red", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"blue"
set output 'statePercentages_10_100.png'
set title "statePercentages a=10, g=100"
plot [ ] [0:100] datafile3 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'green', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"red", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"blue"