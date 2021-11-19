#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "shared.h"
#include "str.h"

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

void abort_msg(struct _str *s) {
	fprintf(stderr, "%.*s\n", (int) s->len, s->ptr);
	quit(1);
}

ll powll(ll base, ll exp) {
	return pow(base, exp);
}

ll random_(void) {
	srandomdev();
	return random();
}

struct _str *prompt(void) {
	char *line = NULL;
	size_t alloc_len;
	ssize_t len = getline(&line, &alloc_len, stdin);
	str *s = allocate_str(0);
	free(s->ptr);

	s->len = len;
	s->ptr = line;
	return s;
}
