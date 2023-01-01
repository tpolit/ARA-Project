set terminal pngcairo size 1000,600
set output "MsgPerCsAvg.png"
set title 'Nombre de messages applicatifs par section critique'
set xlabel 'beta (ms)'
set ylabel 'msgPerCs'
set key outside below
set datafile separator ','
datafile1 = 'msgPerCs_499_1_4cols.csv'
datafile2 = 'msgPerCs_280_220_4cols.csv'
datafile3 = 'msgPerCs_10_490_4cols.csv'
#stats datafile1 using 2 output name "A"
#stats datafile2 using 2 nooutput name "B"
stats datafile3 using (($2+$3+$4+$5)/4) nooutput name "C"
# faudra voir comment calculer le mean par x
plot [ ] [0:] datafile3 using 1:(($2+$3+$4+$5)/4):(C_stddev) with lines lw 2 lc rgb'blue'#, '' index(0) using 1:2:($2 - A_mean) with yerrorbars notitle#,\
#datafile2 index(1) using 1:2 with lines lw 2 lc rgb"red", '' index(1) using 1:2:($2 - B_mean) with yerrorbars notitle,\
#datafile3 index(2) using 1:2 with lines lw 2 lc rgb"blue", '' index(2) using 1:2:($2 - C_mean) with yerrorbars notitle