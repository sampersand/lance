all: list.ll shared.ll str.ll

list.ll: list.c | out
	clang list.c -S -emit-llvm -o out/list.ll -O3

shared.ll: shared.c | out
	clang shared.c -S -emit-llvm -o out/shared.ll -O3

str.ll: str.c | out
	clang str.c -S -emit-llvm -o out/str.ll -O3

out:
	mkdir out
