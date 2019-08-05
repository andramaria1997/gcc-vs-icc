/*
 * Tema 2 ASC
 * 2019 Spring
 * Catalin Olaru / Vlad Spoiala
 */
#include "utils.h"

/*
 * Add your optimized implementation here
 */


double* transpose(int N, double *A) {

	int i, j;
	double *B = (double*)calloc(N*N, sizeof(double));

	for (i = 0 ; i < N ; i++) {
		double *pa = A + i*N;
		double *pb = B + i;
		for (j = 0 ; j < N ; j++) {
			*pb = *pa;
			pa++;
			pb += N;
		}
	}

	return B;
}

double* my_solver(int N, double *A, double* B) {

	int i, j, k;
	double *C = (double*)calloc(N*N, sizeof(double));
	double *D = (double*)calloc(N*N, sizeof(double));
	double *E = (double*)calloc(N*N, sizeof(double));

	A = transpose(N, A);
	B = transpose(N, B);

	for (i = 0 ; i < N ; i++) {
		double *orig_pa = A + i*N;
		double *pe = E + i*N;
		double *pc = C + i*N;
		for (j = 0 ; j < N ; j++) {
			double *pa = orig_pa;
			double *pb = B + j*N;
			register double suma = 0.0;
			for (k = 0 ; k < N ; k++) {
				suma += *pa * *pb;
				pa++;
				pb++;
			}
		*pc = suma;
		*pe = suma;
		pc++;
		pe++;
		}
	}

	transpose(N, E);

	for (i = 0 ; i < N ; i++) {
		double *pe = E + i*N + i;
		double *pc = C + i*N + i;
		for (j = i ; j < N ; j++) {
			*pc += *pe;
			pe++;
			pc++;
		}
	}

	for (i = 0 ; i < N ; i++) {
		double *pc = C + i*N;
		double *pd = D + i*N + i;
		for (j = i ; j < N ; j++) {
			double *pcprim = pc + i;
			double *pc2prim = pc + j;
			register double suma = 0.0;
			for (k = i ; k <= j ; k++) {
				suma += *pcprim * *pc2prim;
				pc2prim += N;
				pcprim++;
			}
			*pd = suma;
			pd++;
		}
	}

	return D;
}
