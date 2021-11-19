CC=clang
CFLAGS=-O3 # -g # -fsanitize=address,undefined -g
all: list.ll shared.ll str.ll
list.ll: list.c | out
	$(CC) $(CFLAGS) list.c -S -emit-llvm -o out/list.ll

shared.ll: shared.c | out
	$(CC) $(CFLAGS) shared.c -S -emit-llvm -o out/shared.ll

str.ll: str.c | out
	$(CC) $(CFLAGS) str.c -S -emit-llvm -o out/str.ll

out:
	mkdir out
