#ifndef STRING_H
#define STRING_H
#include "shared.h"

typedef struct {
	char *ptr;
	ll len;
} str;

str *allocate_str(ll length);
void print_str(const str *str);
str *substr(const str *str, ll start, ll len);

str *num_to_str(ll num);
ll str_to_num(const str *str);
str *ascii_to_str(ll ascii);
ll str_to_ascii(const str *str);
int compare_strs(const str *lhs, const str *rhs);

str *concat_strs(const str *lhs, const str *rhs);
str *repeat_str(const str *lhs, ll amnt);
#endif
