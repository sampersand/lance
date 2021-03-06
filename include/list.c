#include "list.h"
#include "str.h"
#include <string.h>
#include <stdio.h>

#define LLSIZE (sizeof(ll))

list *allocate_list(ll cap) {
	if (cap == 0) cap = 1; // for the realloc function

	list *l = xmalloc(sizeof(list));

	l->ptr = xmalloc(LLSIZE*cap);
	l->len = 0;
	l->cap = cap;

	return l;
}

list *concat_lists(const list *lhs, const list *rhs) {
	list *l = allocate_list(lhs->len + rhs->len);
	l->len = lhs->len + rhs->len;

	memcpy(l->ptr, lhs->ptr, lhs->len*LLSIZE);
	memcpy(l->ptr + lhs->len, rhs->ptr, rhs->len*LLSIZE);

	return l;

}

list *repeat_list(const list *src, ll amnt) {
	list *l = allocate_list(src->len * amnt);
	l->len = src->len * amnt;

	for (ll *ptr = l->ptr; amnt--; ptr += src->len)
		memcpy(ptr, src->ptr, src->len*LLSIZE);

	return l;
}

ll insert_into_list(list *l, ll pos, ll *ele) {
	if (l->len < pos || pos < 0)
		return false;

	if (l->cap == l->len)
		l->ptr = xrealloc(l->ptr, (l->cap *= 2)*LLSIZE);

	for (ll i = l->len + 1; i >= pos; --i) {
		l->ptr[i] = l->ptr[i-1];
		// memmove(l->ptr + i*ele_size, l->ptr + (i-1)*ele_size, ele_size);
	}

	// memmove(l->ptr + pos + 1, l->ptr + pos, LLSIZE*(l->len - pos)+1);

	l->ptr[pos] = *ele;
	l->len++;

	return true;
}

ll delete_from_list(list *l, ll *dst, ll pos) {
	if (l->len <= pos || pos < 0)
		return false;

	*dst = l->ptr[pos];
	memmove(l->ptr + pos-1, l->ptr + pos, LLSIZE*(l->len - pos));

	l->len--;

	return true;
}

void push_into_list(list *l, ll *ele) {
	if (l->cap == l->len)
		l->ptr = xrealloc(l->ptr, (l->cap *= 2)*LLSIZE);
	l->ptr[l->len++] = *ele;
}

void pop_from_list(list *l, ll *out) {
	if (!l->len)
		abort_msg(create_str_from_borrowed("popped from an empty list"));

	*out = l->ptr[--l->len];
}

