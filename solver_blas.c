/*
 * Tema 2 ASC
 * 2019 Spring
 * Catalin Olaru / Vlad Spoiala
 */
#include "utils.h"
#include "cblas.h"

/* 
 * Add your BLAS implementation here
 */

extern void dsyr2k_(const enum CBLAS_ORDER Order, const enum CBLAS_UPLO Uplo,
                  const enum CBLAS_TRANSPOSE Trans, const int N, const int K,
                  const double alpha, const double *A, const int lda,
                  const double *B, const int ldb, const double beta,
                  double *C, const int ldc);

void dgemm_(const enum CBLAS_ORDER Order, const enum CBLAS_TRANSPOSE TransA,
                 const enum CBLAS_TRANSPOSE TransB, const int M, const int N,
                 const int K, const double alpha, const double *A,
                 const int lda, const double *B, const int ldb,
                 const double beta, double *C, const int ldc);


double* my_solver(int N, double *A, double *B) {

	double *C = (double*)calloc(N*N, sizeof(double));
	double *D = (double*)calloc(N*N, sizeof(double));

	cblas_dsyr2k(CblasRowMajor, CblasUpper, CblasTrans,
			N, N, 1.0, A, N, B, N, 0.0, D, N);

	cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
			N, N, N, 1.0, D, N, D, N, 0.0, C, N);

	return C;
}
