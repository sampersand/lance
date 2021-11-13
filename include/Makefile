CC=clang
CFLAGS=-g # -fsanitize=address,undefined -g
all: list.ll shared.ll str.ll
list.ll: list.c | out
	$(CC) $(CFLAGS) list.c -S -emit-llvm -o out/list.ll #-O3

shared.ll: shared.c | out
	$(CC) $(CFLAGS) shared.c -S -emit-llvm -o out/shared.ll #-O3

str.ll: str.c | out
	$(CC) $(CFLAGS) str.c -S -emit-llvm -o out/str.ll #-O3

out:
	mkdir out
