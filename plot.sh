#!/bin/bash

module load compilers/gnu-5.4.0 
module load utilities/intel_parallel_studio_xe_2016 

make -f Makefile clean
make -f Makefile
./tema2_neopt input > neopt_gcc
./tema2_opt_m input > optm_gcc
./tema2_opt_f input > optf_gcc
./tema2_blas input > blas_gcc

make -f Makefile.icc clean
make -f Makefile.icc
./tema2_neopt input > neopt_icc
./tema2_opt_m input > optm_icc
./tema2_opt_f input > optf_icc
./tema2_blas input > blas_icc

echo "size, time" > neopt_gcc_plot
cat neopt_gcc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> neopt_gcc_plot
rm neopt_gcc

echo "size, time" > optm_gcc_plot
cat optm_gcc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> optm_gcc_plot
rm optm_gcc

echo "size, time" > optf_gcc_plot
cat optf_gcc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> optf_gcc_plot
rm optf_gcc

echo "size, time" > blas_gcc_plot
cat blas_gcc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> blas_gcc_plot
rm blas_gcc

echo "size, time" > neopt_icc_plot
cat neopt_icc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> neopt_icc_plot
rm neopt_icc

echo "size, time" > optm_icc_plot
cat optm_icc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> optm_icc_plot
rm optm_icc

echo "size, time" > optf_icc_plot
cat optf_icc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> optf_icc_plot
rm optf_icc

echo "size, time" > blas_icc_plot
cat blas_icc | cut -d'=' -f4 | awk '{
	if (NR == 2) {printf("400,\t%s\n", $0)}
	if (NR == 4) {printf("1000,\t%s\n", $0)}
	if (NR == 6) {printf("1600,\t%s\n", $0)}
}' >> blas_icc_plot
rm blas_icc

gnuplot -persist -e "set xlabel 'size'; set ylabel 'time'; set datafile separator ','; \
	plot 'blas_icc_plot' using 1:2 title 'blas performance' with lines lt rgb 'red', \
	'optm_icc_plot' using 1:2 title 'opt m performance' with lines lt rgb 'green', \
	'optf_icc_plot' using 1:2 title 'opt f performance' with lines lt rgb 'blue', \
	'neopt_icc_plot' using 1:2 title 'neopt performance' with lines lt rgb 'orange'"

gnuplot -persist -e "set xlabel 'size'; set ylabel 'time'; set datafile separator ','; \
	plot 'blas_gcc_plot' using 1:2 title 'blas performance' with lines lt rgb 'red', \
	'optm_gcc_plot' using 1:2 title 'opt m performance' with lines lt rgb 'green', \
	'optf_gcc_plot' using 1:2 title 'opt f performance' with lines lt rgb 'blue', \
	'neopt_gcc_plot' using 1:2 title 'neopt performance' with lines lt rgb 'orange'"
