#ifndef DICT_H
#define DICT_H
#include "shared.h"
#include <stdbool.h>

typedef struct {
	// todo: actually user a hashing method
	struct dict_eles { ll key, val; } *eles;
	ll len, cap;
	bool (*eql)(ll, ll);
} dict;

dict *allocate_dict(bool (*eql)(ll,ll), ll cap);
bool fetch_from_dict(dict *l, ll *key, ll *out);
void insert_into_dict(dict *l, ll *key, ll *val);
bool has_key(dict *l, ll *key);

#endif
