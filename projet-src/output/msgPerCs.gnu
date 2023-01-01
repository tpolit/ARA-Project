set terminal pngcairo size 1000,600
set output "MsgPerCsAll.png"
set title 'Nombre de messages applicatifs par section critique'
set xlabel 'beta'
set ylabel 'msgPerCs'
set key outside below
set datafile separator ','
plot [] [0:] 'msgPerCs_100_1.csv' using 1:2  title "MsgPerCs a=100, g=1" with linespoints lc rgb'green' lw 2,\
'msgPerCs_50_50.csv' using 1:2  title "MsgPerCs a=50, g=50" with linespoints lc rgb'red' lw 2,\
'msgPerCs_10_100.csv' using 1:2  title "MsgPerCs a=10, g=100" with linespoints lc rgb'blue' lw 2
