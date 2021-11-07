#include "list.h"
#include <string.h>
#include <stdio.h>

list *allocate_list(ll cap, ll ele_size) {
	list *l = xmalloc(sizeof(list));

	l->ptr = xmalloc(ele_size * cap);
	l->len = 0;
	l->cap = cap;

	return l;
}

list *concat_lists(const list *lhs, const list *rhs, ll ele_size) {
	list *l = allocate_list(lhs->len + rhs->len, ele_size);
	l->len = lhs->len + rhs->len;

	memcpy((char *) l->ptr, lhs->ptr, lhs->len * ele_size);
	memcpy((char *) l->ptr + lhs->len * ele_size, rhs->ptr, rhs->len * ele_size);

	return l;

}

list *repeat_list(const list *src, ll amnt, ll ele_size) {
	list *l = allocate_list(src->len * amnt, ele_size);
	l->len = src->len * amnt;

	for (char *ptr = l->ptr; amnt--; ptr += src->len * ele_size)
		memcpy(ptr, src->ptr, src->len * ele_size);

	return l;
}

ll insert_into_list(list *l, void *ele, ll pos, ll ele_size) {
	if (l->len < pos || pos < 0)
		return false;

	if (l->cap == l->len)
		l->ptr = xrealloc(l->ptr, (l->cap *= 2) * ele_size);

	// for (ll i = l->len + 1; i >= pos; --i) {
		// ((ll*)l->ptr)[i] = ((ll*)l->ptr)[i-1];
		// memmove(l->ptr + i*ele_size, l->ptr + (i-1)*ele_size, ele_size);
	// }

	memmove(l->ptr + (pos + 1)*ele_size, l->ptr + pos*ele_size, ele_size * (l->len - pos)+1);
	memmove(l->ptr + pos*ele_size, ele, ele_size);

	l->len++;

	return true;
}

ll delete_from_list(list *l, void *dst, ll pos, ll ele_size) {
	if (l->len < pos || pos < 0)
		return false;

	memmove(dst, l->ptr + pos*ele_size, ele_size);
	memmove(l->ptr + (pos-1)*ele_size, l->ptr + pos*ele_size, ele_size * (l->len - pos));
	l->len--;

	return true;
}


void assign_list(list *l, ll ele, ll ele_size) {
	(void) l;
	(void) ele;
	(void) ele_size;
	// if (ele_size)
	// ((char *)ll->ptr)[ele_size * ele]
	// ll*p = (ll*)l->ptr;

	// for (ll i = 0; i < 10; ++i)
	// 	*p = l2, ++p;
	// l->len = 10;
}

void dump_list(list *l) {
	printf("l=%p\n", l);
	printf("cap=%lld\n", l->cap);
	printf("len=%lld\n", l->len);

	for (int i = 0; i < l->len; ++i)
		printf("l[%d]=%lld\n", i, ((ll*) l->ptr)[i]);
}
