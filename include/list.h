#ifndef LIST_H
#define LIST_H
#include "shared.h"
#include <stdbool.h>

typedef struct {
	void *ptr;
	ll cap, len;
} list;

list *allocate_list(ll cap, ll ele_size);
list *concat_lists(const list *l, const list *r, ll ele_size);
list *repeat_list(const list *l, ll amnt, ll ele_size);
ll insert_into_list(list *l, void *ele, ll pos, ll ele_size);
ll delete_from_list(list *l, void *dst, ll pos, ll ele_size);

void lc_list_assign(list *l, ll ele, ll ele_size);
void dump_list(list *l);
#endif
