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

#include "list.h"
#include "str.h"
ll length1(list *l) {
	return l->len;
}

ll length2(str *s) {
	return s->len;
}
