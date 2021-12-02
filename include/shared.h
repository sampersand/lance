#ifndef SHARED_H
#define SHARED_H
typedef long long ll;

void *xmalloc(ll);
void *xrealloc(void *, ll);
void quit(ll);

struct _str;
void abort_msg(struct _str *msg);
#endif
