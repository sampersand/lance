#include <stdlib.h>
#include <stdio.h>
#include <math.h>
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
