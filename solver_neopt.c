/*
 * Tema 2 ASC
 * 2019 Spring
 * Catalin Olaru / Vlad Spoiala
 */
#include "utils.h"

/*
 * Add your unoptimized implementation here
 */

double* my_solver(int N, double *A, double* B) {

	int i, j, k;
	double *C = (double*)calloc(N*N, sizeof(double));
	double *D = (double*)calloc(N*N, sizeof(double));

	for (i = 0 ; i < N ; i++) {
		for (j = 0 ; j < N ; j++) {
			for (k = 0 ; k < N ; k++) {
				C[i*N + j] += A[i + k*N] * B[k*N + j];
			}
		}
	}

	for (i = 0 ; i < N ; i++) {
		for (j = i ; j < N ; j++) {
			C[i*N + j] += C[j*N + i];
		}
	}

	for (i = 0 ; i < N ; i++) {
		for (j = i ; j < N ; j++) {
			for (k = i ; k <= j ; k++) {
				D[i*N + j] += C[i*N + k] * C[k*N + j];
			}
		}
	}

	return D;
}
