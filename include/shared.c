#include <stdlib.h>
#include "shared.h"
#include "str.h"
#include <stdio.h>

void *xmalloc(ll len) {
	void *ptr = malloc(len);
	if (len && !ptr) abort();
	return ptr;
}

void *xrealloc(void *ptr, ll len) {
	ptr = realloc(ptr, len);
	if (len && !ptr) abort();
	return ptr;
}

void abort_msg(str *msg) {
	fprintf(stderr, "%*s\n", (int) msg->len, msg->ptr);
	quit(1);
}

void quit(ll val) {
	exit(val);
}
