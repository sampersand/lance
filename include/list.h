#ifndef LIST_H
#define LIST_H
#include "shared.h"
#include <stdbool.h>

typedef struct {
	ll *ptr, cap, len;
} list;

list *allocate_list(ll cap);
list *concat_lists(const list *l, const list *r);
list *repeat_list(const list *l, ll amnt);
ll insert_into_list(list *l, ll *ele, ll pos);
ll delete_from_list(list *l, ll *dst, ll pos);

#endif
