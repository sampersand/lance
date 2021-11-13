#include <stdlib.h>
#include "shared.h"

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

void quit(ll val) {
	exit(val);
}
