CC=gcc
CFLAGS=-Wall -Werror -O0
OTHER_C_FLAGS=-Wall -Werror -flto -Os -Ofast -fno-zero-initialized-in-bss -faggressive-loop-optimizations -fira-region=all -floop-nest-optimize
LIBDIRS=-I/usr/lib64/atlas -L/usr/lib64/atlas
LIBS=-lsatlas -lm

all: tema2_blas tema2_neopt tema2_opt_m tema2_opt_f

tema2_blas: solver_blas.c main.c
	$(CC) $(CFLAGS) $^ $(LIBDIRS) $(LIBS) -o $@

tema2_neopt: solver_neopt.c main.c
	$(CC) $(CFLAGS) $^ -o $@

tema2_opt_m: solver_opt.c main.c
	$(CC) $(CFLAGS) $^ -o $@

tema2_opt_f: solver_neopt.c main.c
	$(CC) $(OTHER_C_FLAGS) $^ -o $@

clean:
	rm -rf tema2_blas tema2_neopt tema2_opt_m tema2_opt_f
