set terminal pngcairo size 1000,1500
set output 'statePercentages.png'
set xlabel 'beta (ms)'
set ylabel 'Etats (%)'
set datafile separator ','
set key outside below
set style fill transparent solid 0.6 border -1
set style histogram clustered gap 1
datafile1 = 'statePercentages_99_1.csv'
datafile2 = 'statePercentages_280_220.csv'
datafile3 = 'statePercentages_10_490.csv'
set multiplot layout 3,1 rowsfirst downwards title 'Pourcentages par état'
set title "a=499, g=1"
plot [ ] [0:] datafile1 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'green', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"red", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"blue"
set title "a=280, g=220"
plot [ ] [0:] datafile2 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'yellow', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"magenta", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"cyan"
set title "a=10, g=490"
plot [ ] [0:] datafile3 using (($2+$5+$8+$11)/4):xticlabels(1)  title "U" with histogram lc rgb'brown', '' using (($3+$6+$9+$12)/4):xticlabels(1) title "T" with histogram lc rgb"black", ''  using (($4+$7+$10+$13)/4):xticlabels(1) title "N" with histogram lc rgb"grey"
unset multiplot
unset output