#include "str.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

str *allocate_str(ll length) {
	str *s = xmalloc(sizeof(str));

	s->ptr = xmalloc(length);
	s->len = length;

	return s;
}

str *create_str_from_borrowed(const char *c) {
	str *s = allocate_str(strlen(c));
	s->ptr = strdup(c);
	return s;
}

void print_str(const str *s) {
	printf("%.*s", (int) s->len, s->ptr);
	fflush(stdout);
}

void println_str(const str *s) {
	printf("%.*s\n", (int) s->len, s->ptr);
	fflush(stdout);
}

str *substr(const str *s, ll start, ll len) {
	str *sub = allocate_str(len);
	memcpy(sub->ptr, s->ptr + start, len);
	return sub;
}

str *num_to_str(ll num) {
	str *s = allocate_str(42); // 42 max size for ll

	sprintf(s->ptr, "%lld", num);
	s->len = strlen(s->ptr);

	return s;
}

ll str_to_num(const str *s) {
	// there's a better way to do it than this lol
	char tmp[1024];
	strncpy(tmp, s->ptr, sizeof(tmp)-1);
	return strtoll(tmp, NULL, 10);
}

ll str_to_ascii(const str *s) {
	return s->ptr[0];
}

str *ascii_to_str(ll ascii) {
	str *s = allocate_str(1);

	s->ptr[0] = ascii;

	return s;
}

int compare_strs(const str *lhs, const str *rhs) {
	if (lhs == rhs)
		return 0;

	// there's a more efficient way of doing this with simd or somethin, but whatever
	for (ll diff, i = 0; i < lhs->len && i < rhs->len; ++i)
		if ((diff = lhs->ptr[i] - rhs->ptr[i]))
			return diff < 0 ? -1 : 1;

	return lhs->len < rhs->len ? -1 : lhs->len == rhs->len ? 0 : 1;
}

str *concat_strs(const str *lhs, const str *rhs) {
	str *s = allocate_str(lhs->len + rhs->len);

	memcpy(s->ptr, lhs->ptr, lhs->len);
	memcpy(s->ptr + lhs->len, rhs->ptr, rhs->len);

	return s;
}

str *repeat_str(const str *src, ll amnt) {
	if (amnt <= 0)
		return NULL;

	str *s = allocate_str(src->len * amnt);

	for (char *ptr = s->ptr; amnt--; ptr += src->len)
		memcpy(ptr, src->ptr, src->len);

	return s;
}
