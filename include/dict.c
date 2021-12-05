#include "dict.h"

#define LLSIZE (sizeof(ll))

dict *allocate_dict(bool (*eql)(ll,ll), ll cap) {
	if (cap == 0) cap = 1; // for the realloc function

	dict *d = xmalloc(sizeof(dict));

	d->eles = xmalloc(sizeof(struct dict_eles) * cap);
	d->eql = eql;
	d->len = 0;
	d->cap = cap;

	return d;
}

bool fetch_from_dict(dict *d, ll *key, ll *out) {
	for (ll i = 0; i < d->len; ++i)
		if (d->eql(*key, d->eles[i].key))
			return *out = d->eles[i].val, true;

	return false;
}

void insert_into_dict(dict *d, ll *key, ll *val) {
	ll i;
	for (i = 0; i < d->len; ++i)
		if (d->eql(*key, d->eles[i].key)) {
			d->eles[i].val = *val;
			return;
		}

	if (d->len == d->cap)
		d->eles = xrealloc(d->eles, sizeof(struct dict_eles) * (d->cap *= 2));

	d->eles[d->len].key = *key;
	d->eles[d->len++].val = *val;
}

bool has_key(dict *l, ll *key) {
	ll dst;
	return fetch_from_dict(l, key, &dst);
}
